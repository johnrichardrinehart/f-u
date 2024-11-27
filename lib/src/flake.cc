#include "libf-u/src/include/flake.hh"
#include <memory>
#include <iostream>
#include <sstream>

namespace foo {

rust::String Flake::get_name() const {
	return this->name;
}

Flake::~Flake() { }

std::unique_ptr<std::vector<FlakeInput>> Flake::list_inputs() const {
  std::vector<FlakeInput> vec{ FlakeInput() };
  return std::make_unique<std::vector<FlakeInput>>(vec);
}

std::unique_ptr<Flake> get_flake(rust::String flakeRef, bool allowLookup) {
//	nix::initNix(true);
	nix::initNix();
	nix::initGC();

//	nix::experimentalFeatureSettings.experimentalFeatures = {
//		nix::Xp::Flakes,
//        };

//	nix::FetchSettings fetchSettings;

	//nix::FlakeRef r = nix::parseFlakeRef(fetchSettings, flakeRef.c_str());
	nix::FlakeRef r = nix::parseFlakeRef(flakeRef.c_str());

	bool readOnly = false;

	std::cout << "I'm here 2!!!" << std::endl;
	nix::ref<nix::Store> store = nix::openStore();

	std::cout << "I'm here 3!!!" << std::endl;
	nix::EvalSettings evalSettings(nix::evalSettings);
	//auto state = nix::EvalState({}, store, fetchSettings, evalSettings);
	auto state = nix::EvalState({}, store);

	std::cout << "I'm here 4!!!" << std::endl;
	nix::flake::Flake f = nix::flake::getFlake(state, r, allowLookup);

	return std::make_unique<Flake>(Flake{ name: "foo" });

//	std::cout << "I'm here!!!" << std::endl;
//
//	return "abc";
}

//rust::String pluralize(
//    unsigned int count,
//    const rust::Str single,
//    const rust::Str plural) {
//	auto sview = std::string_view(single.data(), single.size());
//	auto pview = std::string_view(plural.data(), plural.size());
//	std::ostringstream os;
//	nix::pluralize(os, count, sview, pview);
//	return os.str();
//}

void hello() {
	std::cout << "hey there!" << std::endl;
}

} // namespace foo
