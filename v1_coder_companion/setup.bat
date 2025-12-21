@echo off
setlocal EnableDelayedExpansion

:: Bluna AI v1 Coder Companion Windows Setup Script
:: Supports Windows 10/11

echo [INFO] Bluna AI v1 Coder Companion Setup - Windows Installer
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [WARNING] Not running as administrator
    echo Some installations may require administrator privileges
    echo.
    set /p "continue=Continue anyway? (y/N): "
    if /i not "!continue!"=="y" (
        echo [ERROR] Installation cancelled
        pause
        exit /b 1
    )
)

:: Check for package managers
echo [INFO] Checking for package managers...

:: Check for Chocolatey
where choco >nul 2>&1
if %errorLevel% equ 0 (
    set "PKG_MANAGER=choco"
    goto :install_deps
)

:: Check for Winget
where winget >nul 2>&1
if %errorLevel% equ 0 (
    set "PKG_MANAGER=winget"
    goto :install_deps
)

echo [WARNING] No supported package manager found
echo Please install Julia and other dependencies manually
echo Visit: https://julialang.org/downloads/
echo.
pause
exit /b 1

:install_deps
echo [INFO] Using package manager: %PKG_MANAGER%

:: Install system dependencies
echo [INFO] Installing system dependencies...
if "%PKG_MANAGER%"=="choco" (
    choco install git -y
    choco install curl -y
) else if "%PKG_MANAGER%"=="winget" (
    winget install --id Git.Git -e --source winget
    winget install --id cURL.cURL -e --source winget
)

:: Install Julia
echo [INFO] Checking Julia installation...
julia --version >nul 2>&1
if %errorLevel% equ 0 (
    for /f "tokens=3" %%i in ('julia --version') do set "JULIA_VERSION=%%i"
    echo [SUCCESS] Julia is already installed (version !JULIA_VERSION!)
) else (
    echo [INFO] Installing Julia...
    if "%PKG_MANAGER%"=="choco" (
        choco install julia -y
    ) else if "%PKG_MANAGER%"=="winget" (
        winget install --id JulianLanguage.Julia -e --source winget
    )
    
    :: Verify installation
    julia --version >nul 2>&1
    if !errorLevel! neq 0 (
        echo [ERROR] Julia installation failed
        echo Please install Julia manually from https://julialang.org/downloads/
        pause
        exit /b 1
    ) else (
        for /f "tokens=3" %%i in ('julia --version') do set "JULIA_VERSION=%%i"
        echo [SUCCESS] Julia installed successfully (version !JULIA_VERSION!)
    )
)

:: Install Ollama
echo [INFO] Checking Ollama installation...
ollama --version >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Ollama is already installed
) else (
    echo [INFO] Ollama installation required
    echo Please install Ollama manually from https://ollama.ai/download
    echo [WARNING] You can install it later, but some features will not work
    set /p "continue=Continue with installation? (y/N): "
    if /i not "!continue!"=="y" (
        echo [INFO] Skipping Ollama installation
        goto :julia_packages
    )
)

:julia_packages
:: Install Julia packages
echo [INFO] Installing Julia packages...

:: Create a temporary Julia script to install packages
echo using Pkg > install_packages.jl
echo Pkg.add("HTTP") >> install_packages.jl
echo Pkg.add("JSON") >> install_packages.jl
echo Pkg.add("Crayons") >> install_packages.jl
echo Pkg.add("FIGlet") >> install_packages.jl
echo Pkg.add("TOML") >> install_packages.jl
echo Pkg.add("Dates") >> install_packages.jl

julia install_packages.jl
del install_packages.jl

if %errorLevel% equ 0 (
    echo [SUCCESS] Julia packages installed successfully
) else (
    echo [ERROR] Failed to install Julia packages
    pause
    exit /b 1
)

:: Create desktop shortcut
echo [INFO] Creating desktop shortcut...
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\Bluna-AI-v1.bat"

echo @echo off > "%SHORTCUT%"
echo cd /d "%~dp0" >> "%SHORTCUT%"
echo julia main.jl >> "%SHORTCUT%"
echo pause >> "%SHORTCUT%"

echo [SUCCESS] Desktop shortcut created: %SHORTCUT%

:: Pull recommended Ollama model
echo [INFO] Pulling recommended Ollama model (this may take a while)...
ollama pull phi3 >nul 2>&1
if !errorLevel! equ 0 (
    echo [SUCCESS] Ollama model downloaded successfully
) else (
    echo [WARNING] Failed to download Ollama model
)

:: Run initial setup
echo [INFO] Running initial setup...
julia setup.jl

if %errorLevel% equ 0 (
    echo.
    echo [SUCCESS] Bluna AI v1 Coder Companion installed successfully!
    echo.
    echo To start Bluna AI v1, run:
    echo   julia main.jl
    echo.
    echo Or use the desktop shortcut: %SHORTCUT%
    echo.
    echo Happy coding with Bluna AI! 🚀💙
) else (
    echo [ERROR] Initial setup failed
)

echo.
pause
