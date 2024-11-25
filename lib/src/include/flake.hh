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

struct FlakeInput { };

struct Flake {
  std::string name;
  ~Flake();

  rust::String get_name() const;

  std::unique_ptr<std::vector<FlakeInput>> list_inputs() const;
};

std::unique_ptr<Flake> get_flake(rust::String flakeRef, bool allowLookup);

rust::String pluralize(
    unsigned int count,
    const rust::Str single,
    const rust::Str plural);

void hello();

}
