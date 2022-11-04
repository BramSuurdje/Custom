@ECHO OFF
SET CUR_DIR=%~dp0
TITLE Custom Windows Libreoffice
GOTO CUSTOM-APPS

:CUSTOM-APPS
	IF NOT EXIST "$PSScriptRoot\custom-apps-libreoffice.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "$PSScriptRoot\custom-apps-libreoffice.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO ENABLE-DESKTOP-SHORTCUTS

:ENABLE-DESKTOP-SHORTCUTS
	IF NOT EXIST "$PSScriptRoot\enable-desktop-shortcuts.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "$PSScriptRoot\enable-desktop-shortcuts.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO REMOVE-BLOATWARE

:REMOVE-BLOATWARE
	IF NOT EXIST "$PSScriptRoot\startmenuw11.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "$PSScriptRoot\startmenuw11.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO UPDATE

:UPDATE
	IF NOT EXIST "$PSScriptRoot\update.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Excepted path : "$PSScriptRoot\update.ps1"
		ECHO Press any key to close this script
		PAUSE > NUL
		EXIT
	)
	GOTO CHANGE-DRIVE-LETTER

:CHANGE-DRIVE-LETTER
	IF NOT EXIST "$PSScriptRoot\change-drive-letter.ps1" (
		COLOR C
		CLS
		ECHO PowerShell-bestanden zijn niet gevonden, zorg ervoor dat deze aanwezig zijn en voer dit script opnieuw uit.
		ECHO Verwachte pad : "$PSScriptRoot\change-drive-letter.ps1"
		ECHO Druk op een willekeurige toets om dit script te sluiten
		PAUSE > NUL
		EXIT
	)
	GOTO START_SCRIPT
	
:START_SCRIPT
	powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\custom-apps-libreoffice.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\enable-desktop-shortcuts.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\change-drive-letter.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\startmenuw11.ps1"
	powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\update.ps1"
	EXIT