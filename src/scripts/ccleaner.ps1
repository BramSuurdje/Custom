function Show-Menu {
    param (
        [string]$Title = 'CCleaner'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: CCleaner installeren"
    Write-Host "2: CCleaner Verwijderen"
    Write-Host "Q: Om aftesluiten."
}

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
        $testchoco = powershell choco -v
        if(-not($testchoco)){
            Write-Output "Seems Chocolatey is not installed, installing now"
            Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        }
        else{
            Write-Output "Chocolatey Version $testchoco is already installed"
        }
        
        # or
        
        if(test-path "C:\ProgramData\chocolatey\choco.exe"){
        
        }
        
        choco install ccleaner -y  
    } '2' {
    choco uninstall ccleaner -y 
    }
    }
    pause
 }
 until ($selection -eq 'q')
