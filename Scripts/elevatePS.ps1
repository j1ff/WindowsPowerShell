start-process -filepath powershell.exe -argumentlist @('-command','Set-ExecutionPolicy Bypass') -verb runas -scope localmachine
set-consolefont 12