REM Created by @crimsoncauldron on Discord
REM To use, hit Ctrl + S, then select "Save as type", and click "All files (*.*)". Make sure its name is "installer.bat".
REM If on Discord, hit the download button and run it.

@echo off
setlocal enabledelayedexpansion
chcp ANSI

cls
title ii's Stupid Menu Installer // [#---------] Getting directory
color 0e

set steamPath1="C:/Program Files (x86)/Steam/steamapps/common/Gorilla Tag"
set steamPath2="D:/SteamLibrary/steamapps/common/Gorilla Tag"
set steamPath3="C:/Program Files/Oculus/Software/Software/another-axiom-gorilla-tag"
set steamPath4="D:/Steam/steamapps/common/Gorilla Tag"

if exist %steamPath1% (
    set gamePath=%steamPath1%
) else if exist %steamPath2% (
    set gamePath=%steamPath2%
) else if exist %steamPath3% (
    set gamePath=%steamPath3%
) else if exist %steamPath4% (
    set gamePath=%steamPath4%
) else (
    color 0c
    set /p userPath=Gorilla Tag directory not found.
    pause
    exit /b
)

color 0e
cls
title ii's Stupid Menu Installer // [###-------] Downloading BepInEx
curl -L "https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.4/BepInEx_win_x64_5.4.23.4.zip" -o BPNX54234.zip

powershell -command "Expand-Archive -Path 'BPNX54234.zip' -DestinationPath '%gamePath%' -Force"

cls
title ii's Stupid Menu Installer // [####------] Creating directories
mkdir %gamePath%/BepInEx/config
mkdir %gamePath%/BepInEx/plugins

cls
title ii's Stupid Menu Installer // [#####-----] Downloading latest config
curl https://raw.githubusercontent.com/iiDk-the-actual/ModInfo/refs/heads/main/BepInEx.cfg -o %gamePath%/BepInEx/config/BepInEx.cfg

cls
title ii's Stupid Menu Installer // [#######---] Downloading menu
for /f "tokens=*" %%i in ('powershell -Command "(Invoke-RestMethod -Uri 'https://api.github.com/repos/iiDk-the-actual/iis.Stupid.Menu/releases/latest').assets | Where-Object { $_.name -like '*.dll' } | Select-Object -ExpandProperty browser_download_url"') do (
    set pluginUrl=%%i
)

if "%pluginUrl%"=="" (
    color 0c
    echo Failed to get latest release of menu, please report to Discord
    pause
    exit /b
)

color 0e
curl -L "%pluginUrl%" -o %gamePath%/BepInEx/plugins/"ii's Stupid Menu.dll"

cls
title ii's Stupid Menu Installer // [##########] Finished
echo Congratulations, you now have the menu!

del "BPNX54234.zip"

pause
