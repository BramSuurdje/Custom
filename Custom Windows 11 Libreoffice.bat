@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Custom Windows Libreoffice
GOTO CUSTOM-APPS

:CUSTOM-APPS
	IF NOT EXIST "Z:\--Custom--\src\custom-apps-libreoffice.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "Z:\--Custom--\src\custom-apps-libreoffice.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO ENABLE-DESKTOP-SHORTCUTS

:ENABLE-DESKTOP-SHORTCUTS
	IF NOT EXIST "Z:\--Custom--\src\enable-desktop-shortcuts.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "Z:\--Custom--\src\enable-desktop-shortcuts.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO REMOVE-BLOATWARE

:REMOVE-BLOATWARE
	IF NOT EXIST "Z:\--Custom--\src\startmenuw11.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "Z:\--Custom--\src\startmenuw11.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO UPDATE

:UPDATE
	IF NOT EXIST "Z:\--Custom--\src\update.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "Z:\--Custom--\src\update.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO CHANGE-DRIVE-LETTER

:CHANGE-DRIVE-LETTER
	IF NOT EXIST "Z:\--Custom--\src\change-drive-letter.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Verwachte pad : "Z:\--Custom--\src\change-drive-letter.ps1"
		ECHO Druk op een willekeurige toets om dit script te sluiten
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
	powershell -NoProfile -ExecutionPolicy Bypass -File "Z:\--Custom--\src\custom-apps-libreoffice.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "Z:\--Custom--\src\enable-desktop-shortcuts.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "Z:\--Custom--\src\change-drive-letter.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "Z:\--Custom--\src\startmenuw11.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "Z:\--Custom--\src\update.ps1"
	EXIT