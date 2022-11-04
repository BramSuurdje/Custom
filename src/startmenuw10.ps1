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

  #Restart Explorer and delete the layout file
  Stop-Process -name explorer

  # Uncomment the next line to make clean start menu default for all new users
  #Import-StartLayout -LayoutPath $layoutFile -MountPath $env:SystemDrive\

  Remove-Item $layoutFile



