
:reset

@echo off


title PS3 OFW Bubble Maker                                        esc0rtd3w 2017


set sleepTime=1
set sleep=ping -n %sleepTime% 127.0.0.1

set ip=0.0.0.0


set tempFile="%temp%\ps3-ofw-bubble-maker---temp.txt"
set tempText="%temp%\ps3-ofw-bubble-maker---temp---installText.txt"

set taskNumberBase=00000000
set pkgNumberBase=80000000
set pkgTotal=1

set pkgName=000000000000000000000000000000001.pkg
set dZeroName=d0.pdb
set dOneName=d1.pdb
set fZeroName=f0.pdb
set iconFileName=ICON_FILE

set dZeroChunkData=d0_chunk1.bin+d0_chunk2.bin+d0_chunk3.bin+d0_chunk4.bin+d0_chunk5.bin

set root=%~dp0
set pathOutput=%root%\output\vsh
set pathRemote=/dev_hdd0/vsh

:: Template Variables
set pathTemplate=%root%\template
set pathTemplateVSH=%pathTemplate%\dev_hdd0\vsh
set pathTemplateGamePKG=%pathTemplateVSH%\game_pkg
set pathTemplateTask=%pathTemplateVSH%\task
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

set charsMax=47
set charsTotal=0
set charsPadding=0



:menu

if not exist "%pathOutput%\game_pkg\%pkgNumberBase%" mkdir "%pathOutput%\game_pkg\%pkgNumberBase%"
if not exist "%pathOutput%\task\%taskNumberBase%" mkdir "%pathOutput%\task\%taskNumberBase%"

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

echo f | xcopy /y %pkgInput% "%pathOutput%\game_pkg\%pkgNumberBase%\%pkgName%"


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

echo %installTextInput%>%temp%\installTextInput.txt

:: Get Characters
setlocal enabledelayedexpansion
set /p installTextInputTemp=<%temp%\installTextInput.txt
set "str=A!installTextInputTemp!"
set "len=0"

for /L %%A in (12,-1,0) do (
    set /a "len|=1<<%%A"
    for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
	echo !len!>%temp%\charsTotal.txt
)
endlocal

set /p charsTotal=<%temp%\charsTotal.txt

del /f /q "%temp%\installTextInput.txt"
del /f /q "%temp%\charsTotal.txt"

::cls
set /a charsPadding=%charsMax%-%charsTotal%
::echo Max Chars: %charsMax%
::echo Total Chars: %charsTotal%
::echo Padding Chars: %charsPadding%
::pause


:: If too many characters entered, return to installText again
if %charsTotal% gtr 47 goto installText

echo %installTextInput%>"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"
echo %pkgNumberBase%>"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk4.bin"

:: Build d0.pdb and d1.pdb
xcopy /y "%dZeroChunkOne%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"
::xcopy /y "%dZeroChunkTwo%" "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"
xcopy /y "%dZeroChunkThree%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"
::xcopy /y "%dZeroChunkFour%" "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk4.bin"
xcopy /y "%dZeroChunkFive%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"
xcopy /y "%fZeroTemplate%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"

xcopy /y "%dOneChunkZero%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"
xcopy /y "%dOneChunkOne%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"
xcopy /y "%dOneChunkTwo%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"
xcopy /y "%dOneChunkThree%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"


copy /y "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk1.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk3.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk4.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk5.bin" "%pathOutput%\game_pkg\%pkgNumberBase%\d0.pdb"

copy /y "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk1.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk0.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk4.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk5.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk1.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk2.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk3.bin" "%pathOutput%\game_pkg\%pkgNumberBase%\d1.pdb"



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

copy /y %iconInput% "%pathOutput%\game_pkg\%pkgNumberBase%\%iconFileName%"
copy /y %iconInput% "%pathOutput%\task\%taskNumberBase%\%iconFileName%"

:: Cleanup
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk1.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk3.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk4.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk5.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk0.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk1.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk2.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk3.bin"


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
echo user ps3>>%tempFile%
echo ps3>>%tempFile%
echo bin>>%tempFile%
echo mkdir %pathRemote%/game_pkg/%pkgNumberBase%>>%tempFile%
echo cd %pathRemote%/game_pkg/%pkgNumberBase%>>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%pkgName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%dZeroName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%dOneName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%fZeroName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%iconFileName%">>%tempFile%
echo mkdir %pathRemote%/task/%taskNumberBase%>>%tempFile%
echo cd %pathRemote%/task/%taskNumberBase%>>%tempFile%
echo put "%pathRemote%\task\%taskNumberBase%\%iconFileName%">>%tempFile%
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

set /a taskNumberBase=%taskNumberBase%+1
set /a pkgNumberBase=%pkgNumberBase%+1
set installTextInput=

if %createAnotherBubble%==1 goto menu



:end

::pause

