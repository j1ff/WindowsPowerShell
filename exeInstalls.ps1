
Install-ChocolateyInstallPackage -PackageName 'elpis' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "J:\windows ssd install\inst\elpis.exe" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'wiztree' -FileType 'exe' `
  -SilentArgs '/S' 
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\wiztree.exe" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'tmcbeans' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\tmcbeans.exe" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'gitkraken' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\gitkraken.exe" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'tabula' -FileType 'jar' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\tabula.jar" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'keybase' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\keybase.exe" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'caprine' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\caprine.exe" `
  -ValidExitCodes = @(0)

Install-ChocolateyInstallPackage -PackageName 'lol' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\lol.exe" `
  -ValidExitCodes = @(0)


---choco---
boxstarter
powershell
chocolatey
logitechgaming
geforce-experience
winrar
launchy
android-sdk
androidstudio
airdroid
classic-shell
everything
speedfan
hyper
teamviewer
googlechrome
jre8
jdk8
flashplayerplugin
vlc
git
nodejs.install
silverlight
sysinternals
procexp
paint.net
vlc
virtualbox
windowsazurepowershell
foxitreader
irfanview
deluge
