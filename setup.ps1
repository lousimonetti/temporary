function Create-Links() {
  param(
    [string]$name,
    [string]$url,
    [string]$path = "$($ENV:ALLUSERSPROFILE)\Microsoft\Windows\Start Menu\Programs\$($name).lnk"
    )

  # $path = "$($ENV:ALLUSERSPROFILE)\Microsoft\Windows\Start Menu\Programs\$($name).lnk"
  if(-not([System.IO.File]::Exists($path))){
      $WshShell = New-Object -comObject WScript.Shell
      $Shortcut = $WshShell.CreateShortcut($path)
      $Shortcut.TargetPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
      $Shortcut.Arguments = "--kiosk $($url) --edge-kiosk-type=public-browsing"
      $Shortcut.Save()
  }

}
$profile =[Environment]::GetFolderPath('CommonDesktopDirectory')
$url = "https://recv.azurewebsites.net"
Create-ESWPLinks -url $url -name "ESWP"
$path = "$($profile)\ESWP.lnk"
Create-ESWPLinks -url $url -name "ESWP" -path $path
Create-ESWPLinks -url "$($url)/receiverdashboard" -name "Dashboard"
$path = "$($profile)\Dashboard.lnk"
Create-ESWPLinks -url "$($url)/receiverdashboard" -name "Dashboard" -path $path

