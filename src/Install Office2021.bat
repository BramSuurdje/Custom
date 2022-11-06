@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Install Office2021
GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\office2021install.ps1"
    EXIT