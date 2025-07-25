#!/bin/bash

echo "We Will Create The Base NIX Directories for JNIX..."
echo "Please Wait..."

## Why time? so you know how long it took to create directories, duh.
time sudo mkdir -p /nix/System/Sys && time sudo mkdir -p /nix/System/GIT && time sudo mkdir /nix/Users

echo "Done Creating Main Directory Layout, Proceed Cloning Dotfiles.
Thank you!."
