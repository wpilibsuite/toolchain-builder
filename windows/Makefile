include ../versions.sh

all: sysroot binutils gcc gdb tree msi
	

sysroot:
	rm -rf sysroot-*
	mkdir sysroot-libc-linux
	cd sysroot-libc-linux && tar xf ../../libc6-frc-armel-cross_$(Va_LIBC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../linux-libc-dev-frc-armel-cross_$(Va_LINUX).orig.tar.bz2
	makes/sysroot

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
	
msi:
	makes/msi

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install msi-build

