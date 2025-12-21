# Bluna AI - Cross-Platform Installation Guide

🌙 **Bluna AI** is an intelligent programming assistant designed to help you learn coding with AI-powered guidance and personalized learning schedules.

## 📦 Available Versions

- **v2 Analyst Release**: Advanced AI assistant with web scraping, memory management, and scheduler features
- **v1 Coder Companion**: Streamlined coding companion focused on direct programming assistance

## 🚀 Quick Installation

### For v2 Analyst Release

**Linux/macOS:**
```bash
./setup_cross_platform.sh
```

**Windows:**
```batch
setup_windows.bat
```

### For v1 Coder Companion

**Linux/macOS:**
```bash
cd v1_coder_companion
./setup_cross_platform.sh
```

**Windows:**
```batch
cd v1_coder_companion
setup_windows.bat
```

## 📋 System Requirements

### Minimum Requirements
- **Operating System**: Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+, CentOS 7+, or equivalent)
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 2GB free space
- **Internet**: Required for initial setup and AI model downloads

### Dependencies Installed Automatically
- **Julia** (1.9+): Programming language runtime
- **Ollama**: Local AI model runner
- **Required Julia Packages**: HTTP, JSON, Crayons, FIGlet, Cascadia, Gumbo, etc.

### Optional (Auto-installed when available)
- **Git**: Version control system
- **curl/wget**: Download utilities
- **Build tools**: For package compilation

## 🛠️ Installation Methods

### Method 1: Automatic Installation (Recommended)

#### Linux/macOS
1. Download or clone the Bluna AI repository
2. Open terminal in the project directory
3. Run the setup script:
   ```bash
   chmod +x setup_cross_platform.sh
   ./setup_cross_platform.sh
   ```
4. Follow the prompts to complete installation

#### Windows
1. Download or clone the Bluna AI repository
2. Open Command Prompt or PowerShell as Administrator
3. Navigate to the project directory
4. Run the setup script:
   ```batch
   setup_windows.bat
   ```
5. Follow the prompts to complete installation

### Method 2: Custom Installation Directory

```bash
# Linux/macOS
./setup_cross_platform.sh /path/to/custom/installation

# Windows
setup_windows.bat "C:\path\to\custom\installation"
```

### Method 3: Package Manager Installation

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install julia curl wget git
```

#### macOS
```bash
brew install julia git
```

#### Windows (Chocolatey)
```powershell
choco install julia git
```

## 🔧 Post-Installation

### First Run
1. Launch Bluna AI:
   ```bash
   # v2 Analyst Release
   julia ~/.bluna-ai/main.jl
   
   # v1 Coder Companion
   julia ~/.bluna-ai/v1_coder_companion/main.jl
   ```

2. Complete the interactive setup wizard
3. Choose your preferences:
   - Programming language to learn
   - Teaching style (Friendly, Socratic, Concise)
   - Learning genre (General Basics, Data Structures, etc.)

### Desktop Shortcuts
- **Linux**: Desktop shortcut created automatically
- **macOS**: Application bundle created in ~/Applications
- **Windows**: Batch file shortcut created on Desktop

## 🧠 AI Model Setup

The installation process will attempt to download a recommended Ollama model:
- **v2 Analyst Release**: `qwen2.5-coder:0.5b`
- **v1 Coder Companion**: `phi3`

If automatic download fails, you can manually install models:
```bash
ollama pull qwen2.5-coder:0.5b  # For v2
ollama pull phi3                 # For v1
```

## 🗂️ File Structure

After installation:
```
~/.bluna-ai/
├── main.jl                 # v2 main application
├── config.json            # User configuration
├── bluna_memory.json      # AI memory storage
├── v1_coder_companion/    # v1 application
│   ├── main.jl
│   └── setup.jl
├── images/               # Application icons
└── *.md                  # Generated learning plans
```

## 🔧 Troubleshooting

### Common Issues

**Julia not found after installation:**
```bash
# Add Julia to PATH (Linux/macOS)
echo 'export PATH="$PATH:/opt/julia/bin"' >> ~/.bashrc
source ~/.bashrc

# Windows: Restart command prompt or add to PATH manually
```

**Permission denied errors:**
```bash
# Linux/macOS: Make scripts executable
chmod +x setup_cross_platform.sh
```

**Ollama connection issues:**
```bash
# Start Ollama service
ollama serve

# Check if running
curl http://localhost:11434
```

**Package installation failures:**
```bash
# Manual Julia package installation
julia -e 'using Pkg; Pkg.add("HTTP")'
```

### Manual Dependencies

If automatic installation fails, install manually:

#### Julia Installation
1. Visit [Julia Downloads](https://julialang.org/downloads/)
2. Download for your operating system
3. Install following platform-specific instructions

#### Ollama Installation
1. Visit [Ollama Downloads](https://ollama.ai/download)
2. Download and install for your platform
3. Start the service: `ollama serve`

## 📚 Usage Examples

### v2 Analyst Release Features
- **Memory Management**: "Remember that I prefer Python over JavaScript"
- **Learning Schedules**: "Create a schedule for learning Rust on weekends"
- **Web Research**: Ask questions that require current information
- **Interactive Teaching**: Multiple teaching styles available

### v1 Coder Companion Features
- **Direct Code Help**: Ask specific programming questions
- **Quick Solutions**: Get immediate coding assistance
- **Streamlined Interface**: Focus on coding productivity

## 🆘 Support

### Getting Help
1. Check the troubleshooting section above
2. Verify all dependencies are installed correctly
3. Ensure Ollama is running: `ollama serve`
4. Check Julia is accessible: `julia --version`

### Log Files
- Check console output for detailed error messages
- Installation logs are displayed in real-time
- AI interactions are stored in `bluna_memory.json`

### Uninstallation
```bash
# Remove installation directory
rm -rf ~/.bluna-ai

# Remove desktop shortcuts
rm ~/Desktop/Bluna-AI.desktop          # Linux
rm ~/Desktop/Bluna-AI.bat             # Windows
```

## 🎯 Next Steps

1. **Complete Setup**: Run the interactive wizard on first launch
2. **Explore Features**: Try different commands and teaching styles
3. **Create Learning Plans**: Use the scheduler for structured learning
4. **Customize**: Modify `config.json` for personalized experience

## 📄 License

This project is open source. See LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please read CONTRIBUTING.md for guidelines.

---

**Enjoy learning with Bluna AI!** 🌙💙

For the latest updates and documentation, visit the project repository.

