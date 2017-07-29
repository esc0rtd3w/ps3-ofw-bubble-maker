
:reset

@echo off


title PS3 OFW Bubble Maker                                        esc0rtd3w 2017


:: Set "1" To Enable Debug Output
set debug=1

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

:: 47 Spaces
set paddingData=                                               



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

%sleep%

setlocal enabledelayedexpansion

set /p charsTotalTemp=<%temp%\charsTotal.txt
set /a charsPaddingTemp=47-%charsTotalTemp%

:: Some Super Hacky Padding
for %%a in (%charsPaddingTemp%) do (
    for /f "tokens=*" %%F in ("%%a") do (
	   set /a num=%%F
       set spaces=
       if !num! equ 47 set spaces=.
       if !num! equ 46 set spaces= .
       if !num! equ 45 set spaces=  .
       if !num! equ 44 set spaces=   .
       if !num! equ 43 set spaces=    .
       if !num! equ 42 set spaces=     .
       if !num! equ 41 set spaces=      .
       if !num! equ 40 set spaces=       .
       if !num! equ 39 set spaces=        .
       if !num! equ 38 set spaces=         .
       if !num! equ 37 set spaces=          .
       if !num! equ 36 set spaces=           .
       if !num! equ 35 set spaces=            .
       if !num! equ 34 set spaces=             .
       if !num! equ 33 set spaces=              .
       if !num! equ 32 set spaces=               .
       if !num! equ 31 set spaces=                .
       if !num! equ 30 set spaces=                 .
       if !num! equ 29 set spaces=                  .
       if !num! equ 28 set spaces=                   .
       if !num! equ 27 set spaces=                    .
       if !num! equ 26 set spaces=                     .
       if !num! equ 25 set spaces=                      .
       if !num! equ 24 set spaces=                       .
       if !num! equ 23 set spaces=                        .
       if !num! equ 22 set spaces=                         .
       if !num! equ 21 set spaces=                          .
       if !num! equ 20 set spaces=                           .
       if !num! equ 19 set spaces=                            .
       if !num! equ 18 set spaces=                             .
       if !num! equ 17 set spaces=                              .
       if !num! equ 16 set spaces=                               .
       if !num! equ 15 set spaces=                                .
       if !num! equ 14 set spaces=                                 .
       if !num! equ 13 set spaces=                                  .
       if !num! equ 12 set spaces=                                   .
       if !num! equ 11 set spaces=                                    .
       if !num! equ 10 set spaces=                                     .
       if !num! equ 9 set spaces=                                       .
       if !num! equ 8 set spaces=                                        .
       if !num! equ 7 set spaces=                                         .
       if !num! equ 6 set spaces=                                          .
       if !num! equ 5 set spaces=                                           .
       if !num! equ 4 set spaces=                                            .
       if !num! equ 3 set spaces=                                             .
       if !num! equ 2 set spaces=                                              .
       if !num! equ 1 set spaces=                                               .
       if !num! equ 0 set spaces=                                                .
       set "padding=!spaces!"
       echo !padding!>"%temp%\installTextInputPadding.txt"
    )
)

endlocal

set /p paddingData=<%temp%\installTextInputPadding.txt



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

:: Create Text (a) and Padding (b) Chunks
echo %installTextInput%>"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2a.bin"
echo %paddingData%>"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2b.bin"

:: Put Two Chunks Back Together
copy /y "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2a.bin"+"%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2b.bin" "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2.bin"

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
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2a.bin"
del /f /q "%pathOutput%\game_pkg\%pkgNumberBase%\d0_chunk2b.bin"
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

