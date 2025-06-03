REM Created by @goldentrophy on Discord

@echo off
setlocal enabledelayedexpansion
chcp ANSI

cls
title BepInEx Patcher // [#---------] Getting directory
color 0e

set steamPath1="C:/Program Files (x86)/Steam/steamapps/common/Gorilla Tag"
set steamPath2="D:/SteamLibrary/steamapps/common/Gorilla Tag"
set steamPath3="C:/Program Files/Oculus/Software/Software/another-axiom-gorilla-tag"

if exist %steamPath1% (
    set gamePath=%steamPath1%
) else if exist %steamPath2% (
    set gamePath=%steamPath2%
) else if exist %steamPath3% (
    set gamePath=%steamPath3%
) else (
    color 0c
    set /p userPath=Gorilla Tag directory not found.
    pause
    exit /b
)

color 0e
cls
title BepInEx Patcher // [###-------] Downloading BepInEx
curl -L "https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.3/BepInEx_win_x64_5.4.23.3.zip" -o BPNX54232.zip

powershell -command "Expand-Archive -Path 'BPNX54232.zip' -DestinationPath '%gamePath%' -Force"

cls
title BepInEx Patcher // [####------] Creating directories
mkdir %gamePath%/BepInEx/config
mkdir %gamePath%/BepInEx/plugins

cls
title BepInEx Patcher // [#####-----] Downloading latest config
curl https://raw.githubusercontent.com/iiDk-the-actual/ModInfo/refs/heads/main/BepInEx.cfg -o %gamePath%/BepInEx/config/BepInEx.cfg

cls
title BepInEx Patcher // [#######---] Downloading menu
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
title BepInEx Patcher // [##########] Finished
echo Finished patching BepInEx

pause
del "BPNX54232.zip"