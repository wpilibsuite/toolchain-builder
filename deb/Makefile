V_BINUTILS=2.24
V_GCC=4.9.1
V_SYSROOT=1.0
V_GDB=7.8

all: 
	@echo "please specify which you want. binutils must be installed before gcc"

sysroot:
	cp ../roborio-sysroot_$(V_SYSROOT).orig.tar.gz roborio-sysroot_$(V_SYSROOT).orig.tar.gz
	tar xf roborio-sysroot_$(V_SYSROOT).orig.tar.gz
	cp debians/sysroot sysroot/debian -r
	mv sysroot sysroot-$(V_SYSROOT)
	cd sysroot-$(V_SYSROOT) && debuild -us -uc

binutils:
	cp ../binutils-$(V_BINUTILS).tar.bz2 binutils-armel-cross-frc_$(V_BINUTILS).orig.tar.bz2 
	tar xf binutils-armel-cross-frc_$(V_BINUTILS).orig.tar.bz2
	cp debians/binutils binutils-$(V_BINUTILS)/debian -r
	cd binutils-$(V_BINUTILS) && debuild -us -uc

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

