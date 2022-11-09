###### Install Chocolatery
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
######

###### Install Custom Apps
choco install adobereader googlechrome microsoft-edge vlc libreoffice -fresh netfx-4.8  -y
choco install teamviewer --ignore-checksums

######

Write-Output "Custom with LibreOffice Sucessfull"