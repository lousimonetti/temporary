net user MutliAppKioskUser /add /passwordchg:NO /passwordreq:no /active:yes
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
  if(Test-Path -Path 'C:\Users\Public\Desktop\Microsoft Edge.lnk')
  {
    Remove-Item -Path 'C:\users\Public\Desktop\Microsoft Edge.lnk' -Force
  }

}
$profile =[Environment]::GetFolderPath('CommonDesktopDirectory')
$url = "https://recv.azurewebsites.net"
Create-Links -url $url -name "ESWP"
$path = "$($profile)\ESWP.lnk"
Create-Links -url $url -name "ESWP" -path $path
Create-Links -url "$($url)/receiverdashboard" -name "Dashboard"
$path = "$($profile)\Dashboard.lnk"
Create-Links -url "$($url)/receiverdashboard" -name "Dashboard" -path $path

