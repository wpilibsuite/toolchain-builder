# Mac requires wget & native GNU GCC 4.9 build
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install wget
brew tap homebrew/versions
brew install gcc49
# for packaging you need this:
curl -O http://s.sudre.free.fr/Software/files/Iceberg.dmg