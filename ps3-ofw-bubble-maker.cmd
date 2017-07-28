@echo off


title PS3 OFW Bubble Maker                                        esc0rtd3w 2017


set sleepTime=1
set sleep=ping -n %sleepTime% 127.0.0.1


set tempFile="%temp%\ps3-ofw-bubble-maker---temp.txt"
set tempText="%temp%\ps3-ofw-bubble-maker---temp---installText.txt"

set pkgNumberBase=80000000
set pkgTotal=1

set pkgName=000000000000000000000000000000001.pkg
set dZeroName=d0.pdb
set dOneName=d1.pdb
set fZeroName=f0.pdb
set iconFileName=ICON_FILE

set dZeroChunkData=d0_chunk1.bin+d0_chunk2.bin+d0_chunk3.bin+d0_chunk4.bin+d0_chunk5.bin

set root=%~dp0
set pathOutput=%root%\output\vsh\game_pkg
set pathRemote=/dev_hdd0/vsh/game_pkg

:: Template Variables
set pathTemplate=%root%\template
set pathTemplateVSH=%pathTemplate%\dev_hdd0\vsh
set pathTemplateGamePKG=%pathTemplateVSH%\game_pkg
set pkgTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\000000000000000000000000000000001.pkg
set dZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\d0.pdb
set dZeroChunkOne=%pathTemplateGamePKG%\%pkgNumberBase%\d0_chunk1.bin
set dZeroChunkTwo=%pathTemplateGamePKG%\%pkgNumberBase%\d0_chunk2.bin
set dZeroChunkThree=%pathTemplateGamePKG%\%pkgNumberBase%\d0_chunk3.bin
set dZeroChunkFour=%pathTemplateGamePKG%\%pkgNumberBase%\d0_chunk4.bin
set dZeroChunkFive=%pathTemplateGamePKG%\%pkgNumberBase%\d0_chunk5.bin
set dOneTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\d1.pdb
set fZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\f0.pdb
set iconFileTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\ICON_FILE



:menu

if not exist "%pathOutput%" mkdir "%pathOutput%"

color 0e

cls
echo Drag Package or Enter Path and Press ENTER:
echo.
echo.

set /p pkgInput=

echo f | xcopy /y %pkgInput% "%pathOutput%\%pkgNumberBase%\%pkgName%"


cls
echo Enter Install Text (47 Chars Max) and Press ENTER:
echo.
echo.

set /p installTextInput=

echo %installTextInput%>"%pathOutput%\%pkgNumberBase%\d0_chunk2.bin"
echo %pkgNumberBase%>"%pathOutput%\%pkgNumberBase%\d0_chunk4.bin"

:: Build d0.pdb and d1.pdb
xcopy /y "%dZeroChunkOne%" "%pathOutput%\%pkgNumberBase%\*"
::xcopy /y "%dZeroChunkTwo%" "%pathOutput%\%pkgNumberBase%\d0_chunk2.bin"
xcopy /y "%dZeroChunkThree%" "%pathOutput%\%pkgNumberBase%\*"
::xcopy /y "%dZeroChunkFour%" "%pathOutput%\%pkgNumberBase%\d0_chunk4.bin"
xcopy /y "%dZeroChunkFive%" "%pathOutput%\%pkgNumberBase%\*"
xcopy /y "%fZeroTemplate%" "%pathOutput%\%pkgNumberBase%\*"


copy /y "%pathOutput%\%pkgNumberBase%\d0_chunk1.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk2.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk3.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk4.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk5.bin" "%pathOutput%\%pkgNumberBase%\d0.pdb"
copy /y "%pathOutput%\%pkgNumberBase%\d0.pdb" "%pathOutput%\%pkgNumberBase%\d1.pdb"




cls
echo Drag Icon (320x176 PNG) For Package and Press ENTER:
echo.
echo.

set /p iconInput=

copy /y %iconInput% "%pathOutput%\%pkgNumberBase%\%iconFileName%"


:: Cleanup
del /f /q "%pathOutput%\%pkgNumberBase%\d0_chunk1.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d0_chunk2.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d0_chunk3.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d0_chunk4.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d0_chunk5.bin"


set pathRemote=%pathRemote%\%pkgNumberBase%


:getIP
cls
echo Current IP: %ip%
echo.
echo.
echo Enter PS3 IP Address and press ENTER:
echo.
echo.

set /p ip=


echo.
echo.
echo.
echo Sending Bubbles to %ip%@%remotePath%....
echo.
echo.
echo cd "%pathOutput%">%tempFile%
echo user ps3>>%tempFile%
echo ps3>>%tempFile%
echo bin>>%tempFile%
echo cd %pathRemote%>>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%pkgName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%dZeroName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%dOneName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%fZeroName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%iconFileName%">>%tempFile%
echo quit>>%tempFile%
ftp -n -s:%tempFile% %ip%
del /f /q %tempFile%




:end

pause

