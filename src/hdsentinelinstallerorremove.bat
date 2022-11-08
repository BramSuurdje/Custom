@ECHO OFF
SET CUR_DIR=%~dp0
TITLE hdsentinal
GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\hdsentinal.ps1"
    EXIT