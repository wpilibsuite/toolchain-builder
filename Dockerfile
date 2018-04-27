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

COPY windows/ /build/windows/

WORKDIR /build/windows

RUN dpkg -i /packages/*.deb \
  && make sysroot binutils gcc gdb tree \
  && rm -rf binutils* roborio* sysroot* gcc* expat* gdb*

#
# Windows toolchain installer build
#

FROM suchja/wine:latest AS build-msi

# Update winetricks
USER root

RUN curl -SL https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -o winetricks \
  && chmod +x winetricks \
  && mv -v winetricks /usr/local/bin

ENV WINEDEBUG -all,err+all

# Install .NET Framework 4.0
USER xclient
RUN wine wineboot --init \
  && bash -c 'while pgrep -u xclient wineserver > /dev/null; do sleep 1; done' \
  && winetricks --unattended dotnet40 dotnet_verifier \
  && bash -c 'while pgrep -u xclient wineserver > /dev/null; do sleep 1; done'

# Install wix3.10 binaries

RUN mkdir -p build/windows/wix \
  && cd build/windows/wix \
  && curl -SL https://github.com/wixtoolset/wix3/releases/download/wix3104rtm/wix310-binaries.zip -o wix310-binaries.zip \
  && unzip wix310-binaries.zip \
  && rm wix310-binaries.zip

ENV V_YEAR=2019

# Set up symlink for shorter paths
RUN cd ~/.wine/dosdevices \
  && ln -s /home/xclient/build/windows/tree-install/c/frc${V_YEAR} s:

# Copy tree and msi build script

WORKDIR /home/xclient/build/windows

COPY --from=build-linux /build/windows/tree-install tree-install
COPY --from=build-linux /build/windows/makes makes

# Remove pb_ds as paths are too long there
USER root
RUN rm -rf /home/xclient/build/windows/tree-install/c/frc${V_YEAR}/arm-frc${V_YEAR}-linux-gnueabi/include/c++/*/ext/pb_ds

# Build msi
USER xclient
RUN bash makes/msi

#
# Build standalone packages image
#

FROM scratch
COPY --from=build-linux /packages /packages
COPY --from=build-msi /home/xclient/build/windows/msi-build/*.msi /packages/
