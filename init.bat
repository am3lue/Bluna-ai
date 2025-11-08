@echo off
setlocal enabledelayedexpansion

echo ============================================
echo      Installing Julia and Ollama...
echo ============================================

:: Check admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Please run this script as Administrator.
    pause
    exit /b 1
)

:: Create program directory
set "INSTALL_DIR=%USERPROFILE%\Bluna-ai"
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
    if %errorlevel% neq 0 (
        echo Error: Failed to create program directory.
        pause
        exit /b 1
    )
)

:: Copy program files
echo Copying program files...
xcopy /E /I /Y "%~dp0*" "%INSTALL_DIR%" >nul
if %errorlevel% neq 0 (
    echo Error: Failed to copy program files.
    pause
    exit /b 1
)

:: Create temporary directory for downloads
if exist "%TEMP%\installer_temp" rmdir /s /q "%TEMP%\installer_temp"
mkdir "%TEMP%\installer_temp" || (
    echo Error: Failed to create temporary directory.
    pause
    exit /b 1
)
cd "%TEMP%\installer_temp"

:: Install Julia
echo.
echo ============================================
echo Installing Julia...
echo ============================================

where julia >nul 2>&1
if %errorlevel% neq 0 (
    echo Julia not found. Installing via Winget...
    winget install --name Julia --id 9NJNWW8PVKMN.Julia -e --accept-source-agreements --accept-package-agreements
    if %errorlevel% neq 0 (
        echo Error: Julia installation failed.
        goto :cleanup
    )
) else (
    echo Julia is already installed.
)

:: Add Julia to PATH (optional safety)
set "JULIA_PATH=%ProgramFiles%\Julia\bin"
if exist "%JULIA_PATH%" (
    echo Adding Julia to PATH...
    setx PATH "%PATH%;%JULIA_PATH%" /M
)

:: Checking Ollama
echo.
echo ============================================
echo Checking if Ollama exists...
echo ============================================

ollama --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Ollama not found. Downloading installer...
    curl -L -o ollama-installer.msi "https://github.com/jmorganca/ollama/releases/latest/download/ollama-windows-amd64.msi"
    if %errorlevel% neq 0 (
        echo Error: Failed to download Ollama.
        goto :cleanup
    )

    echo Installing Ollama...
    msiexec /i ollama-installer.msi /quiet /norestart
    if %errorlevel% neq 0 (
        echo Error: Failed to install Ollama.
        goto :cleanup
    )
    echo Ollama installed successfully.
) else (
    echo Ollama is already installed.
)

:: Wait for Ollama service
echo Waiting for Ollama service to start...
timeout /t 10 /nobreak >nul

:: Pull model
echo Downloading phi3 model...
ollama pull phi3
if %errorlevel% neq 0 (
    echo Error: Failed to download phi3 model.
    goto :cleanup
)

:: Create desktop shortcut
echo Creating desktop shortcut...
set "SHORTCUT=%USERPROFILE%\Desktop\Bluna-AI.bat"
(
    echo @echo off
    echo cd "%INSTALL_DIR%"
    echo if not exist "%%INSTALL_DIR%%\setup_done.txt" ^(
    echo     julia setup.jl
    echo     echo. ^> "%%INSTALL_DIR%%\setup_done.txt"
    echo ^) else ^(
    echo     julia main.jl
    echo ^)
    echo pause
) > "%SHORTCUT%"

:: Cleanup
:cleanup
echo Cleaning up temporary files...
cd "%TEMP%"
if exist "%TEMP%\installer_temp" rmdir /s /q "%TEMP%\installer_temp"

echo.
echo ============================================
if %errorlevel% equ 0 (
    echo Installation complete!
    echo A shortcut has been created on your desktop.
    echo Please restart your terminal to use Julia and Ollama.
) else (
    echo Installation encountered some issues.
)
echo ============================================

pause
exit /b 0