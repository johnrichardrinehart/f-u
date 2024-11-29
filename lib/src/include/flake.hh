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

void create_stuff();

}
