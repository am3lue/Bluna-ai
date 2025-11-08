#!/bin/bash

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

# Additional code can be added here if needed
# For example, you might want to add a message indicating successful installation
echo "Dialog package installed successfully."
