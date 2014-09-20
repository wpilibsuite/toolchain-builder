# Mac requires wget & native GNU GCC 4.9 build
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install wget
brew tap homebrew/versions
brew install gcc49 gnu-tar expat
# you also need to set AR to a good ar that actually can extract  ilk files (deb)
echo alias ar=gar
echo alias tar=gtar
# for packaging you need this:
curl -O http://s.sudre.free.fr/Software/files/Iceberg.dmg