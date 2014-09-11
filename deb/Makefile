include ../versions.sh
DEBUILD_FLAGS ?= -us -uc

all: flags
	@echo "please specify which you want. binutils must be installed before gcc"
	
flags:
	echo "Using DEBUILG_FLAGS=$(DEBUILD_FLAGS)"

sysroot: libc6 linux-libc roborio-sysroot

roborio-sysroot:
	rm -rf roborio-sysroot*
	mkdir roborio-sysroot-${V_ROBORIO_SYSROOT}
	cp debians/sysroot roborio-sysroot-${V_ROBORIO_SYSROOT}/debian -r
	cd roborio-sysroot-${V_ROBORIO_SYSROOT} && debuild $(DEBUILD_FLAGS)
	
libc6:
	rm -rf libc6-*
	cp ../libc6-frc-armel-cross_$(Va_LIBC).orig.tar.bz2 ./
	tar xf libc6-frc-armel-cross_$(Va_LIBC).orig.tar.bz2
	cp debians/libc libc6-$(Va_LIBC)/debian -r
	cd libc6-$(Va_LIBC) && debuild $(DEBUILD_FLAGS)

linux-libc:
	rm -rf linux-libc-*
	cp ../linux-libc-dev-frc-armel-cross_$(Va_LINUX).orig.tar.bz2 ./
	tar xf linux-libc-dev-frc-armel-cross_$(Va_LINUX).orig.tar.bz2
	cp debians/linux-libc linux-libc-$(Va_LINUX)/debian -r
	cd linux-libc-$(Va_LINUX) && debuild $(DEBUILD_FLAGS)

binutils:
	rm -rf binutils-*
	cp ../binutils-$(V_BINUTILS).tar.bz2 binutils-frc-armel-cross_$(V_BINUTILS).orig.tar.bz2 
	tar xf binutils-frc-armel-cross_$(V_BINUTILS).orig.tar.bz2
	cp debians/binutils binutils-$(V_BINUTILS)/debian -r
	cd binutils-$(V_BINUTILS) && debuild $(DEBUILD_FLAGS)

gcc:
	cp ../gcc-$(V_GCC).tar.bz2 gcc-armel_$(V_GCC).orig.tar.bz2 
	tar xf gcc-armel_$(V_GCC).orig.tar.bz2
	cp debians/gcc gcc-$(V_GCC)/debian -r
	cd gcc-$(V_GCC) && debuild -us -uc
	
gdb:
	cp ../gdb-$(V_GDB).tar.gz gdb-armel-cross_$(V_GDB).orig.tar.gz
	tar xf  gdb-armel-cross_$(V_GDB).orig.tar.gz
	cp debians/gdb gdb-$(V_GDB)/debian -r
	cd gdb-$(V_GDB) && debuild -us -uc

clean:
	rm -rf binutils* roborio* sysroot* gcc*

