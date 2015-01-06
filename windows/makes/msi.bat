
rd /s /q msi-build
xcopy makes\msi-files msi-build /s /e

wix\heat.exe dir tree-install\c\frc -sreg -gg -dr APPLICATIONFOLDER -cg BINUTILS -out msi-build\gen.wxs -var var.binutilsdir -srd
wix\candle.exe -nologo "-dbinutilsdir=tree-install\c\frc" "msi-build\gen.wxs" -out "msi-build\gen.wixobj"
wix\candle.exe -nologo "msi-build\frctoolchain.wxs" -out "msi-build\frctoolchain.wixobj"  -ext WixUIExtension
wix\light.exe -nologo "msi-build\frctoolchain.wixobj" "msi-build\gen.wixobj" -out "msi-build\FRC Toolchain.msi"  -ext WixUIExtension
