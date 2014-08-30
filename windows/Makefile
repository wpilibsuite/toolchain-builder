V_BINUTILS=2.24
V_GCC=4.9.1
V_SYSROOT=1.0

all: 
	@echo "please specify which you want. binutils must be installed before gcc"

sysroot:
	tar xf ../roborio-sysroot_$(V_SYSROOT).orig.tar.gz
	mv sysroot sysroot-$(V_SYSROOT)
	V_SYSROOT=$(V_SYSROOT) makes/sysroot

binutils:
	tar xf ../binutils-$(V_BINUTILS).tar.bz2
	V_BINUTILS=$(V_BINUTILS) makes/binutils

gcc:
	cp ../gcc-$(V_GCC).tar.bz2 gcc-armel_$(V_GCC).orig.tar.bz2 
	tar xf gcc-armel_$(V_GCC).orig.tar.bz2
	cp makes/gcc gcc-$(V_GCC)/debian -r
	cd gcc-$(V_GCC) && debuild -us -uc

clean:
	rm -rf binutils* roborio* sysroot* gcc*

