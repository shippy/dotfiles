## How to use

1. Prior to usage, install git and fetch dotty. (You might need to do basic git setup first.)
2. Run `dotty/dotty.py -r common.json`, plus the additional config for whatever machine you're on (`osx.json`, ...)
3. Run `git submodule update --init --recursive`.

## To do

* Get a better sync manager than dotty.
* Figure out why keeping dotfiles updated across machines requires occasional additional merge (something to do with submodules)
