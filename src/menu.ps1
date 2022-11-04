If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Write-Host "                                               3"
    Start-Sleep 1
    Write-Host "                                               2"
    Start-Sleep 1
    Write-Host "                                               1"
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

function Show-Menu {
    param (
        [string]$Title = 'Eurodiscount Menu'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "1: Windows 10 Custom Installeren"
    Write-Host "2: Windows 11 Custom Installeren"
    Write-Host ""
    Write-Host "5: Libreoffice Verwijderen"
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
    # insert code here
    } '5' {
    Start-Process "$PSScriptRoot\Uninstall Libreoffice.bat"
    }
    }
    pause
 }
 until ($selection -eq 'q')

 