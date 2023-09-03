@echo off
@pushd %~dp0 & fltmc | find "." && (powershell start '%~f0' ' %*' -verb runas 2>nul && exit /b)
:: Set the PowerShell execution policy to Unrestricted
powershell -ExecutionPolicy Unrestricted -Command "Set-ExecutionPolicy Unrestricted -Scope Process"

:: Download and run the PowerShell script from your GitHub repository
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\src\Custom.ps1"