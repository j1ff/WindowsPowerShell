###############################################################################################################################################>
############################  Paths and Vars  ####################################################################################################################>
###############################################################################################################################################>
$ps_script_dir = "C:\Users\Keith\Documents\WindowsPowerShell\Scripts"

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. C:\Users\Keith\Documents\WindowsPowerShell\Include\alias.ps1

$path = switch -Wildcard ($executionContext.SessionState.Path.CurrentLocation.Path) {
        "$HOME" { "~" }
        "$HOME\*" { $executionContext.SessionState.Path.CurrentLocation.Path.Replace($HOME, "~") }
        default { $executionContext.SessionState.Path.CurrentLocation.Path }
    }

$env:PYTHONIOENCODING="utf-8"
iex "$(thefuck --alias)"`

###############################################################################################################################################>
#############################  Imports  #######################################################################################################>
###############################################################################################################################################>
#Import-Module 
Import-Module Get-ChildItemColor
#import-module posh-git
#import-module "oh-my-posh" -disableNameChecking -noclobber 
import-module pscolor
import-module psreadline
Import-Module TabExpansionPlusPlus




################################################################################################################################################>
##############################  Battery Indicator  #############################################################################################>
################################################################################################################################################>
	
$batt = (Get-WmiObject win32_battery).estimatedChargeRemaining
$chg = (Get-WmiObject Win32_Battery).BatteryStatus 


	if ($batt -lt 20) { 
		$bcolor = 'Red'
		if ($batt -lt 10) {
			$icon = $([char]0xF579) }
		elseif ($batt -lt 20) {
			$icon = $([char]0xF57A) }
	}
	if ($batt -lt 50) {
		$bcolor = 'Yellow'
		if ($batt -lt 30) {
			$icon = $([char]0xF57B) }
		elseif ($batt -lt 40) {
			$icon = $([char]0xF57C) }
		elseif ($batt -lt 50) {
			$icon = $([char]0xF57D) }
	}
	if ($batt -le 100) {
		$bcolor = 'Green'
		if ($batt -lt 60) {
			$icon = $([char]0xF57E)}
		elseif ($batt -lt 70) {
			$icon = $([char]0xF57F)}
		elseif ($batt -lt 80) {
			$icon = $([char]0xF580)}
		elseif ($batt -lt 90) {
			$icon = $([char]0xF581)}
		elseif ($batt -le 100) {
			$icon = $([char]0xF578)}
	}
	$battdisp = ""
	
	if ($chg = 1) {
	
	$battdisp = $icon+" "
	} elseif ($chg = 2) {
	$battdisp = $icon+$([char]0xF33D)+" "
	}
	
	$gbatt, $ybatt, $rbatt = ""
	$gbattdisp, $rbattdisp, $ybattdisp = ""
	
	switch ($bcolor) {
		Red {$rbattdisp = $battdisp
			$rbatt = [string]$batt+"%"}
		Yellow {$ybattdisp = $battdisp
			$ybatt = [string]$batt+"%"}
		Green {$gbattdisp = $battdisp
			$gbatt = [string]$batt+"%"}
			
	}	


###########################################################################################################################################>
################### Prompt and Dependencies ###############################################################################################>
###########################################################################################################################################>
	
function Write-Color($msg, $fg, $bg = $Host.UI.RawUI.BackgroundColor) {
  Write-Host -Object $msg -ForegroundColor $fg -BackgroundColor $bg -NoNewLine
  return " "
}

function Prompt {
  Write-Color "┌─[" White
  Write-Color "$(Get-Date -Format HH:mm)" DarkRed
  Write-Color "]─╼" White
  Write-Color  " $([char]0xF6C4) $env:username@$env:computername" Cyan
  Write-Color " ╾╼ " White 
  Write-Color " $([char]0xF07C) $path " DarkYellow
  Write-Color " ╾╼ " White
  Write-Color "$rbattdisp$rbatt" Red
  Write-Color "$gbattdisp$gbatt" Green
  Write-Color "$ybattdisp.$ybatt" Yellow
  Write-Color "`n└╼ $([char]0xF17A) " White
  return " "
}


########################################################################################################################>
###########################    Colorized ls   ##########################################################################>
########################################################################################################################>

function Write-Color-LS
    {
        param ([string]$color = "white", $file)
        Write-host ("{0,-7} {1,25} {2,10} {3}" -f $file.mode, ([String]::Format("{0,10}  {1,8}", $file.LastWriteTime.ToString("d"), $file.LastWriteTime.ToString("t"))), $file.length, $file.name) -foregroundcolor $color 
    }

New-CommandWrapper Out-Default -Process {
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase)


    $compressed = New-Object System.Text.RegularExpressions.Regex(
        '\.(zip|tar|gz|rar|jar|war)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex(
        '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg)$', $regex_opts)
    $text_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(txt|cfg|conf|ini|csv|log|xml|java|c|cpp|cs)$', $regex_opts)

    if(($_ -is [System.IO.DirectoryInfo]) -or ($_ -is [System.IO.FileInfo]))
    {
        if(-not ($notfirst)) 
        {
           Write-Host
           Write-Host "    Directory: " -noNewLine
           Write-Host " $(pwd)`n" -foregroundcolor "Magenta"           
           Write-Host "Mode                LastWriteTime     Length Name"
           Write-Host "----                -------------     ------ ----"
           $notfirst=$true
        }

        if ($_ -is [System.IO.DirectoryInfo]) 
        {
            Write-Color-LS "Magenta" $_                
        }
        elseif ($compressed.IsMatch($_.Name))
        {
            Write-Color-LS "DarkGreen" $_
        }
        elseif ($executable.IsMatch($_.Name))
        {
            Write-Color-LS "Red" $_
        }
        elseif ($text_files.IsMatch($_.Name))
        {
            Write-Color-LS "Yellow" $_
        }
        else
        {
            Write-Color-LS "White" $_
        }

    $_ = $null
    }
} -end {
    write-host ""
}
#################################>
#################################>d
#########       #################>
#################################>
#################################>
#################################>
#########       #################>
#################################>
#################################>
#################################>
#########       #################>
#################################>
#################################>
#################################>
#########       #################>
#################################>
#################################>
#################################>
#########       #################>
#################################>
#################################>
#################################>
#########       #################>
#################################>
#################################>
#########       #################>
#################################>
#################################>
#################################>
#########       #################>
#################################>

