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
    
    Write-Host "1: Om de Windows 10 Custom te installeren met LibreOffice"
    Write-Host "2: Om de Windows 11 Custom te installeren met Libreoffice"
    Write-Host "3: Press '3' for this option."
    Write-Host "Q: Press 'Q' to quit."
}

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    Start-Process "$PSScriptRoot\src\Custom Windows 10 Libreoffice.bat"
    } '2' {
    Start-Process "$PSScriptRoot\src\Custom Windows 11 Libreoffice.bat"
    } '3' {
      'You chose option #3'
    }
    }
    pause
 }
 until ($selection -eq 'q')