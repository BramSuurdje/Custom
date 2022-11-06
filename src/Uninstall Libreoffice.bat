@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Uninstall Libreoffice
GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\uninstall-libreoffice.ps1"
    EXIT