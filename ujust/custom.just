import "./setup-flatpaks.just"
import "./setup-brews.just"
import "./setup-steam.just"
import "./setup-ssh.just"
import "./setup-git.just"
import "./download-dotfiles.just"
import "./download-fonts.just"
import "./setup-asdf.just"
import "./setup-ngrok.just"

[group('PostInstall')]
do-post-install: \
  setup-flatpaks \
  setup-brews \
  setup-steam \
  setup-ssh \
  setup-git \
  download-dotfiles \
  download-fonts \
  setup-asdf \
  setup-ngrok
