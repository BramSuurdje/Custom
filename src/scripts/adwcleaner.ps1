function Show-Menu {
    param (
        [string]$Title = 'adwcleaner'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: adwcleaner installeren"
    Write-Host "2: adwcleaner Verwijderen"
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
        
        choco install adwcleaner -y  
    } '2' {
    choco install adwcleaner -y 
    }
    }
    pause
 }
 until ($selection -eq 'q')
