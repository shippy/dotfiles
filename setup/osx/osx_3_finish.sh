#!/bin/bash
# Post-install cleanup

# 0. Ensure that ~/Library/LaunchAgents, ~/Library/Spotlight have the correct permissions
# NOTE: Are they wrong? Check permissions on another Mac

# 1. Hide XQuartz
# open /Applications/Utilities/XQuartz.app/Contents/Info.plist
# insert:
#   <key>LSUIElement</key>
#   <true/>
# at the end of the plist>dict tag

# 2. Install prey (prompt for API key?)
#   API_KEY="abcdef123456" brew cask install prey

# 3. Run Creative Cloud installer (open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app)
open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app
# 3b. Install Photoshop and Lightroom (no CLI?)

# 4. Set up mutt, mbsync (TODO: What does that even entail, now? Do I have to turn on the plist?)

## 5. Indeterminate tasks
# - Install Matlab, Psychtoolbox
# https://www.mathworks.com/help/install/ug/install-noninteractively-silent-installation.html
# - Install Cisco Anyconnect (not publicly available??)
# Any potential follow-up gems (perhaps default settings for irb / pry)
# - ssh key + ssh config
# - /etc/hosts (which can't be in the dotfiles)

# - Get shit-ton of preferences and files from Time Machine backup
# - Register Apple ID if not done before
# - Run and set up: Hyperswitch, Flux
# - Spotify, Slack, Skype, Steam & GOG Downloader, AZ Drive & other cloud services, RescueTime, Pomotodo, Anki, GitHub Desktop
#
# - Download Dash doclets
# - Download used Docker images (Jupyter)
# - Chrome extension visibility?
# - Delete iMovie
