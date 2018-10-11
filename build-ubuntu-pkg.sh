#!/bin/sh

docker pull wpilib/toolchain-builder:18.04 \
 && docker run -v ${PWD}:/artifacts wpilib/toolchain-builder:18.04 bash -c "\
  cp /artifacts/download.sh /artifacts/repack.sh /artifacts/versions.sh . \
  && cp -R /artifacts/deb /artifacts/tools . \
  && zsh download.sh \
  && zsh repack.sh \
  && cd deb \
  && echo 'make flags' && make flags > /dev/null \
  && echo 'make sysroot' && make sysroot > /dev/null \
  && echo 'make binutils' && make binutils > /dev/null \
  && dpkg -i *.deb \
  && make gcc gdb gcc-defaults frcmake frc-toolchain \
  && dpkg -i *.deb \
  && cp *.deb /artifacts/" \
 && docker build -t wpilib/roborio-toolchain:2019-18.04 -f Dockerfile.packages .
