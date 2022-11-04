Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Script -Name winget-install -Force
winget-install.ps1

winget install --id=Adobe.Acrobat.Reader.64-bit -e  ; winget install --id=Google.Chrome -e  ; winget install --id=Microsoft.Edge -e  ; winget install --id=VideoLAN.VLC.Nightly -e  ; winget install --id=TheDocumentFoundation.LibreOffice -e  ; winget install --id=Microsoft.dotNetFramework -e  ; winget install --id=TeamViewer.TeamViewer -e 

Write-Output "Custom with LibreOffice Sucessfull"