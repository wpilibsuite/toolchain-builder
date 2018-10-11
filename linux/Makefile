include ../versions.sh

#export PATH:="${PWD}/gcc-install/usr/bin:${PWD}/binutils-install/usr/bin:${PATH}"

all: clean sysroot binutils gcc gdb tree tarpkg

sysroot:
	rm -rf sysroot-*
	mkdir sysroot-libc-linux
	cd sysroot-libc-linux && tar xf ../../libc6-frc2019-armel-cross_$(Va_LIBC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../linux-libc-dev-frc2019-armel-cross_$(Va_LINUX).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../libgcc1-frc2019-armel-cross_$(Va_LIBGCC).orig.tar.bz2
	cd sysroot-libc-linux && tar xf ../../libstdc++6-frc2019-armel-cross_$(Va_LIBSTDCPP).orig.tar.bz2
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

tarpkg:
	mkdir -p frc2019
	mkdir -p frc2019/roborio
	cp -R tree-install/usr/local/* frc2019/roborio/
	tar czf FRC-$(V_YEAR)-Linux-Toolchain-$(V_GCC).tar.gz frc2019

clean:
	rm -rf binutils* roborio* sysroot* gcc* tree-install *-Toolchain-*.tar.gz

