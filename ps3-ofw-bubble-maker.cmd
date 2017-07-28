
:reset

@echo off


title PS3 OFW Bubble Maker                                        esc0rtd3w 2017


set sleepTime=1
set sleep=ping -n %sleepTime% 127.0.0.1

set ip=0.0.0.0


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
set dOneChunkZero=%pathTemplateGamePKG%\%pkgNumberBase%\d1_chunk0.bin
set dOneChunkOne=%pathTemplateGamePKG%\%pkgNumberBase%\d1_chunk1.bin
set dOneChunkTwo=%pathTemplateGamePKG%\%pkgNumberBase%\d1_chunk2.bin
set dOneChunkThree=%pathTemplateGamePKG%\%pkgNumberBase%\d1_chunk3.bin
set dOneTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\d1.pdb
set fZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\f0.pdb
set iconFileTemplate=%pathTemplateGamePKG%\%pkgNumberBase%\ICON_FILE

set createAnotherBubble=0



:menu

if not exist "%pathOutput%" mkdir "%pathOutput%"

color 0e

cls
echo Package Number Base [%pkgNumberBase%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
echo Drag Package or Enter Path and Press ENTER:
echo.
echo.

set /p pkgInput=

echo f | xcopy /y %pkgInput% "%pathOutput%\%pkgNumberBase%\%pkgName%"


:installText
cls
echo Package Number Base [%pkgNumberBase%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
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

xcopy /y "%dOneChunkZero%" "%pathOutput%\%pkgNumberBase%\*"
xcopy /y "%dOneChunkOne%" "%pathOutput%\%pkgNumberBase%\*"
xcopy /y "%dOneChunkTwo%" "%pathOutput%\%pkgNumberBase%\*"
xcopy /y "%dOneChunkThree%" "%pathOutput%\%pkgNumberBase%\*"


copy /y "%pathOutput%\%pkgNumberBase%\d0_chunk1.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk2.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk3.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk4.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk5.bin" "%pathOutput%\%pkgNumberBase%\d0.pdb"

copy /y "%pathOutput%\%pkgNumberBase%\d0_chunk1.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk2.bin"+"%pathOutput%\%pkgNumberBase%\d1_chunk0.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk4.bin"+"%pathOutput%\%pkgNumberBase%\d0_chunk5.bin"+"%pathOutput%\%pkgNumberBase%\d1_chunk1.bin"+"%pathOutput%\%pkgNumberBase%\d1_chunk2.bin"+"%pathOutput%\%pkgNumberBase%\d1_chunk3.bin" "%pathOutput%\%pkgNumberBase%\d1.pdb"



:getIcon
cls
echo Package Number Base [%pkgNumberBase%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
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
del /f /q "%pathOutput%\%pkgNumberBase%\d1_chunk0.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d1_chunk1.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d1_chunk2.bin"
del /f /q "%pathOutput%\%pkgNumberBase%\d1_chunk3.bin"


::set pathRemote=%pathRemote%/%pkgNumberBase%

:: If IP Address already set, use previous
if %ip%==0.0.0.0 goto getIP
if not %ip%==0.0.0.0 goto doFTP


:getIP
cls
echo Package Number Base [%pkgNumberBase%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
echo Enter PS3 IP Address and press ENTER:
echo.
echo.

set /p ip=


:doFTP
cls
echo Package Number Base [%pkgNumberBase%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
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
echo mkdir %pathRemote%/%pkgNumberBase%>>%tempFile%
echo cd %pathRemote%/%pkgNumberBase%>>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%pkgName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%dZeroName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%dOneName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%fZeroName%">>%tempFile%
echo put "%pathOutput%\%pkgNumberBase%\%iconFileName%">>%tempFile%
echo quit>>%tempFile%
ftp -n -s:%tempFile% %ip%
del /f /q %tempFile%


:finish
set anotherBubbleChoice=n

cls
echo Create Another Bubble?
echo.
echo.
echo Y) Yes
echo.
echo N) No
echo.
echo.

set /p anotherBubbleChoice=


if %anotherBubbleChoice%==y set createAnotherBubble=1
if %anotherBubbleChoice%==Y set createAnotherBubble=1
if %anotherBubbleChoice%==n set createAnotherBubble=0
if %anotherBubbleChoice%==N set createAnotherBubble=0

set /a pkgNumberBase=%pkgNumberBase%+1
set installTextInput=

if %createAnotherBubble%==1 goto menu



:end

::pause

