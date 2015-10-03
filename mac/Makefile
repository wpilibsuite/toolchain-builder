include ../versions.sh

export PATH:="${PWD}/gcc-install/usr/bin:${PWD}/binutils-install/usr/bin:${PATH}"
export CC=/usr/local/bin/gcc-4.9
export CXX=/usr/local/bin/g++-4.9
export CPP=/usr/local/bin/cpp-4.9
export LD=/usr/local/bin/gcc-4.9
alias c++=/usr/local/bin/c++-4.9
alias g++=/usr/local/bin/g++-4.9
alias gcc=/usr/local/bin/gcc-4.9
alias cpp=/usr/local/bin/cpp-4.9
alias ld=/usr/local/bin/gcc-4.9
alias cc=/usr/local/bin/gcc-4.9


all: clean sysroot binutils gcc gdb tree pkg
	

sysroot:
	rm -rf sysroot-*
	mkdir sysroot-libc-linux
	cd sysroot-libc-linux && tar xf ../../libc6-frc-armel-cross_$(Va_LIBC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../linux-libc-dev-frc-armel-cross_$(Va_LINUX).orig.tar.bz2
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
	cd makes/pkg/build && tar czf FRC\ ARM\ Toolchain.pkg.tar.gz FRC\ ARM\ Toolchain.pkg
	cp makes/pkg/build/FRC\ ARM\ Toolchain.pkg.tar.gz .

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install makes/pkg/build *.pkg.tar.gz

