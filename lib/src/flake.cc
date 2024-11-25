#include "libf-u/src/include/flake.hh"
#include <memory>
#include <iostream>
#include <sstream>

namespace foo {

std::unique_ptr<Flake> read_flake() {
	return std::make_unique<Flake>();
}

Flake::~Flake() { }

std::unique_ptr<std::vector<FlakeInput>> Flake::list_inputs() const {
  std::vector<FlakeInput> vec{ FlakeInput() };
  return std::make_unique<std::vector<FlakeInput>>(vec);
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
