@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Uninstall adwcleaner
GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\adwcleaner.ps1"
    EXIT