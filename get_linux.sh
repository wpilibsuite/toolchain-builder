mkdir headers
git clone git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
cd linux-stable-rt
git checkout v3.2.35-rt52
make INSTALL_HDR_PATH=$PWD/../usr ARCH=arm headers_install
find $PWD/../usr/include \( -name .install -o -name ..install.cmd \) -delete
cd ..
tar cjf linux-headers.tar.bz2 usr

