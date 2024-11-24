#pragma once
#include "rust/cxx.h"
#include <memory>
#include "nix/flake/flake.hh"

namespace foo {
struct Flake {
  ~Flake();
};

std::unique_ptr<Flake> read_flake();

void hello();

}
