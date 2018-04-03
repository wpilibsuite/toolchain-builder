#!/bin/bash
apt-add-repository -y ppa:byteit101/frc-toolchain
apt-get update
apt-get install -y wine1.6 winetricks zsh g++-mingw-w64 devscripts
