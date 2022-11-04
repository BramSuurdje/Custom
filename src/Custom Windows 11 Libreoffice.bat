@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Custom Windows Libreoffice
GOTO CUSTOM-APPS

:CUSTOM-APPS
	IF NOT EXIST "%cd%\custom-apps-libreoffice.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "%cd%\custom-apps-libreoffice.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO ENABLE-DESKTOP-SHORTCUTS

:ENABLE-DESKTOP-SHORTCUTS
	IF NOT EXIST "%cd%\enable-desktop-shortcuts.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "%cd%\enable-desktop-shortcuts.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO REMOVE-BLOATWARE

:REMOVE-BLOATWARE
	IF NOT EXIST "%cd%\startmenuw11.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "%cd%\startmenuw11.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO UPDATE

:UPDATE
	IF NOT EXIST "%cd%\update.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "%cd%\update.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO CHANGE-DRIVE-LETTER

:CHANGE-DRIVE-LETTER
	IF NOT EXIST "%cd%\change-drive-letter.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Verwachte pad : "%cd%\change-drive-letter.ps1"
		ECHO Druk op een willekeurige toets om dit script te sluiten
		PAUSE > NUL
		EXIT
	)
	GOTO START_SCRIPT
	
:START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\custom-apps-libreoffice.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\enable-desktop-shortcuts.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\change-drive-letter.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\startmenuw11.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "%cd%\update.ps1"
	EXIT