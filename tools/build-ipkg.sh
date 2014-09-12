#!/bin/zsh

LIBS=(/usr/arm-frc-linux-gnueabi/lib/libstdc++.so.6.0.20 /usr/arm-frc-linux-gnueabi/lib/libatomic.so.1.1.0 /usr/arm-frc-linux-gnueabi/lib/libssp.so.0.0.0 /usr/arm-frc-linux-gnueabi/lib/libasan.so.1.0.0 /usr/arm-frc-linux-gnueabi/lib/libitm.so.1.0.0)
VERSION=`apt-cache show libstdc++6-frc-armel-cross | sed -n 's/Version: //p'`

function strip_suffix() 
{
	echo "$1" | sed 's,^/usr/arm-frc-linux-gnueabi,,'
}
function dodh()
{
	echo " " dh_$1
	fakeroot dh_$1 -plibstdc++6-4.9 || exit $?
}

rm -rf ipkg-tmp-build
mkdir -p ipkg-tmp-build/debian/libstdc++6-4.9/DEBIAN
pushd ipkg-tmp-build
cat > debian/libstdc++6-4.9/DEBIAN/control <<EOL
Package: libstdc++6-4.9
Version: ${VERSION}
Description: GNU Standard C++ Library v3
 This package contains an additional runtime library for C++ programs
 built with the GNU compiler.
 .
 This package contains updated files from $VERSION g++ for use in FRC C++
 programs only.
Section: libs
Priority: optional
Maintainer: WPI Toolchain Developers <phplenefisch@wpi.edu>
License: GPLv3+ w/GCC runtime library exception
Architecture: armv7a-vfp-neon

EOL
cat > debian/postinst <<EOL
#!/bin/sh
if [ x"$D" = "x" ]; then
	if [ -x /sbin/ldconfig ]; then /sbin/ldconfig ; fi
fi

EOL
echo 9 > debian/compat
ln -s $PWD/debian/libstdc++6-4.9/DEBIAN/control debian/control
for lib in $LIBS; do
	echo `strip_suffix $lib`
	TO_FILE=debian/libstdc++6-4.9/`strip_suffix $lib`
	mkdir -p `dirname $TO_FILE`
	cp $lib $TO_FILE
	chrpath -d $TO_FILE
done
pushd debian/libstdc++6-4.9/lib
	ln -s libasan.so.1.0.0 libasan.so.1
	ln -s libatomic.so.1.1.0 libatomic.so.1
	ln -s libitm.so.1.0.0 libitm.so.1
	ln -s libssp.so.0.0.0 libssp.so.0
popd

dodh compress 
dodh installdeb
dodh fixperms
dodh md5sums
dodh builddeb
popd
mv libstdc++6-4.9_${VERSION}_armv7a-vfp-neon.deb libstdc++6-4.9_4.9.1-0build0_armv7a-vfp-neon.ipk

