
$ps_script_dir = "C:\Users\Keith\Documents\WindowsPowerShell\Scripts"

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Function prompt {“╭─╼ [$here]/n╰─────╼$(Get-Date)“}







$env:PYTHONIOENCODING="utf-8"
Import-Module Get-ChildItemColor
iex "$(thefuck --alias)"



import-module Get-ChildItemColor
import-module posh-git
#import-module "oh-my-posh" -disableNameChecking -noclobber 
import-module pscolor
import-module psreadline
#import-module crayon
Import-Module TabExpansionPlusPlus

. "$PSScriptRoot\Include\alias.ps1" 