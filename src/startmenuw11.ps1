Copy-Item -Path $PSScriptRoot\start.bin -Destination C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState -PassThru
Copy-Item -Path $PSScriptRoot\start2.bin -Destination C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState -PassThru

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
