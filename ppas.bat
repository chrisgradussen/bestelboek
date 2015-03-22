@echo off
SET THEFILE=project1.or
echo Linking %THEFILE%
c:\lazarus\fpc\2.4.3\bin\i386-win32\fpcres.exe -o project1.or -a i386 -of coff  "@project1.reslst"
if errorlevel 1 goto linkend
SET THEFILE=bestelboek1.exe
echo Linking %THEFILE%
c:\lazarus\fpc\2.4.3\bin\i386-win32\ld.exe -b pe-i386 -m i386pe  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o bestelboek1.exe link.res
if errorlevel 1 goto linkend
c:\lazarus\fpc\2.4.3\bin\i386-win32\postw32.exe --subsystem gui --input bestelboek1.exe --stack 16777216
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
