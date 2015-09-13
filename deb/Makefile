include ../versions.sh
DEBUILD_FLAGS ?= -us -uc

all: flags sysroot binutils gcc gdb gcc-defaults frcmake frc-toolchain
	
	
flags:
	echo "Using DEBUILG_FLAGS=$(DEBUILD_FLAGS)"

sysroot: libc6 linux-libc roborio-sysroot

frcmake:
	rm -rf frcmake*
	tar xf ../frcmake-${V_FRCMAKE}.tar.bz2
	cp debians/frcmake frcmake-${V_FRCMAKE}/debian -r
	cd frcmake-${V_FRCMAKE} && debuild $(DEBUILD_FLAGS)

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
	rm -rf gcc-*
	cp ../gcc-$(V_GCC).tar.bz2 gcc-frc-armel-cross_$(V_GCC).orig.tar.bz2 
	tar xf gcc-frc-armel-cross_$(V_GCC).orig.tar.bz2
	cp debians/gcc gcc-$(V_GCC)/debian -r
	cd gcc-$(V_GCC) && debuild $(DEBUILD_FLAGS)
	
gcc-defaults:
	rm -rf gcc-defaults-frc-armel-cross*
	mkdir gcc-defaults-frc-armel-cross-${V_GCC_DEFAULTS}
	cp debians/gcc-versions gcc-defaults-frc-armel-cross-${V_GCC_DEFAULTS}/debian -r
	cd gcc-defaults-frc-armel-cross-${V_GCC_DEFAULTS} && debuild $(DEBUILD_FLAGS)
	
gdb:
	rm -rf gdb*
	cp ../gdb-$(V_GDB).tar.gz gdb-frc-armel-cross_$(V_GDB).orig.tar.gz
	tar xf  gdb-frc-armel-cross_$(V_GDB).orig.tar.gz
	cp debians/gdb gdb-$(V_GDB)/debian -r
	cd gdb-$(V_GDB) && debuild $(DEBUILD_FLAGS)
	
frc-toolchain:
	rm -rf frc-toolchain*
	mkdir frc-toolchain-1
	cp debians/frc-toolchain frc-toolchain-1/debian -r
	cd frc-toolchain-1 && debuild $(DEBUILD_FLAGS)

clean:
	find . -maxdepth 1 ! -name Makefile ! -name debians -type f -delete

