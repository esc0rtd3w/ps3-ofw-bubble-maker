
:reset

@echo off


title PS3 OFW Bubble Maker for DTU Method                                        esc0rtd3w 2017


:: Set "1" To Enable Debug Output
set debug=0

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

set dZeroChunkData=d0_chunk1.bin+d0_chunk2.bin+d0_chunk3.bin
set dOneChunkData=d1_chunk1.bin+d1_chunk2.bin+d1_chunk3.bin+d1_chunk4.bin+d1_chunk5.bin

set root=%~dp0
set pathBin=%root%\bin
set pathOutput=%root%\output\vsh
set pathRemote=/dev_hdd0/vsh

set patch="%pathBin%\gpatch.exe" /nologo
set patchRecursive="%pathBin%\gpatch.exe" /nologo /r
set patchData=0
set patchIndex=/i
set patchHex=/h
set patchLength=/n
set patchString=/s

set cocolor="%pathBin%\cocolor.exe"
set newFile="%pathBin%\newfile.exe"
set partCopy="%pathBin%\partcopy.exe"


:: Set Terminal Colors
set black=%cocolor% 00
set blue=%cocolor% 01
set green=%cocolor% 02
set aqua=%cocolor% 03
set red=%cocolor% 04
set purple=%cocolor% 05
set yellow=%cocolor% 06
set white=%cocolor% 07
set grey=%cocolor% 08
set lblue=%cocolor% 09
set lgreen=%cocolor% 0a
set laqua=%cocolor% 0b
set lred=%cocolor% 0c
set lpurple=%cocolor% 0d
set lyellow=%cocolor% 0e
set lwhite=%cocolor% 0f


:: Template Variables
set pkgNumberBaseTemplate=80000000
set pathTemplate=%root%\template
set pathTemplateVSH=%pathTemplate%\dev_hdd0\vsh
set pathTemplateGamePKG=%pathTemplateVSH%\game_pkg
set pathTemplateTask=%pathTemplateVSH%\task
set pkgTemplate=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\000000000000000000000000000000001.pkg
set dZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d0.pdb
set dZeroChunkOne=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d0_chunk1.bin
set dZeroChunkTwo=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d0_chunk2.bin
set dZeroChunkThree=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d0_chunk3.bin
set dOneChunkOne=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d1_chunk1.bin
set dOneChunkTwo=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d1_chunk2.bin
set dOneChunkThree=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d1_chunk3.bin
set dOneChunkFour=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d1_chunk4.bin
set dOneChunkFive=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d1_chunk5.bin
set dOneTemplate=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\d1.pdb
set fZeroTemplate=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\f0.pdb
set iconFileTemplate=%pathTemplateGamePKG%\%pkgNumberBaseTemplate%\ICON_FILE

set createAnotherBubble=0

set charsMax=47
set charsTotal=0
set charsPadding=0

:: 47 Spaces
set paddingData=                                               



:menu

if not exist "%pathOutput%\game_pkg\%pkgNumberBase%" mkdir "%pathOutput%\game_pkg\%pkgNumberBase%"
if not exist "%pathOutput%\task\%taskNumberBase%" mkdir "%pathOutput%\task\%taskNumberBase%"

color 0e

