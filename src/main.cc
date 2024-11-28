#include <sstream>

#include <nix/english.hh>
#include <nix/eval-settings.hh>

int main() {
  std::stringstream ss;
  nix::pluralize(ss, 1, "single", "plural");
  std::cout << "got: " << ss.str() << std::endl;

  bool readOnly = false;
  nix::EvalSettings settings = nix::EvalSettings{readOnly, {}};

  return 0;
}
