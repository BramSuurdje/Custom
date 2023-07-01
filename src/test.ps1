# Check if running with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# If not running as administrator, relaunch the script with elevated privileges
if (-not $isAdmin) {
    Write-Output "Requesting administrative permissions..."
    Start-Process -FilePath PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

Function Show-Menu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "1 - Windows Custom"
    Write-Host ""
    Write-Host "2 - Specifieke Apps Installeren"
    Write-Host ""
    Write-Host "3 - HDSentinel"
    Write-Host "4 - CCleaner"
    Write-Host "5 - Hardware Info"
    Write-Host "6 - Partition Wizzard"
    Write-Host "0 - EXIT"
    Write-Host ""

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { WinCustom }
        '2' { SAPPS }
        '3' { Start-HDSentinel }
        '4' { Start-CCleaner }
        '5' { Start-HardwareInfo }
        '6' { Start-PartitionWizzard }
        '0' { Exit }
        default { Show-Menu }
    }
}

Function WinCustom {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install adobereader googlechrome microsoft-edge vlc libreoffice -fresh netfx-4.8  -y
    choco install teamviewer --ignore-checksums -y

    $path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
    $name="{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
    $exist="Get-ItemProperty -Path $path -Name $name"
    if ($exist)
    {
        Set-ItemProperty -Path $path -Name $name -Value 0
    }
    Else
    {
        New-ItemProperty -Path $path -Name $name -Value 0
    }

    $path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
    $name="{59031a47-3f72-44a7-89c5-5595fe6b30ee}"
    $exist="Get-ItemProperty -Path $path -Name $name"
    if ($exist)
    {
        Set-ItemProperty -Path $path -Name $name -Value 0
    }
    Else
    {
        New-ItemProperty -Path $path -Name $name -Value 0
    }

    Set-Volume -DriveLetter C -NewFileSystemLabel "OS"
    Set-Volume -DriveLetter D -NewFileSystemLabel "DATA"

    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem

    # Check the version and build number to determine the operating system
    $version = [System.Version]$osInfo.Version
    $buildNumber = $osInfo.BuildNumber

    if ($version -ge [System.Version]"10.0" -and $version -lt [System.Version]"10.0.22000.0") {

    $START_MENU_LAYOUT = @"
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
<LayoutOptions StartTileGroupCellWidth="6" />
<DefaultLayoutOverride>
  <StartLayoutCollection>
    <defaultlayout:StartLayout GroupCellWidth="6">
      <start:Group Name="">
        <start:Tile Size="2x2" Column="4" Row="2" AppUserModelID="Microsoft.WindowsStore_8wekyb3d8bbwe!App" />
        <start:Tile Size="2x2" Column="0" Row="2" AppUserModelID="Microsoft.WindowsCalculator_8wekyb3d8bbwe!App" />
        <start:Tile Size="2x2" Column="2" Row="0" AppUserModelID="microsoft.windowscommunicationsapps_8wekyb3d8bbwe!microsoft.windowslive.calendar" />
        <start:Tile Size="2x2" Column="4" Row="4" AppUserModelID="microsoft.windowscommunicationsapps_8wekyb3d8bbwe!Microsoft.WindowsLive.Mail" />
        <start:Tile Size="2x2" Column="2" Row="2" AppUserModelID="Microsoft.Windows.Photos_8wekyb3d8bbwe!App" />
        <start:Tile Size="2x2" Column="0" Row="0" AppUserModelID="Microsoft.WindowsAlarms_8wekyb3d8bbwe!App" />
        <start:Tile Size="2x2" Column="2" Row="4" AppUserModelID="Microsoft.ZuneVideo_8wekyb3d8bbwe!Microsoft.ZuneVideo" />
        <start:Tile Size="2x2" Column="0" Row="4" AppUserModelID="Microsoft.WindowsCamera_8wekyb3d8bbwe!App" />
        <start:DesktopApplicationTile Size="2x2" Column="4" Row="0" DesktopApplicationID="MSEdge" />
      </start:Group>
    </defaultlayout:StartLayout>
  </StartLayoutCollection>
</DefaultLayoutOverride>
</LayoutModificationTemplate>
"@

    $layoutFile="C:\Windows\StartMenuLayout.xml"

    #Delete layout file if it already exists
    If(Test-Path $layoutFile)
    {
        Remove-Item $layoutFile
    }

    #Creates the blank layout file
    $START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

    $regAliases = @("HKLM", "HKCU")

    #Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer" 
        IF(!(Test-Path -Path $keyPath)) { 
            New-Item -Path $basePath -Name "Explorer"
        }
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
        Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
    }

    #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
    Stop-Process -name explorer
    Start-Sleep -s 5
    $wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
    Start-Sleep -s 5

    #Enable the ability to pin items again by disabling "LockedStartLayout"
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer" 
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
    }

    Stop-Process -name explorer


    Remove-Item $layoutFile

    }
    elseif ($version -ge [System.Version]"10.0.22000.0") {
        Copy-Item -Path $PSScriptRoot\files\start.bin -Destination C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState -PassThru
        Copy-Item -Path $PSScriptRoot\files\start2.bin -Destination C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState -PassThru
        
        #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
        Stop-Process -name explorer
        Start-Sleep -s 5
        $wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
        Start-Sleep -s 5
        
        #Enable the ability to pin items again by disabling "LockedStartLayout"
        foreach ($regAlias in $regAliases){
            $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
            $keyPath = $basePath + "\Explorer" 
            Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
        }
        
        Stop-Process -name explorer
    }
    else {
    Write-Host "Detected an unsupported or unknown version of Windows."
    }

    Write-Output "Checking for updates..."
    Start-Process -FilePath "C:\Windows\System32\wuauclt.exe" -ArgumentList "/detectnow" -Wait

    Write-Output "Installing updates..."
    Start-Process -FilePath "C:\Windows\System32\wuauclt.exe" -ArgumentList "/updatenow" -Wait

    $needsRestart = (Get-WmiObject -Class Win32_OperatingSystem).RebootPending

    if ($needsRestart) {
        Write-Output "Restarting computer..."
        Restart-Computer -Force
    }
    else {
        Write-Output "No restart required."
    }
    Show-Menu
}

