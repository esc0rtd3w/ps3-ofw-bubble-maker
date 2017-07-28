@echo off


title PS3 OFW Bubble Maker                                        esc0rtd3w 2017



set pkgNumberBase=80000000
set pkgTotal=1

set pkgName=000000000000000000000000000000001.pkg
set dZeroName=d0.pdb
set dOneName=d1.pdb
set fZeroName=f0.pdb
set iconFileName=ICON_FILE

set dZeroChunkData=db0_chunk1.bin+db0_chunk2.bin+db0_chunk3.bin+db0_chunk4.bin+db0_chunk5.bin

set pathInput=%~dp0input
set pathOutput=%~dp0output\vsh\game_pkg

:: Template Variables
set pathTemplate=%~dp0template
set pathTemplateVSH=%pathTemplate%\dev_hdd0\vsh
set pathTemplateGamePKG=%pathTemplateVSH%\game_pkg
set pkgTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\000000000000000000000000000000001.pkg
set dZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\d0.pdb
set dOneTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\d1.pdb
set fZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\f0.pdb
set iconFileTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\ICON_FILE



:menu
color 0e

cls
echo Drag Package or Enter Path and Press ENTER:
echo.
echo.

set /p pkgInput=



cls
echo Enter Install Text (47 Chars Max) and Press ENTER:
echo.
echo.

set /p installTextInput=



cls
echo Drag Icon (320x176 PNG) For Package and Press ENTER:
echo.
echo.

set /p iconInput=









:end

pause

