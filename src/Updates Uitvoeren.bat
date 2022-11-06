@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Updates
GOTO START_SCRIPT

:START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\update.ps1"
	EXIT