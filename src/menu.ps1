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
    Write-Host "1: Windows 10 Custom Installeren"
    Write-Host "2: Windows 11 Custom Installeren"
    Write-Host ""
    Write-Host "3: Libreoffice Verwijderen"
    Write-Host ""
    Write-Host "----------------------------------------- $Title2 ---------------------------------------"
    Write-Host "4: HDSentinal Installeren"
    Write-Host "5: adwcleaner Installeren"
    Write-Host "6: CCleaner Installeren"
    Write-Host "7: Malware bites Installeren"
    Write-Host ""
    Write-Host "8: Alle Opschonings programmas verwijderen"
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
    } '4' { # HDsentinal
    & "$PSScriptRoot\hdsentinal.ps1"
    } '5' { # adwcleaner
    & "$PSScriptRoot\adwcleaner.ps1"
    } '6' { # CCleaner
    & "$PSScriptRoot\ccleaner.ps1"
    } '8' { # alle opschonings programmas verwijderen
    & "$PSScriptRoot\uninstallopschoning.ps1"
    } '7' { # Malwarebytes
    & "$PSScriptRoot\malwarebytes.ps1"
    } '3' { # libreoffice verwijderen
    & "$PSScriptRoot\uninstall-libreoffice.ps1"
    }       
    }
    pause
 }
 until ($selection -eq 'q')