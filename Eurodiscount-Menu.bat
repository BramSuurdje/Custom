@echo off

:: Set the PowerShell execution policy to Unrestricted
powershell -ExecutionPolicy Unrestricted -Command "Set-ExecutionPolicy Unrestricted -Scope Process"

:: Download and run the PowerShell script from your GitHub repository
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/YourGitHubUsername/YourRepoName/YourScript.ps1'))"