@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Uninstall Opschoning
GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\scripts\uninstallopschoning.ps1"
    EXIT