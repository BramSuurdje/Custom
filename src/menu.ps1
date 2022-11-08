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
    Write-Host "13: Alle Opschonings programmas verwijderen"
    Write-Host ""
    Write-Host "Q: Press 'Q' to quit."
}

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    Start-Process "$PSScriptRoot\Custom Windows 10 Libreoffice.bat"
    } '2' {
    Start-Process "$PSScriptRoot\Custom Windows 11 Libreoffice.bat"
    } '3' {
    Start-Process "$PSScriptRoot\Updates Uitvoeren.bat"
    } '4' {
    Start-Process "$PSScriptRoot\Check for Updates.bat"
    } '9' { # HDsentinal
    Start-Process "$PSScriptRoot\hdsentinelinstallerorremove.bat"
    } '10' { # adwcleaner
    Start-Process "$PSScriptRoot\adwcleanerinstallerorremove.bat"
    } '11' { # CCleaner
    Start-Process "$PSScriptRoot\ccleanerinstallerorremove.bat"
    } '13' {
    Start-Process "$PSScriptRoot\uninstall-opschoning.bat"
    } '12' { # Malwarebytes
    Start-Process "$PSScriptRoot\malwarebytesinstallerorremove.bat"
    } '5' {
    Start-Process "$PSScriptRoot\Uninstall Libreoffice.bat"
    } '6' {
    Start-Process "$PSScriptRoot\Install Office2021.bat"
    }       
    }
    pause
 }
 until ($selection -eq 'q')