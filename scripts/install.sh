#!/usr/bin/env bash
 
echo "Installing core applications ..."
sudo pacman -S vim htop neofetch

echo "Installing applications replacements ..."
sudo pacman -S exa bat ripgrep fd procs
