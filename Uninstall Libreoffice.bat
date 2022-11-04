@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Uninstall Libreoffice
GOTO UNINSTALL

:UNINSTALL
	IF NOT EXIST "Z:\--Custom--\src\uninstall-libreoffice.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "Z:\--Custom--\src\uninstall-libreoffice.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO CHECK_ADMIN_PERMS

    :CHECK_ADMIN_PERMS
	openfiles >nul 2>&1
	IF NOT %errorLevel% == 0 (
		COLOR C
		CLS
		ECHO Please run this script as Administrator
		PAUSE > NUL
		EXIT
	)
	GOTO START_SCRIPT

    :START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "Z:\--Custom--\src\uninstall-libreoffice.ps1"
    EXIT