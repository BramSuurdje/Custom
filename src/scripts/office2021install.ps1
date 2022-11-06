Set-Location -Path $PSScriptRoot\files -PassThru

New-Item -Name configuration-office-professional-plus-2021-64-bit.xml -ItemType File

sleep 3

'<Configuration>
  <Info Description="Office Professional Plus 2021 (64-bit)" />
  <Add OfficeClientEdition="64" Channel="PerpetualVL2021" SourcePath="C:\Officesetup">
    <Product ID="ProPlus2021Volume" PIDKEY="#####-#####-#####-#####-#####">
      <Language ID="nl-nl" />
    </Product>
  </Add>
  <RemoveMSI />
  <Display Level="Full" AcceptEULA="TRUE" />
</Configuration>' | Out-File $PSScriptRoot\files\configuration-office-professional-plus-2021-64-bit.xml

sleep 3

.\setup.exe /download configuration-office-professional-plus-2021-64-bit.xml
.\setup.exe /configure configuration-office-professional-plus-2021-64-bit.xml

Remove-Item -LiteralPath "C:\OfficeSetup" -Force -Recurse
Remove-Item configuration-office-professional-plus-2021-64-bit.xml
Write-Host "Office 2021 is geinstalleerd!"
