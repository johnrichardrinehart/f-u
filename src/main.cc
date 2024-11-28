#include <sstream>

#include <nix/english.hh>
//#include <eval-settings.hh>

int main() {
  std::stringstream ss;
  nix::pluralize(ss, 1, "single", "plural");
  std::cout << "got: " << ss.str() << std::endl;
  return 0;
}
