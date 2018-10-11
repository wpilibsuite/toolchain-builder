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


all: clean sysroot binutils gcc gdb tree pkg tarpkg


sysroot:
	rm -rf sysroot-*
	mkdir sysroot-libc-linux
	cd sysroot-libc-linux && tar xf ../../libc6-frc$(V_YEAR)-armel-cross_$(Va_LIBC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../linux-libc-dev-frc$(V_YEAR)-armel-cross_$(Va_LINUX).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../libgcc1-frc$(V_YEAR)-armel-cross_$(Va_LIBGCC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../libstdc++6-frc$(V_YEAR)-armel-cross_$(Va_LIBSTDCPP).orig.tar.bz2
	makes/sysroot

binutils:
	tar xf ../binutils-$(V_BINUTILS).tar.bz2
	V_YEAR=$(V_YEAR) V_BINUTILS=$(V_BINUTILS) makes/binutils

gdb:
	tar xf ../gdb-$(V_GDB).tar.gz
	V_YEAR=$(V_YEAR) V_GDB=$(V_GDB) makes/gdb

gcc:
	@# gcc does its own extraction
	makes/gcc

tree:
	V_YEAR=$(V_YEAR) V_GCC=$(V_GCC) makes/tree

pkg:
	rm -rf makes/pkg/build/
	freeze makes/pkg/FRC\ ARM\ Toolchain.packproj
	ls -la makes/pkg/build
	cd makes/pkg/build && tar czf FRC-$(V_YEAR)-Mac-Toolchain-$(V_GCC)-Installer.pkg.tar.gz FRC\ $(V_YEAR)\ ARM\ Toolchain.pkg
	cp makes/pkg/build/FRC-$(V_YEAR)-Mac-Toolchain-$(V_GCC)-Installer.pkg.tar.gz .

tarpkg:
	mkdir -p frc$(V_YEAR)
	mkdir -p frc$(V_YEAR)/roborio
	cp -R tree-install/usr/local/* frc$(V_YEAR)/roborio/
	tar czf FRC-$(V_YEAR)-Mac-Toolchain-$(V_GCC).tar.gz frc$(V_YEAR)

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install gdb* makes/pkg/build *.pkg.tar.gz *-Toolchain-*.tar.gz

