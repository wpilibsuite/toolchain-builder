# Requires docker 17.05 or newer.
# For installation, see https://docs.docker.com/install/linux/docker-ce/ubuntu/
FROM ubuntu:18.04 AS build-linux

RUN apt-get update && apt-get install -y tzdata && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bc \
    binutils-dev \
    bison \
    build-essential \
    chrpath \
    cmake \
    debhelper \
    dejagnu \
    devscripts \
    docbook-xml \
    docbook-xsl \
    expat \
    file \
    flex \
    g++ \
    g++-mingw-w64 \
    g++-multilib \
    gawk \
    gcc \
    gcc-multilib \
    gdb \
    gettext \
    gperf \
    libbz2-dev \
    libc6-dev \
    libcap-dev \
    libcloog-isl-dev \
    libexpat1-dev \
    libgcc1 \
    libgmp-dev \
    liblzma-dev \
    libmpc-dev \
    libmpfr-dev \
    libncurses5-dev \
    libtool \
    libreadline-dev \
    lintian \
    make \
    ncurses-dev \
    patch \
    pkg-config \
    python-all-dev \
    quilt \
    rsync \
    subversion \
    texinfo \
    wget \
    xsltproc \
    xz-utils \
    zlib1g-dev \
    zsh \
  && rm -rf /var/lib/apt/lists/*

COPY download.sh repack.sh versions.sh /build/
COPY tools/ /build/tools/

WORKDIR /build

RUN zsh download.sh \
  && zsh repack.sh

COPY deb/ /build/deb/

WORKDIR /build/deb

RUN make flags sysroot binutils \
  && dpkg -i *.deb \
  && make gcc gdb gcc-defaults frcmake frc-toolchain \
  && mkdir /packages \
  && mv *.deb /packages/ \
  && make clean

# Build windows binaries
FROM build-linux AS build-windows

COPY windows/ /build/windows/

WORKDIR /build/windows

RUN dpkg -i /packages/*.deb \
  && make sysroot binutils gcc gdb tree zip \
  && rm -rf binutils* roborio* sysroot* gcc* expat* gdb*

#
# Build standalone packages image
#

FROM scratch AS linux-packages
COPY --from=build-linux /packages /packages

FROM scratch AS windows-packages
COPY --from=build-windows /build/windows/*.zip /packages/
