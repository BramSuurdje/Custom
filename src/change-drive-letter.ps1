Set-Volume -DriveLetter C -NewFileSystemLabel "OS"
Write-Output "Changing drive letter was successfull"

Set-Volume -DriveLetter D -NewFileSystemLabel "DATA"
Write-Output "Changing Drive letter was successfull"