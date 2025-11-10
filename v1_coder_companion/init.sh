#!/bin/bash

# Define installation directory and desktop shortcut path
INSTALL_DIR="$HOME/.bluna-ai"
DESKTOP_DIR="$HOME/Desktop"
SHORTCUT_PATH="$DESKTOP_DIR/Bluna-AI.desktop"

# Function to detect package manager
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v yay &> /dev/null; then
        echo "yay"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v brew &> /dev/null; then
        echo "brew"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    else
        echo "unknown"
        echo "Please install Julia manually."
        exit 1
    fi
}

# Function to install dialog based on package manager
install_dialog() {
    pkg_manager=$(detect_package_manager)
    case $pkg_manager in
        "apt")
            sudo apt-get install dialog -y
            ;;
        "yay")
            yay -S dialog --noconfirm
            ;;
        "pacman")
            sudo pacman -S dialog --noconfirm
            ;;
        "brew")
            brew install dialog
            ;;
        "dnf")
            sudo dnf install dialog -y
            ;;
        *)
            echo "Could not detect package manager. Please install dialog manually."
            exit 1
            ;;
    esac
}

# Check if dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "Installing dialog package..."
    install_dialog
fi

# Create installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Copy program files to installation directory
cp -r "$(dirname "$0")"/* "$INSTALL_DIR/"

# Create desktop shortcut
cat > "$SHORTCUT_PATH" << EOL
[Desktop Entry]
Name=Bluna AI
Comment=Launch Bluna AI
Exec=julia "$INSTALL_DIR/main.jl"
Terminal=true
Type=Application
Categories=Application;
Icon=$INSTALL_DIR/../images/Bluna-AI.ico
EOL

# Make the desktop shortcut executable
chmod +x "$SHORTCUT_PATH"

# Pull phi3 model
ollama pull phi3

# Run the program for the first time
julia "$INSTALL_DIR/setup.jl"

echo "Installation completed! You can now launch Bluna AI from your desktop."
