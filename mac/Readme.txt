# Mac requires wget & native GNU GCC 5.4 build
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install wget binutils
brew tap homebrew/versions
brew install gcc54 gnu-tar expat
# you also need to set AR to a good ar that actually can extract  ilk files (deb)
echo alias ar=gar
echo alias tar=gtar
# for packaging you need this:
curl -O http://s.sudre.free.fr/Software/files/Iceberg.dmg

# then:
make sysroot
sudo gcp sysroot-install/usr/local/* /usr/local/ -r 
make binutils
sudo gcp binutils-install/usr/local/* /usr/local/ -r

make gcc gdb tree pkg
