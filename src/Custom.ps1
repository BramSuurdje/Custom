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
    Write-Host "2 - Apps Updaten"
    Write-Host ""
    Write-Host "3 - HDSentinel"
    Write-Host "4 - CCleaner"
    Write-Host "5 - Hardware Info"
    Write-Host "6 - Partition Wizzard"
    Write-Host "0 - EXIT"
    Write-Host ""

    $choice = Read-Host "Type 1, 2, 3, or 4... then press ENTER"

    switch ($choice) {
        '1' { WinCustom }
        '2' { update-apps }
        '3' { Start-HDSentinel }
        '4' { Start-CCleaner }
        '5' { Start-HardwareInfo }
        '6' { Start-PartitionWizzard }
        '0' { Exit }
        default { Show-Menu }
    }
}

Function WinCustom {

    # Check if winget is installed
    $wingetInstalled = Get-Command winget -ErrorAction SilentlyContinue

    if (-not $wingetInstalled) {
        Write-Host "Windows Package Manager (winget) is not installed. Installing now..."
        # Download and install winget
        Install-PackageProvider -Name "NuGet" -Confirm:$False -Force
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
        Install-Script winget-install -Confirm:$False -Force
        winget-install
    }

    # List of programs to install
    $programs = @(
        "Adobe.Acrobat.Reader.64-bit",
        "Google.Chrome",
        "Microsoft.Edge",
        "VideoLAN.VLC",
        "TheDocumentFoundation.LibreOffice",
        "Microsoft.DotNet.Framework.DeveloperPack_4",
        "TeamViewer.TeamViewer"
    )

    # Loop through the list of programs and install them using winget
    foreach ($program in $programs) {
        Write-Host "Installing $program..."
        winget install -e --id $program --accept-source-agreements --accept-package-agreements
        Write-Host "$program Sucessfully installed."
    }

    Write-Host "Custom Apps Installed."

    ##########################################

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


Function update-apps {

    # Check if winget is installed
    $wingetInstalled = Get-Command winget -ErrorAction SilentlyContinue

    if (-not $wingetInstalled) {
        Write-Host "Windows Package Manager (winget) is not installed. Installing now..."
        # Download and install winget
        Install-PackageProvider -Name "NuGet" -Confirm:$False -Force
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
        Install-Script winget-install -Confirm:$False -Force
        winget-install
    }
        winget upgrade --all
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