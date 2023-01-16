ECHO OFF
@pushd %~dp0 & fltmc | find "." && (powershell start '%~f0' ' %*' -verb runas 2>nul && exit /b)

CLS
:MENU
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom
ECHO ...............................................
ECHO.
ECHO 1 - Win10 Custom
ECHO 2 - Win11 Custom
ECHO.
ECHO 3 - Specifieke Apps Installeren
ECHO.
ECHO 4 - HDSentinel
ECHO 5 - CCleaner
ECHO 6 - Hardware Info
ECHO 7 - Partition Wizzard
ECHO 0 - EXIT
ECHO.
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO WIN10CUSTOM
IF %M%==2 GOTO WIN11CUSTOM
IF %M%==3 GOTO SAPPS
IF %M%==4 GOTO HDSentinel
IF %M%==5 GOTO CCleaner
IF %M%==6 GOTO HardwareInfo
IF %M%==7 GOTO PartitionWizzard
IF %M%==0 GOTO EOF

:WIN10CUSTOM
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\custom-apps-libreoffice.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\enable-desktop-shortcuts.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\change-drive-letter.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\startmenuw10.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\update.ps1"
GOTO MENU
:WIN11CUSTOM
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\custom-apps-libreoffice.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\enable-desktop-shortcuts.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\change-drive-letter.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\startmenuw11.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\update.ps1"
GOTO MENU
:HDSentinel
cd %~dp0\src\files\hdsentinel_pro_portable\
start HDSentinel.exe
GOTO MENU
:CCleaner
cd %~dp0\src\files\ccsetup607
start CCleaner.exe
GOTO MENU
:HardwareInfo
cd %~dp0\src\files\Hardware-Info
start HWiNFO64.exe
GOTO MENU
:PartitionWizzard
cd %~dp0\src\files\Partition-Wizard
start partitionwizard.exe
GOTO MENU
:SAPPS
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO 1 - Adobe-Reader
ECHO 2 - Google Chrome
ECHO 3 - Microsoft Edge
ECHO 4 - VLC
ECHO 5 - libreoffice
ECHO 6 - .NET Framework 4.8
ECHO 7 - TeamViewer
ECHO.
ECHO 0 - EXIT
ECHO.
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO AdobeReaderMenu
IF %M%==2 GOTO GoogleChromeMenu
IF %M%==3 GOTO MicrosoftEdgeMenu
IF %M%==4 GOTO VLCMenu
IF %M%==5 GOTO LibreofficeMenu
IF %M%==6 GOTO NetframeworkMenu
IF %M%==7 GOTO TeamViewerMenu
IF %M%==0 GOTO MENU
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
:AdobeReaderMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO Adobe Reader Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO AdobeReaderI
IF %M%==2 GOTO AdobeReaderV
:GoogleChromeMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO Google Chrome Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO GoogleChromeI
IF %M%==2 GOTO GoogleChromeV
:MicrosoftEdgeMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO Microsoft Edge Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO MicrosoftEdgeI
IF %M%==2 GOTO MicrosoftEdgeV
:VLCMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO VLC Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO VLCI
IF %M%==2 GOTO VLCV
:LibreofficeMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO Libre Office Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO LibreofficeI
IF %M%==2 GOTO LibreofficeV
:NetframeworkMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO .Net Framework Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO NetframeworkI
IF %M%==2 GOTO NetframeworkV
:TeamViewerMenu
cls
ECHO.
ECHO ...............................................
ECHO Euro Discount - Euro Business Custom 
ECHO ...............................................
ECHO.
ECHO Team Viewer Verwijderen Of Installeren?
ECHO 1 - Installeren
ECHO 2 - Verwijderen
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO TeamViewerI
IF %M%==2 GOTO TeamViewerV
:AdobeReaderI
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\adobereader.ps1"
pause
GOTO MENU
:AdobeReaderV
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\verwijderen\adobereader.ps1"
pause
GOTO MENU
:MicrosoftEdgeI
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\microsoftedge.ps1"
GOTO MENU
:MicrosoftEdgeV
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\verwijderen\microsoftedge.ps1"
pause
GOTO MENU
:VLCI
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\vlc.ps1"
GOTO MENU
:VLCV
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\verwijderen\vlc.ps1"
pause
GOTO MENU
:LibreofficeI
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\libreoffice.ps1"
GOTO MENU
:LibreofficeV
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\verwijderen\libreoffice.ps1"
pause
GOTO MENU
:NetframeworkI
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\netframework.ps1"
GOTO MENU
:NetframeworkV
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\verwijderen\netframework.ps1"
pause
GOTO MENU
:TeamViewerI
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\Teamviewer.ps1"
GOTO MENU
:TeamViewerV
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\prog\verwijderen\Teamviewer.ps1"
pause
GOTO MENU
