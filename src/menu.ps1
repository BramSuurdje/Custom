If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

function Show-Menu {
    param (
        [string]$Title = 'Eurodiscount Menu')
    param (    
        [string]$Title2 = 'Opschoning'
    )
    Clear-Host
    Write-Host "====================================== $Title ======================================"
    Write-Host ""
    Write-Host "1: Windows 10 Custom Installeren               |3: Updates Uitvoeren"
    Write-Host "2: Windows 11 Custom Installeren               |4: Check voor updates"
    Write-Host ""
    Write-Host "5: Libreoffice Verwijderen"
    Write-Host "6: Office 2021 Pro Plus Installeren"
    Write-Host ""
    Write-Host "----------------------------------------- $Title2 ---------------------------------------"
    Write-Host "9: HDSentinal Installeren"
    Write-Host "10: adwcleaner Installeren"
    Write-Host "11: CCleaner Installeren"
    Write-Host "12: Malware bites Installeren"
    Write-Host ""
    Write-Host "13: Alle Opschonings programmas verwijderen"
    Write-Host ""
    Write-Host "Q: Om Af te sluiten"
}

do
 {
    Show-Menu
    $selection = Read-Host "Maak een Keuze"
    switch ($selection)
    {
    '1' { # Custom windows 10
    & "$PSScriptRoot\custom-apps-libreoffice.ps1"
    & "$PSScriptRoot\enable-desktop-shortcuts.ps1"
    & "$PSScriptRoot\change-drive-letter.ps1"
    & "$PSScriptRoot\startmenuw10.ps1"
    & "$PSScriptRoot\update.ps1"
    } '2' { # Custom Windows 11
    & "$PSScriptRoot\custom-apps-libreoffice.ps1"
    & "$PSScriptRoot\enable-desktop-shortcuts.ps1"
    & "$PSScriptRoot\change-drive-letter.ps1"
    & "$PSScriptRoot\startmenuw11.ps1"
    & "$PSScriptRoot\update.ps1"
    } '3' { # updates uitvoeren
    & "$PSScriptRoot\update.ps1"
    } '4' { # zoeken naar updates
    & "$PSScriptRoot\check-updates.ps1"
    } '9' { # HDsentinal
    & "$PSScriptRoot\hdsentinal.ps1"
    } '10' { # adwcleaner
    & "$PSScriptRoot\adwcleaner.ps1"
    } '11' { # CCleaner
    & "$PSScriptRoot/ccleaner.ps1"
    } '13' { # alle opschonings programmas verwijderen
    & "$PSScriptRoot\uninstallopschoning.ps1"
    } '12' { # Malwarebytes
    & "$PSScriptRoot\malwarebytes.ps1"
    } '5' { # libreoffice verwijderen
    & "$PSScriptRoot\scritps\uninstall-libreoffice.ps1"
    } '6' { # Office 2021 installeren
    & "$PSScriptRoot\office2021install.ps1"
    }       
    }
    pause
 }
 until ($selection -eq 'q')