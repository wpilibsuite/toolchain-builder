include ../versions.sh

export PATH:="${PWD}/gcc-install/usr/bin:${PWD}/binutils-install/usr/bin:${PATH}"
export CC=/usr/local/bin/gcc-6
export CXX=/usr/local/bin/g++-6
export CPP=/usr/local/bin/cpp-6
export LD=/usr/local/bin/gcc-6
alias c++=/usr/local/bin/c++-6
alias g++=/usr/local/bin/g++-6
alias gcc=/usr/local/bin/gcc-6
alias cpp=/usr/local/bin/cpp-6
alias ld=/usr/local/bin/gcc-6
alias cc=/usr/local/bin/gcc-6


all: clean sysroot binutils gcc gdb tree pkg


sysroot:
	rm -rf sysroot-*
	mkdir sysroot-libc-linux
	cd sysroot-libc-linux && tar xf ../../libc6-frc2019-armel-cross_$(Va_LIBC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../linux-libc-dev-frc2019-armel-cross_$(Va_LINUX).orig.tar.bz2
	makes/sysroot

binutils:
	tar xf ../binutils-$(V_BINUTILS).tar.bz2
	V_BINUTILS=$(V_BINUTILS) makes/binutils
	echo 'export PATH=$$PATH:${PWD}/binutils-install/usr/bin'

gdb:
	tar xf ../gdb-$(V_GDB).tar.gz
	V_GDB=$(V_GDB) makes/gdb

gcc:
	@# gcc does its own extraction
	makes/gcc
	echo "export PATH=$$PATH:${PWD}/gcc-install/usr/bin"

tree:
	V_GCC=$(V_GCC) makes/tree

pkg:
	rm -rf makes/pkg/build/
	freeze makes/pkg/FRC\ ARM\ Toolchain.packproj
	ls -la makes/pkg/build
	cd makes/pkg/build && tar czf FRC-$(V_YEAR)-Mac-Toolchain-$(V_GCC)-Installer.pkg.tar.gz FRC\ 2019\ ARM\ Toolchain.pkg
	cp makes/pkg/build/FRC-$(V_YEAR)-Mac-Toolchain-$(V_GCC)-Installer.pkg.tar.gz .

tarpkg:
	mkdir -p frc2019
	mkdir -p frc2019/roborio
	rm -rf frc2019/robotio
	cp -R tree-install/usr/local frc2019/roborio
	tar czf FRC-$(V_YEAR)-Mac-Toolchain-$(V_GCC).tar.gz frc2019

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install makes/pkg/build *.pkg.tar.gz *-Toolchain-*.tar.gz

