#!/bin/bash
apt-add-repository -y ppa:byteit101/frc-toolchain
apt-get update
apt-get install -y wine1.6 winetricks zsh g++-mingw-w64 devscripts
echo "Please download wix310-binaries.zip from https://wix.codeplex.com/downloads/get/1483378 (Needs JS to download)"
