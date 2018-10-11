include ../versions.sh

all: clean sysroot binutils gcc gdb tree zip


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

expat-install: expat
expat:
	tar xf ../expat-$(Vw_EXPAT).tar.bz2
	V_YEAR=$(V_YEAR) Vw_EXPAT=$(Vw_EXPAT) makes/expat

gdb: expat-install
	tar xf ../gdb-$(V_GDB).tar.gz
	V_YEAR=$(V_YEAR) V_GDB=$(V_GDB) makes/gdb

gcc:
	@# gcc does its own extraction
	makes/gcc

tree:
	V_YEAR=$(V_YEAR) V_GCC=$(V_GCC) makes/tree

zip:
	cd tree-install/c/Users/Public && zip -r ../../../../FRC-$(V_YEAR)-Windows-Toolchain-$(V_GCC).zip .

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install expat* gdb* *-Toolchain-*.zip

