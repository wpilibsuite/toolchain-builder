V_BINUTILS=2.24
V_GCC=4.9.1
V_SYSROOT=1.0
V_GDB=7.8

all: 
	@echo "please specify which you want. binutils must be installed before gcc"

sysroot:
	tar xf ../roborio-sysroot_$(V_SYSROOT).orig.tar.gz
	mv sysroot sysroot-$(V_SYSROOT)
	V_SYSROOT=$(V_SYSROOT) makes/sysroot

binutils:
	tar xf ../binutils-$(V_BINUTILS).tar.bz2
	V_BINUTILS=$(V_BINUTILS) makes/binutils
	
gdb:
	tar xf ../gdb-$(V_GDB).tar.gz
	V_GDB=$(V_GDB) makes/gdb

gcc:
	@# gcc does its own extraction
	makes/gcc
	
tree:
	V_GCC=$(V_GCC) makes/tree
	
pkg:
	freeze makes/pkg/FRC\ ARM\ Toolchain.packproj
	cp makes/pkg/build/FRC\ ARM\ Toolchain.pkg .

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install makes/pkg/build *.pkg

