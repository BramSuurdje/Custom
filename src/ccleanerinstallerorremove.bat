@ECHO OFF
SET CUR_DIR=%~dp0
TITLE CCleaner
GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\ccleaner.ps1"
    EXIT