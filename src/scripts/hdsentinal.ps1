function Show-Menu {
    param (
        [string]$Title = 'HDsentinel'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: HDsentinel installeren"
    Write-Host "2: HDsentinel Verwijderen"
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
        
        choco install hdsentinel -y 
    } '2' {
    choco install hdsentinel -y
    }
    }
    pause
 }
 until ($selection -eq 'q')
