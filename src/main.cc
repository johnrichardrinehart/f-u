#include <sstream>

#include <nix/args.hh>
#include <nix/english.hh>
#include <nix/eval-gc.hh>
#include <nix/eval-settings.hh>
#include <nix/shared.hh>
#include <nix/store-api.hh>
#include <nix/eval-settings.hh>
#include <nix/fetch-settings.hh>
#include <nix/eval.hh>

int main() {
  nix::initNix();
  nix::initGC();

  bool readOnly = false;
  nix::EvalSettings settings = nix::EvalSettings{readOnly, {}};

  nix::fetchers::Settings fetchSettings;

  auto store = nix::openStore();

  auto state = nix::EvalState({}, store, fetchSettings, settings);

  return 0;
}
