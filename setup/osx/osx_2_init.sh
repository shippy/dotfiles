#!/bin/bash
# Taken mostly from donnemartin/dev-setup and siyelo/laptop
# (which, I assume, also means significant credit to mathiasbynens/dotfiles)
# Feel free to run osx_defaults.sh first
#
# TODO: Integrate https://github.com/jasonrudolph/keyboard

# Ask for the administrator password for the duration of this script
sudo -v

# Keep-alive: update existing sudo time stamp until .osx has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "Updating OSX.  If this requires a restart, run the script again."
# Install all available updates
sudo softwareupdate -ia
# Install only recommended available updates
#sudo softwareupdate -ir

if ! command -v cc >/dev/null; then
  echo "Installing Xcode Command Line Tools."
  # Install Xcode command line tools
  xcode-select --install
fi

# Step 2: Install latest Homebrew
if ! command -v brew >/dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew & latest formulae
brew update && brew upgrade

# Step 3: Get dotfiles
# Install git
brew install git

# Clone dotfiles
if [ ! -d "~/dotfiles" ]; then
  echo "Cloning shippy/dotfiles"
  git clone --recursive https://github.com/shippy/dotfiles ~/dotfiles
fi

# Step 4: Install git and everything else that is right and proper
echo "Installing everything from the dotfiles' Brewfile"
brew bundle --file=~/dotfiles/setup/osx/Brewfile

cd ~/dotfiles
python3 dotty/dotty.py -r setup_common.json
python3 dotty/dotty.py -r setup/osx.json

vim +PluginInstall +qall &> /dev/null

# Change to the new shell, prompts for password
sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
chsh -s /usr/local/bin/zsh

# Set up latest version of Ruby
eval "(rbenv init -)"
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv rehash
rbenv global $(rbenv install -l | grep -v - | tail -1)
# Credit to mislav: http://stackoverflow.com/a/30191850

# Install essential gems
cd ~
gem install bundler
bundle install

# Step 5: Install brew casks and Mac App Store apps
echo "Installing applications from Homebrew Casks and the App Store"
brew bundle --file=~/dotfiles/setup/osx/Caskfile
brew bundle --file=~/dotfiles/setup/osx/Caskfile_personal

# Create default associations where appropriate, using duti
# Kudos to https://www.chainsawonatireswing.com/2013/09/19/changing-default-applications-on-a-mac-using-the-command-line-then-a-shell-script
brew install duti
duti ~/dotfiles/setup/osx/ft_app_associations.duti
# FIXME: Does this need to be repeated on every startup?
# Per https://technology.siprep.org/using-duti-to-script-default-applications-for-macs/.
# Perhaps with `outset`? https://github.com/chilcote/outset

# Step 6: Remove outdated versions from the cellar
brew cleanup
