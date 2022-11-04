Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module PSWindowsUpdate -Confirm:$False -Force
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
