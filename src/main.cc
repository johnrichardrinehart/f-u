#include <sstream>

#include <nix/args.hh>
#include <nix/english.hh>
#include <nix/eval-gc.hh>
#include <nix/eval-settings.hh>
#include <nix/shared.hh>

int main() {
  std::stringstream ss;
  nix::pluralize(ss, 1, "single", "plural");
  std::cout << "got: " << ss.str() << std::endl;

  nix::initNix();
  nix::initGC();

  bool readOnly = false;
  nix::EvalSettings settings = nix::EvalSettings{readOnly, {}};

  return 0;
}
