Set-Alias wc 'Measure-Object -line -word -character'
Set-Alias wcl 'Measure-Object -Line' 
#New-Alias mklink $ps_script_dir\new-symlink.ps1
Set-Alias im Install-Module  	
Set-Alias np 'c:\program files\notepad++\notepad++.exe'
Set-Alias meta $ps_script_dir\list-file-metadata.ps1

Set-Alias git hub
Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias wh Write-Host


function lsa ($path = $pwd) {
    Get-ChildItemColor $path | Format-Wide -force -column 3
}

 