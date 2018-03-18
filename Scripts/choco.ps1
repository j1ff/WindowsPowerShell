set-executionpolicy bypass -scope process -force




reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersio??n\AppModelUnlock" /t REG_DWO RD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux


cinst boxstarter -y
cinst powershell -y
cinst chocolatey -y
cinst logitechgaming -y
cinst geforce-experience -y
cinst winrar -y
cinst launchy -y
cinst android-sdk -y
cinst androidstudio -y
cinst airdroid -y
cinst classic-shell -y
cinst everything -y
cinst speedfan -y
cinst hyper -y
cinst teamviewer -y
cinst googlechrome -y
cinst jre8 -y
cinst jdk8 -y
cinst flashplayerplugin -y
cinst vlc -y
cinst git -y
cinst nodejs.install -y
cinst silverlight -y
cinst sysinternals -y
cinst procexp -y
cinst paint.net -y
cinst virtualbox -y
cinst windowsazurepowershell -y
cinst foxitreader -y
cinst irfanview -y
cinst deluge -y

