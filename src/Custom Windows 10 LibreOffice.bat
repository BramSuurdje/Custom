@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Custom Windows Libreoffice
GOTO START_SCRIPT

:START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\custom-apps-libreoffice.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\enable-desktop-shortcuts.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\change-drive-letter.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\startmenuw10.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\update.ps1"
	EXIT