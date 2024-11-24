#include "libf-u/src/include/flake.hh"
#include <memory>
#include <iostream>

namespace foo {

std::unique_ptr<Flake> read_flake() {
	return std::make_unique<Flake>();
}

Flake::~Flake() { }

void hello() {
	std::cout << "hey there!" << std::endl;
}

} // namespace foo
