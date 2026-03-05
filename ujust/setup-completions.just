[group('PostInstall')]
setup-completions:
  #!/bin/bash
  set -ex

  mkdir -p ${ZDOTDIR:-$HOME}/completions
  wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ${ZDOTDIR:-$HOME}/completions/_tmuxinator
