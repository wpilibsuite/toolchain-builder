#!/bin/bash

export PATH=${PWD}/gcc-install/usr/bin:${PWD}/binutils-install/usr/bin:${PATH}

make sysroot
sudo cp sysroot-install/usr/local/* /usr/local/ -r
make binutils
sudo cp binutils-install/usr/local/* /usr/local/ -r
make gcc gdb tree tarpkg
