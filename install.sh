#!/bin/sh

# Symlink files
stow .

# Rebuild bat cache
bat cache --build
