
$ps_script_dir = "C:\Users\Keith\Documents\WindowsPowerShell\Scripts"

New-Alias sudo $ps_script_dir\elevatePS.ps1

New-Alias mklink $ps_script_dir\new-symlink.ps1


import-module -name posh-git
start-sshagent




Add-PSSnapIn SMCmdletSnapIn