cls
echo Package Number Base [%pkgNumberBase%]
echo Package File [%pkgInput%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
%laqua%
echo Drag Package or Enter Path and Press ENTER:
%lyellow%
echo.
echo.

set /p pkgInput=

echo f | xcopy /y %pkgInput% "%pathOutput%\game_pkg\%pkgNumberBase%\%pkgName%"


:installText
cls
echo Package Number Base [%pkgNumberBase%]
echo Package File [%pkgInput%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
%laqua%
echo Enter Install Text (47 Chars Max) and Press ENTER:
%lyellow%
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
set /a charsPaddingTemp=47-%charsTotalTemp%

::set /p paddingData=<%temp%\installTextInputPadding.txt



del /f /q "%temp%\installTextInput.txt"
del /f /q "%temp%\charsTotal.txt"

:: If too many characters entered, return to installText again
if %charsTotal% gtr 47 goto installText

set /a charsPadding=%charsMax%-%charsTotal%


if %debug%==1 (
cls
echo Max Chars: %charsMax%
echo Total Chars: %charsTotal%
echo Padding Chars: %charsPadding%
echo Padding: %paddingData%
pause
)


:: ------------
:: Build d0.pdb
:: ------------

:: Chunk 1
:: Copy From Template
xcopy /y "%dZeroChunkOne%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"

:: Chunk 2
:: Copy From Template and Use the 47 byte file filled with spaces as a patch base for Install Text
copy /y %dZeroChunkTwo% "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"
%patch% "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin" /i0 /n%charsTotal% /s"%installTextInput%"

:: Chunk 3
:: Copy From Template
xcopy /y "%dZeroChunkThree%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"


:: ------------
:: Build d1.pdb
:: ------------

:: Chunk 1
:: Copy From Template
xcopy /y "%dOneChunkOne%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"

:: Chunk 2
:: The d1 value is the same as d0, so copy the chunk2 from d0
copy /y "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin" "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk2.bin"

:: Chunk 3
:: Copy From Template
xcopy /y "%dOneChunkThree%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"

:: Chunk 4
:: Copy From Template and Create chunk4 from current Package ID
copy /y %dOneChunkFour% "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk4.bin"
%patch% "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk4.bin" /i0 /n8 /s"%pkgNumberBase%"

:: Chunk 5
:: Copy From Template
xcopy /y "%dOneChunkFive%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"


:: ------------
:: Build f0.pdb
:: ------------

:: Copy f0 File (zero-byte file)
xcopy /y "%fZeroTemplate%" "%pathOutput%\game_pkg\%pkgNumberBase%\*"


:: -------------------------------------
:: Create New Database Files From Chunks
:: -------------------------------------

:: Create Temp d0 File From Chunks For Patching
copy /y "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk1.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk3.bin" "%pathOutput%\game_pkg\%pkgNumberBase%\d0_temp.pdb"

:: Create Temp d1 File From Chunks For Patching
copy /y "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk1.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk2.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk3.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk4.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk5.bin" "%pathOutput%\game_pkg\%pkgNumberBase%\d1_temp.pdb"


:: Create New Valid d0.pdb and d1.pdb Files By Trimming 1 byte from the end (fix later)
%partCopy% "%pathOutput%\game_pkg\%pkgNumberBase%\d0_temp.pdb"  "%pathOutput%\game_pkg\%pkgNumberBase%\d0.pdb" 0h 146h
%partCopy% "%pathOutput%\game_pkg\%pkgNumberBase%\d1_temp.pdb"  "%pathOutput%\game_pkg\%pkgNumberBase%\d1.pdb" 0h 17ch


:: Cleanup All Temp Chunk Data
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk1.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2a.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2b.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk3.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk1.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk2.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk3.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk4.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk4_default.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_chunk5.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_temp.pdb"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d1_temp.pdb"



:getIcon
cls
echo Package Number Base [%pkgNumberBase%]
echo Package File [%pkgInput%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
%laqua%
echo Drag Icon (320x176 PNG) For Package and Press ENTER:
%lyellow%
echo.
echo.

set /p iconInput=

copy /y %iconInput% "%pathOutput%\game_pkg\%pkgNumberBase%\%iconFileName%"
copy /y %iconInput% "%pathOutput%\task\%taskNumberBase%\%iconFileName%"


:: If IP Address already set, use previous
if %ip%==0.0.0.0 goto getIP
if not %ip%==0.0.0.0 goto doFTP


:getIP
cls
echo Package Number Base [%pkgNumberBase%]
echo Package File [%pkgInput%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
%laqua%
echo Enter PS3 IP Address and press ENTER:
%lyellow%
echo.
echo.

set /p ip=


:doFTP
cls
echo Package Number Base [%pkgNumberBase%]
echo Package File [%pkgInput%]
echo Install Text [%installTextInput%]
echo IP Address [%ip%]
echo.
echo.
echo.
%laqua%
echo Sending Bubbles to %ip%@%remotePath%....
%lyellow%
echo.
echo.

:: Create Text File With FTP Commands
echo user ps3>>%tempFile%
echo ps3>>%tempFile%
echo bin>>%tempFile%
echo mkdir %pathRemote%>>%tempFile%
echo mkdir %pathRemote%/game_pkg>>%tempFile%
echo mkdir %pathRemote%/game_pkg/%pkgNumberBase%>>%tempFile%
echo cd %pathRemote%/game_pkg/%pkgNumberBase%>>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%pkgName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%dZeroName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%dOneName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%fZeroName%">>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%iconFileName%">>%tempFile%
echo mkdir %pathRemote%/task>>%tempFile%
echo mkdir %pathRemote%/task/%taskNumberBase%>>%tempFile%
echo cd %pathRemote%/task/%taskNumberBase%>>%tempFile%
echo put "%pathOutput%\game_pkg\%pkgNumberBase%\%iconFileName%">>%tempFile%
echo quit>>%tempFile%

:: Activate FTP Session
ftp -n -s:%tempFile% %ip%

:: Remove FTP Commands Text File
del /f /q %tempFile%


:finish

:: Increase Package ID Number
set /a pkgNumberBase=%pkgNumberBase%+1

:: Reset Package Install Text
set installTextInput=

:: Set Default New Bubble Choice
set anotherBubbleChoice=n

cls
echo Create Another Bubble?
echo.
echo Next Package ID Number [%pkgNumberBase%]
echo.
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

if %createAnotherBubble%==1 goto menu



:end



if %debug%==1 (
pause
)

