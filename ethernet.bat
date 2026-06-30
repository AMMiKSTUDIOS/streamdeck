@echo off
setlocal

set "ADAPTER=Ethernet"

netsh interface show interface name="%ADAPTER%" | findstr /I "Administrative state" | findstr /I "Enabled" >nul

if errorlevel 1 (
    echo Enabling %ADAPTER%...
    netsh interface set interface name="%ADAPTER%" admin=enabled
) else (
    echo Disabling %ADAPTER%...
    netsh interface set interface name="%ADAPTER%" admin=disabled
)

endlocal