include ../versions.sh

all: clean sysroot binutils gcc gdb tree tarpkg


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

tarpkg:
	mkdir -p frc$(V_YEAR)
	mkdir -p frc$(V_YEAR)/roborio
	cp -R tree-install/usr/local/* frc$(V_YEAR)/roborio/
	tar czf FRC-$(V_YEAR)-Linux-Toolchain-$(V_GCC).tar.gz frc$(V_YEAR)

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install gdb* *-Toolchain-*.tar.gz

