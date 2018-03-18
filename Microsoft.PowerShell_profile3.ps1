
$ps_script_dir = "C:\Users\Keith\Documents\WindowsPowerShell\Scripts"

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

#$GitPromptSettings.DefaultPromptSuffix = Function prompt {â€œâ•­â”€â•¼ [$here]/nâ•°â”€â”€â”€â”€â”€â•¼$(Get-Date)â€œ}




$path = switch -Wildcard ($executionContext.SessionState.Path.CurrentLocation.Path) {
        "$HOME" { "~" }
        "$HOME\*" { $executionContext.SessionState.Path.CurrentLocation.Path.Replace($HOME, "~") }
        default { $executionContext.SessionState.Path.CurrentLocation.Path }
    }

#colored battery indicator on prompt
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
	$gbattdisp = ""
	$rbattdisp = ""
	$ybattdisp = ""
	
	switch ($bcolor) {
		Red {$rbattdisp = $battdisp
			$rbatt = [string]$batt+"%"}
		Yellow {$ybattdisp = $battdisp
			$ybatt = [string]$batt+"%"}
		Green {$gbattdisp = $battdisp
			$gbatt = [string]$batt+"%"}
			
	}	

#WRITE COLOR
	function W-Color([String[]]$Text, [ConsoleColor[]]$Color = "White", [int]$StartTab = 0, [int] $LinesBefore = 0,[int] $LinesAfter = 0, [string] $LogFile = "", $TimeFormat = "yyyy-MM-dd HH:mm:ss") {
    # version 0.2
    # - added logging to file
    # version 0.1
    # - first draft
    # 
    # Notes:
    # - TimeFormat https://msdn.microsoft.com/en-us/library/8kb3ddd4.aspx

    $DefaultColor = $Color[0]
    if ($LinesBefore -ne 0) {  for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host "`n" -NoNewline } } # Add empty line before
    if ($StartTab -ne 0) {  for ($i = 0; $i -lt $StartTab; $i++) { Write-Host "`t" -NoNewLine } }  # Add TABS before text
    if ($Color.Count -ge $Text.Count) {
        for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine } 
    } else {
        for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
        for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
    }
    Write-Host
    if ($LinesAfter -ne 0) {  for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host "`n" } }  # Add empty line after
    if ($LogFile -ne "") {
        $TextToFile = ""
        for ($i = 0; $i -lt $Text.Length; $i++) {
            $TextToFile += $Text[$i]
        }
        Write-Output "[$([datetime]::Now.ToString($TimeFormat))]$TextToFile" | Out-File $LogFile -Encoding unicode -Append
    }
}

	
	
	
	
function Prompt{
W-Color -Text ┌─[,$(Get-Date -Format HH:mm),]─╼,  $user@$hostname, ╾╼,  $path, ╾╼, $rbattdisp  $rbatt, $gbattdisp $gbatt, $ybattdisp $ybatt, `n└╼  -Color White, DarkRed, White, Cyan, White, DarkYellow, Red, Green, Yellow, White
	
	
	
}	
	
#	if ($bcolor = green){
#		$gbattdisp = $battdisp
#		$rbattdisp = ""
#		$ybattdisp = ""
#	}
#	elseif ($bcolor = yellow){
#		$gbattdisp = ""
#		$rbattdisp = ""
#		$ybattdisp = $battdisp
#	}
#	elseif ($bcolor = red){
#		$gbattdisp = ""
#		$rbattdisp = $battdisp
#		$ybattdisp = ""
#	}


$env:PYTHONIOENCODING="utf-8"
Import-Module Get-ChildItemColor
iex "$(thefuck --alias)"




#import-module posh-git
#import-module "oh-my-posh" -disableNameChecking -noclobber 
import-module pscolor
import-module psreadline
#import-module crayon
Import-Module TabExpansionPlusPlus

. "$PSScriptRoot\Include\alias.ps1" 
#try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }
#function prompt {
#		$batt = (Get-WmiObject win32_battery).estimatedChargeRemaining
#		write-host ("sss") -nonewline
#	}