Function Start-HDSentinel {
    Set-Location -Path "$scriptPath\src\files\hdsentinel_pro_portable"
    Start-Process -FilePath "HDSentinel.exe"

    Show-Menu
}

Function Start-CCleaner {
    Set-Location -Path "$scriptPath\src\files\ccsetup607"
    Start-Process -FilePath "CCleaner.exe"

    Show-Menu
}

Function Start-HardwareInfo {
    Set-Location -Path "$scriptPath\src\files\Hardware-Info"
    Start-Process -FilePath "HWiNFO64.exe"

    Show-Menu
}

Function Start-PartitionWizzard {
    Set-Location -Path "$scriptPath\src\files\Partition-Wizard"
    Start-Process -FilePath "partitionwizard.exe"

    Show-Menu
}

Function SAPPS {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "1 - Adobe-Reader"
    Write-Host "2 - Google Chrome"
    Write-Host "3 - Microsoft Edge"
    Write-Host "4 - VLC"
    Write-Host "5 - libreoffice"
    Write-Host "6 - .NET Framework 4.8"
    Write-Host "7 - TeamViewer"
    Write-Host ""
    Write-Host "0 - EXIT"
    Write-Host ""

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { AdobeReaderMenu }
        '2' { GoogleChromeMenu }
        '3' { MicrosoftEdgeMenu }
        '4' { VLCMenu }
        '5' { LibreofficeMenu }
        '6' { NetframeworkMenu }
        '7' { TeamViewerMenu }
        '0' { Show-Menu }
        default { SAPPS }
    }
}

Function AdobeReaderMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "Adobe Reader Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { AdobeReaderI }
        '2' { AdobeReaderV }
        default { AdobeReaderMenu }
    }
}

Function GoogleChromeMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "Google Chrome Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { GoogleChromeI }
        '2' { GoogleChromeV }
        default { GoogleChromeMenu }
    }
}

Function MicrosoftEdgeMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "Microsoft Edge Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { MicrosoftEdgeI }
        '2' { MicrosoftEdgeV }
        default { MicrosoftEdgeMenu }
    }
}

Function VLCMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "VLC Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { VLCI }
        '2' { VLCV }
        default { VLCMenu }
    }
}

Function LibreofficeMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "Libre Office Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { LibreofficeI }
        '2' { LibreofficeV }
        default { LibreofficeMenu }
    }
}

Function NetframeworkMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host ".Net Framework Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { NetframeworkI }
        '2' { NetframeworkV }
        default { NetframeworkMenu }
    }
}

Function TeamViewerMenu {
    Clear-Host
    Write-Host "..............................................."
    Write-Host "Euro Discount - Euro Business Custom"
    Write-Host "..............................................."
    Write-Host ""
    Write-Host "Team Viewer Verwijderen Of Installeren?"
    Write-Host "1 - Installeren"
    Write-Host "2 - Verwijderen"

    $choice = Read-Host "Type 1, 2, 3, or 4 then press ENTER"

    switch ($choice) {
        '1' { TeamViewerI }
        '2' { TeamViewerV }
        default { TeamViewerMenu }
    }
}

Function AdobeReaderI {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\adobereader.ps1"
    pause
    Show-Menu
}

Function AdobeReaderV {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\verwijderen\adobereader.ps1"
    pause
    Show-Menu
}

Function MicrosoftEdgeI {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\microsoftedge.ps1"
    Show-Menu
}

Function MicrosoftEdgeV {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\verwijderen\microsoftedge.ps1"
    pause
    Show-Menu
}

Function VLCI {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\vlc.ps1"
    Show-Menu
}

Function VLCV {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\verwijderen\vlc.ps1"
    pause
    Show-Menu
}

Function LibreofficeI {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\libreoffice.ps1"
    Show-Menu
}

Function LibreofficeV {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\verwijderen\libreoffice.ps1"
    pause
    Show-Menu
}

Function NetframeworkI {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\netframework.ps1"
    Show-Menu
}

Function NetframeworkV {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\verwijderen\netframework.ps1"
    pause
    Show-Menu
}

Function TeamViewerI {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\teamviewer.ps1"
    Show-Menu
}

Function TeamViewerV {
    powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\src\prog\verwijderen\teamviewer.ps1"
    pause
    Show-Menu
}

Show-Menu
