#pragma once
#include "rust/cxx.h"
#include <memory>
//#include "nix/flake/flake.hh"
#include "nix/english.hh"

namespace foo {

struct FlakeInput { };

struct Flake {
  ~Flake();

  std::unique_ptr<std::vector<FlakeInput>> list_inputs() const;
};

std::unique_ptr<Flake> read_flake();

rust::String pluralize(
    unsigned int count,
    const rust::Str single,
    const rust::Str plural);

void hello();

}
