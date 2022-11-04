

# Check if winget is installed
Write-Host "Checking if Winget is Installed..."
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
    #Checks if winget executable exists and if the Windows Version is 1809 or higher
    Write-Host "Winget Already Installed"
}
else {
    #Gets the computer's information
    $ComputerInfo = Get-ComputerInfo

    #Gets the Windows Edition
    $OSName = if ($ComputerInfo.OSName) {
        $ComputerInfo.OSName
    }else {
        $ComputerInfo.WindowsProductName
    }

    if (((($OSName.IndexOf("LTSC")) -ne -1) -or ($OSName.IndexOf("Server") -ne -1)) -and (($ComputerInfo.WindowsVersion) -ge "1809")) {
        
        Write-Host "Running Alternative Installer for LTSC/Server Editions"

        # Switching to winget-install from PSGallery from asheroto
        # Source: https://github.com/asheroto/winget-installer
        
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https://raw.githubusercontent.com/asheroto/winget-installer/master/winget-install.ps1 | iex | Out-Host" -WindowStyle Normal
        
    }
    elseif (((Get-ComputerInfo).WindowsVersion) -lt "1809") {
        #Checks if Windows Version is too old for winget
        Write-Host "Winget is not supported on this version of Windows (Pre-1809)"
    }
    else {
            #Installing Winget from the Microsoft Store
            Write-Host "Winget not found, installing it now."
            Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
            $nid = (Get-Process AppInstaller).Id
            Wait-Process -Id $nid
            Write-Host "Winget Installed"
    }
}

winget install --id=Adobe.Acrobat.Reader.64-bit -e  ; winget install --id=Google.Chrome -e  ; winget install --id=Microsoft.Edge -e  ; winget install --id=VideoLAN.VLC.Nightly -e  ; winget install --id=TheDocumentFoundation.LibreOffice -e  ; winget install --id=Microsoft.dotNetFramework -e  ; winget install --id=TeamViewer.TeamViewer -e 

Write-Output "Custom with LibreOffice Sucessfull"