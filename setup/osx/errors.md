# sleepwatcher symlink fails
ruby-completion, rake-completion failed to download?

# plist to LaunchAgents fails -- maybe we touched it badly?

# Potential additions
https://asepsis.binaryage.com
http://blog.coldflake.com/posts/Minimal-Development-Setup-for-Mac-OS/ for `irb` and Gemfile

# Not installed
Cisco AnyConnect
Prey (requires API code)
Adobe CC apps
Matlab + PTB
ssh key + ssh config
/etc/hosts
Docker Jupyter image
anaconda / Jupyter
rbenv ruby version (latest, global?)
any gems

# Not set
Almost any of the preferences
Chrome plugin visibility in toolbar
# box-edit fails
box-edit cask failed
==> Caveats
Box Edit currently only works with Safari and Firefox.
Restart your browser to load the plugin.

==> Downloading https://e3.boxcdn.net/box-installers/boxedit/mac/currentrelease/BoxToolsInstaller.dmg
==> No checksum defined for Cask box-edit, skipping verification

# tranquility, utorrent, lightroom, photoshop casks fail
transquility -> tranquility
utorrent unavailable

lightroom, photoshop not installed after installing Creative Cloud

# Prey needs API key
==> Caveats
Prey requires your API key, found in the bottom-left corner of
the Prey web account Settings page, to complete installation.
The API key may be set as an environment variable as follows:

  API_KEY="abcdef123456" brew cask install prey

  ==> Downloading https://prey-releases.s3.amazonaws.com/node-client/1.6.5/prey-mac-1.6.5-x86.pkg
  ==> Verifying checksum for Cask prey
  ==> Running installer for prey; your password may be necessary.
  ==> Package installers may write to any location; options such as --appdir are ignored.
  Error: Command failed to execute!

  ==> Failed command:
  /usr/bin/sudo -E -- /usr/sbin/installer -pkg #<Pathname:/usr/local/Caskroom/prey/1.6.5/prey-mac-1.6.5-x86.pkg> -target /

  ==> Standard Output of failed command:
  No API Key provided. Stopping here.


  ==> Standard Error of failed command:
  installer: Error -  Pre install check failed. Try again.


  ==> Exit status of failed command:
#<Process::Status: pid 42134 exit 1>
  Error: nothing to install
  ==> No API Key provided. Stopping here.
  ==> installer: Error -  Pre install check failed. Try again.


# vimrc contains plugin-dependent calls before plugins can be installed
Before vim +PluginInstall +qall
Error detected while processing /Users/Simon/.vimrc:
line  810:
E117: Unknown function: yankstack#setup

(Solution: check for yankstack existence, or somehow figure out whether Vundle has been run?)

