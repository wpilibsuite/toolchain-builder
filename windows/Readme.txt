Please download wix310-binaries.zip from https://wix.codeplex.com/downloads/get/1483378 (Needs JS to download) and extract into the wix folder such that windows/wix/light.exe exists

The makefiles are set up to work on debian-based systems and will not work on Windows. You must cross compile

To avoid having the build fail in gen.wxs due to long pathnames, it's necessary to map a drive letter to the tree-install/c/frc directory (create a symlink in ~/.wine/dosdevices/).
