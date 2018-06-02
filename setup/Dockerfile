# This Dockerfile is a proof of concept for setting up the dotfiles in a couple of commands.
# It also works as a test.
FROM ubuntu:14.04

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git zsh vim python

# Create the non-privileged user
RUN groupadd -r test && useradd --no-log-init -r -g test test --shell /usr/bin/zsh
RUN mkdir -p /home/test && chown -R test:test /home/test

# Create the env
USER test
WORKDIR /home/test
RUN git clone --recurse-submodules https://github.com/shippy/dotfiles && chown -R test:test /home/test/dotfiles
# Alternatively, to get around git clone caching:
# COPY --chown=test:test dotfiles /home/test/dotfiles
RUN cd /home/test/dotfiles && dotty/dotty.py -r setup_common.json
# Once Vundle is taken out, this should work non-interactively, but currently it gets stuck:
# RUN vim +PluginInstall +qall
