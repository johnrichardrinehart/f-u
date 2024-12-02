#include "libf-u/src/include/flake.hh"
#include <memory>
#include <iostream>
#include <sstream>

namespace foo {

FlakeInput::FlakeInput(std::string id): id(id) {}

rust::String FlakeInput::to_string() const {
	std::string id = this->id;
	return id;
}

Flake::Flake(nix::flake::Flake flake): f(flake) {}

Flake::~Flake() { }

std::unique_ptr<std::vector<FlakeInput>> Flake::list_inputs() const {
  std::vector<FlakeInput> vec {};

  auto inputs = (this->f).inputs;

  for (const auto & [key, _value] : inputs) {
    vec.emplace_back(FlakeInput(std::string(key)));
  }

  return std::make_unique<std::vector<FlakeInput>>(vec);
}

std::unique_ptr<Flake> get_flake(rust::String flakeRef, bool allowLookup) {
	nix::initNix(true);
	nix::initGC();

	nix::fetchers::Settings fetchSettings;
	nix::FlakeRef r = nix::parseFlakeRef(fetchSettings, flakeRef.c_str());

	bool readOnly = false;
	auto settings = nix::EvalSettings(readOnly);

	auto store = nix::openStore();

	nix::LookupPath path;
	auto state = nix::EvalState(path, store, fetchSettings, settings);

	nix::flake::Flake f = nix::flake::getFlake(state, r, allowLookup);

	return std::make_unique<Flake>(Flake(f));
}

rust::String pluralize(
    unsigned int count,
    const rust::Str single,
    const rust::Str plural) {
	auto sview = std::string_view(single.data(), single.size());
	auto pview = std::string_view(plural.data(), plural.size());
	std::ostringstream os;
	nix::pluralize(os, count, sview, pview);
	return os.str();
}

void hello() {
	std::cout << "hey there!" << std::endl;
}

} // namespace foo
