@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Custom Windows Libreoffice
GOTO START_SCRIPT

:START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\src\scripts\custom-apps-libreoffice.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\src\scripts\enable-desktop-shortcuts.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\src\scripts\change-drive-letter.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\src\scripts\startmenuw10.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\src\scripts\update.ps1"
	EXIT