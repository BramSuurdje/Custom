#HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\ {20D04FE0-3AEA-1069-A2D8-08002B30309D} = 0/show , 1/hide
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

'enabled computer shortcut'
#HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\ {20D04FE0-3AEA-1069-A2D8-08002B30309D} = 0/show , 1/hide
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

'enabled users folder shortcut'