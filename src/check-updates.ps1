if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    Get-WindowsUpdate
} 
else {
    Write-Host "PSWindowsUpdate is now being installed"
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module PSWindowsUpdate -Confirm:$False -Force
    Get-WindowsUpdate
}