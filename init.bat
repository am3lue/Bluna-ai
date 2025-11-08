@echo off
setlocal enabledelayedexpansion

echo Installing Julia and Ollama...

:: Check admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Please run this script as Administrator
    pause
    exit /b 1
)

:: Create program directory
set "INSTALL_DIR=%USERPROFILE%\Bluna-ai"
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
    if %errorlevel% neq 0 (
        echo Error: Failed to create program directory
        pause
        exit /b 1
    )
)

:: Copy program files
echo Copying program files...
xcopy /E /I /Y "%~dp0*" "%INSTALL_DIR%"

:: Create temporary directory for downloads
if exist "%TEMP%\installer_temp" rmdir /s /q "%TEMP%\installer_temp"
mkdir "%TEMP%\installer_temp" || (
    echo Error: Failed to create temporary directory
    pause
    exit /b 1
)
cd "%TEMP%\installer_temp"

:: Download Julia installer
echo Downloading Julia...
curl -L -o julia-installer.exe "https://julialang-s3.julialang.org/bin/winnt/x64/1.9/julia-1.9.3-win64.exe"
if %errorlevel% neq 0 (
    echo Error: Failed to download Julia
    goto :cleanup
)

:: Install Julia silently
echo Installing Julia...
start /wait julia-installer.exe /SILENT /DIR="%ProgramFiles%\Julia"
if %errorlevel% neq 0 (
    echo Error: Failed to install Julia
    goto :cleanup
)

:: Add Julia to PATH
setx PATH "%PATH%;%ProgramFiles%\Julia\bin" /M
if %errorlevel% neq 0 (
    echo Error: Failed to update PATH
    goto :cleanup
)

:: Download Ollama
echo Downloading Ollama...
curl -L -o ollama-installer.msi "https://github.com/jmorganca/ollama/releases/latest/download/ollama-windows-amd64.msi"
if %errorlevel% neq 0 (
    echo Error: Failed to download Ollama
    goto :cleanup
)

:: Install Ollama
echo Installing Ollama...
msiexec /i ollama-installer.msi /quiet
if %errorlevel% neq 0 (
    echo Error: Failed to install Ollama
    goto :cleanup
)

:: Wait for Ollama service to start
echo Waiting for Ollama service to start...
timeout /t 10 /nobreak

:: Pull phi3 model
echo Downloading phi3 model...
ollama pull phi3
if %errorlevel% neq 0 (
    echo Error: Failed to download phi3 model
    goto :cleanup
)

:: Create desktop shortcut
echo Creating desktop shortcut...
set "SHORTCUT=%USERPROFILE%\Desktop\Bluna-AI.bat"
(
echo @echo off
echo cd "%INSTALL_DIR%"
if not exist "%INSTALL_DIR%\setup_done.txt" (
    echo julia setup.jl
    echo. > "%INSTALL_DIR%\setup_done.txt"
) else (
    echo julia main.jl
)
echo pause
) > "%SHORTCUT%"

:cleanup
:: Clean up
cd ..
rmdir /s /q "%TEMP%\installer_temp"

if %errorlevel% equ 0 (
    echo Installation complete!
    echo A shortcut has been created on your desktop.
    echo Please restart your terminal to use Julia and Ollama.
) else (
    echo Installation failed!
)

pause
exit /b %errorlevel%