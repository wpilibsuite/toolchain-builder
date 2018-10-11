#!/bin/sh

docker pull wpilib/toolchain-builder:18.04 \
 && docker run -v ${PWD}:/artifacts wpilib/toolchain-builder:18.04 bash -c "\
  cp /artifacts/download.sh /artifacts/repack.sh /artifacts/versions.sh . \
  && cp -R /artifacts/deb /artifacts/tools /artifacts/linux /artifacts/windows . \
  && zsh download.sh \
  && zsh repack.sh \
  && cd linux \
  && make sysroot \
  && sudo cp sysroot-install/usr/local/* /usr/local/ -r \
  && make binutils \
  && sudo cp binutils-install/usr/local/* /usr/local/ -r \
  && make gcc \
  && sudo cp gcc-install/usr/local/* /usr/local/ -r \
  && cd ../windows \
  && make sysroot binutils gcc gdb tree zip \
  && cp *.zip /artifacts/"
