#pragma once

#include <optional>
#include <memory>
#include "rust/cxx.h"

#include "nix/english.hh"
#include "nix/eval.hh"
#include "nix/eval-gc.hh"
#include "nix/eval-settings.hh"
#include "nix/fetch-settings.hh"
#include "nix/flake/flake.hh"
#include "nix/flake/flakeref.hh"
#include "nix/shared.hh"
#include "nix/store-api.hh"

namespace foo {

struct SourcePath {
  nix::SourcePath path;
};

struct EvalState {
  EvalState();

  nix::EvalState state;

  std::unique_ptr<SourcePath> findFile(rust::Str path);
};

const EvalState & new_evalstate();

struct FlakeInput {
  std::string id;

  FlakeInput(std::string id);

  rust::String to_string() const;
};

typedef std::string FlakeId;


struct Flake {
  nix::flake::Flake f;

  Flake(nix::flake::Flake flake);

  ~Flake();

  std::unique_ptr<std::vector<FlakeInput>> list_inputs() const;
};

std::unique_ptr<Flake> get_flake(rust::String flakeRef, bool allowLookup);

rust::String pluralize(
    unsigned int count,
    const rust::Str single,
    const rust::Str plural);

}
