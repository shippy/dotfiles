## How to use

1. Prior to usage, install git and fetch dotty. (You might need to do basic git setup first.)
2. Run `dotty/dotty.py -r setup_common.json`, plus the additional config for whatever machine you're on (`setup/osx.json`, ...)
3. Run `git submodule update --init --recursive --remote`.

## To do

* Get a better sync manager than dotty.
* Figure out a consistent way to update submodules and *actually move HEAD to newest version* on every pull. `git submodule sync`, `git submodule foreach git pull --rebase` as a `post-receive` or `post-update` hook? Alternatively, `git submodule update --remote`?
* Figure out a way to not update HEAD position for oh-my-zsh and dotvim on every change that happens. (Take them out of the repo?)
* Make every added submodule automatically track the master branch (`git submodule add -b master <url>`)
