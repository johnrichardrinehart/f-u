#include "libf-u/src/include/flake.hh"
#include <memory>
#include <iostream>
#include <sstream>

namespace foo {

void create_stuff() {
	nix::initNix(true);
	nix::initGC();

	nix::fetchers::Settings fetchSettings;

	bool readOnly = false;
	nix::EvalSettings settings = nix::EvalSettings{readOnly, {}};

	auto store = nix::openStore();

	auto state = nix::EvalState({}, store, fetchSettings, settings);
}

} // namespace foo
