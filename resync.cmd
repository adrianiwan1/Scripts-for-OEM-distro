echo off
REM Sprawdzenie czy jest administrator
if ("%1")==("") GOTO ELEVATE
REM Elevation passed in our current directory
cd /D %1
call :RegisterLocale
echo LZAinstalowano ^^^^.
REM pause
goto END
:RegisterLocale
net start w32time
w32tm /resync /force
goto END
:ELEVATE
echo Need administrator permissions to install locales
call powershell -command "try{Start-Process 'resync.cmd' -Verb Runas -ArgumentList %CD%}catch{exit 1}"
if (%ErrorLevel%)==(1) GOTO FAILED
goto END
:FAILED
msg "%username%" Permissions were not granted to install locales on this machine.
goto END

:END


