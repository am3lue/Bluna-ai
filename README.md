<img src="./images/Bluna-AI-logo.png" alt="Bluna AI Logo" width="200" height="200" style="display: block; margin: auto; border-radius: 50%;" align="center"/>

**Bluna AI** is an intelligent, local **terminal-based coding assistant** powered by the **Qwen2.5-coder:0.5b** model through Ollama.  
Perfect for **beginners and seasoned developers** who want a **private, customizable AI mentor** to guide them, help them practice, and build consistent coding habits with **intelligent web search capabilities**.

---

## 🚀 Key Features

- 💻 **Multi-Language Support** – Works with Julia, Python, C/C++, Rust, Go, PHP, SQL, Web Development, and many others.
- 🧠 **Intelligent AI Tutor** – Powered by Qwen2.5-coder:0.5b with specialized coding instruction capabilities.
- 🌐 **Smart Web Search** – When current information is needed, automatically searches DuckDuckGo for up-to-date answers with source attribution.
- 🧩 **Memory System** – Remembers your preferences, learning style, and previous conversations for personalized assistance.
- 📅 **Learning Scheduler** – Creates customized study schedules and learning plans.
- 🪶 **Completely Private & Lightweight** – Runs 100% offline using Ollama (zero data leaves your machine).
- 🧰 **Beautiful TUI** – Intuitive, Carbon-Blue themed terminal interface for a smooth experience.
- ⚙️ **Cross-Platform** – Fully compatible with Windows, macOS, and Linux.

---

## 📦 Available Versions

- **v2 Analyst Release**: Advanced AI assistant with web scraping, memory management, and scheduler features
- **v1 Coder Companion**: Streamlined coding companion focused on direct programming assistance

---

## 🚀 Quick Installation

### For v2 Analyst Release

**Linux/macOS:**
```bash
./setup
```

**Windows:**
```batch
setup.bat
```

### For v1 Coder Companion

**Linux/macOS:**
```bash
cd v1_coder_companion
./setup
```

**Windows:**
```batch
cd v1_coder_companion
setup.bat
```

---

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

---

## 🛠️ Installation Methods

### Method 1: Automatic Installation (Recommended)

#### Linux/macOS
1. Download or clone the Bluna AI repository
2. Open terminal in the project directory
3. Run the setup script:
   ```bash
   chmod +x setup
   ./setup
   ```
4. Follow the prompts to complete installation

#### Windows
1. Download or clone the Bluna AI repository
2. Open Command Prompt or PowerShell as Administrator
3. Navigate to the project directory
4. Run the setup script:
   ```batch
   setup.bat
   ```
5. Follow the prompts to complete installation

### Method 2: Custom Installation Directory

```bash
# Linux/macOS
./setup /path/to/custom/installation

# Windows
setup.bat "C:\path\to\custom\installation"
```

### Method 3: Manual Installation

1. Download and install [Ollama](https://github.com/ollama/ollama/releases/latest) for your operating system.
2. Pull the Qwen2.5-coder model:
```bash
ollama pull qwen2.5-coder:0.5b
```
3. Clone the repository:
```bash
git clone https://github.com/am3lue/bluna-ai.git
cd bluna-ai/v2_analyst_release
```
4. Launch Bluna AI:
```bash
julia --project=. main.jl
```

### Method 4: Package Manager Installation

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

---

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

---

## 🧠 AI Model Setup

The installation process will attempt to download a recommended Ollama model:
- **v2 Analyst Release**: `qwen2.5-coder:0.5b`
- **v1 Coder Companion**: `phi3`

If automatic download fails, you can manually install models:
```bash
ollama pull qwen2.5-coder:0.5b  # For v2
ollama pull phi3                 # For v1
```

---

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

---

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
chmod +x setup
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

---

## 📚 Usage Examples

### Basic Coding Help
```
User > What is recursion?
Bluna > Recursion is when a function calls itself to solve a problem...
```

### Current Information Queries
```
User > What is the latest Python version?
Bluna > 🔍 Let me search for the latest Python version...
Bluna > Based on my search, Python 3.12 is the latest stable version...
Sources:
- https://www.python.org/downloads/
```

### Personal Memory
```
User > Remember that I prefer learning with examples
Bluna > Got it! I'll remember you prefer examples in my explanations.
```

### Study Planning
```
User > Create schedule
Bluna > I'll create a personalized learning schedule for you...
```

### v2 Analyst Release Features
- **Memory Management**: "Remember that I prefer Python over JavaScript"
- **Learning Schedules**: "Create a schedule for learning Rust on weekends"
- **Web Research**: Ask questions that require current information
- **Interactive Teaching**: Multiple teaching styles available

### v1 Coder Companion Features
- **Direct Code Help**: Ask specific programming questions
- **Quick Solutions**: Get immediate coding assistance
- **Streamlined Interface**: Focus on coding productivity

---

## 🛠️ Project Structure

- **`v1_coder_companion/`** - Original v1 implementation with classic interface
- **`v2_analyst_release/`** - Current version with enhanced AI capabilities and web search

### Current Version: v2.1 (Smart & Friendly Release)

- **Enhanced AI Integration** - Qwen2.5-coder:0.5b model for better coding assistance
- **Web Search Capabilities** - Intelligent DuckDuckGo integration for current information
- **Memory System** - Persistent user preferences and conversation history
- **Learning Scheduler** - Personalized study plan generation

---

## 🤝 Our Amazing Contributors

A huge thank you to the talented team that made Bluna AI possible:

- **[am3lue](https://github.com/am3lue)** (Francis Masanja) – Lead Developer  
- **[emmatiko](https://github.com/emma7iko)** (Emmanuel Matiko) – Project Manager  
- **[Minza](https://github.com/minzaaa19)** (Minza Blue) – Debugging & Quality Assurance  
- **[ayryn](https://github.com/irynsy811-cyber)** (Ireen Sebastian) – AI Specialist  

Their passion and expertise turned this idea into a powerful, friendly learning companion.

---

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

---

## 🎯 Next Steps

1. **Complete Setup**: Run the interactive wizard on first launch
2. **Explore Features**: Try different commands and teaching styles
3. **Create Learning Plans**: Use the scheduler for structured learning
4. **Customize**: Modify `config.json` for personalized experience

---

## 📈 What's Next (Future Roadmap)

### v2.2 - Enhanced Reliability (Next Release)
1. **Multi-Engine Search** - Add Bing/Google backup for web searches
2. **Improved Error Handling** - Better timeout and connection management
3. **Enhanced Source Filtering** - Better search result quality

### v2.3 - Learning Experience
1. **Interactive Quizzes** - Skill assessment and practice modes
2. **Progress Visualization** - Better tracking and achievement systems
3. **Extended Language Support** - More programming languages

### v3.0 - Major Evolution
1. **Web Interface** - Full GUI with rich interactions
2. **Code Execution** - Live code running and testing
3. **Advanced Analytics** - Deep learning insights and recommendations

---

## 🤝 Contributing

Contributions are welcome! Please read CONTRIBUTING.md for guidelines.

### How You Can Help

#### For Developers
- **Contribute Code** - Pick an item from the roadmap and start coding
- **Bug Reports** - Help us identify and fix issues
- **Feature Ideas** - Share your suggestions for new capabilities

#### For Users
- **Feedback** - Tell us what works well and what could be better
- **Testing** - Try out new features and report your experience
- **Documentation** - Help improve guides and examples

#### For Designers
- **UI/UX Improvements** - Make Bluna even more beautiful and user-friendly
- **Visual Learning Aids** - Create diagrams and illustrations for complex concepts

---

## 📄 License

This project is open source. See LICENSE file for details.

---

## 🔮 The Vision

Imagine Bluna AI as your personal coding mentor who:
- **Knows You** - Remembers your learning style, preferences, and progress
- **Stays Current** - Always has the latest information about programming languages and tools
- **Makes Learning Fun** - Uses interactive methods, games, and visual aids
- **Grows With You** - Adapts to your increasing skill level and changing interests
- **Connects Communities** - Links learners with mentors, study groups, and resources

---

**Enjoy learning with Bluna AI!** 🌙💙

For the latest updates and documentation, visit our [GitHub repository](https://github.com/am3lue/bluna-ai). We'd love to see you there! 🚀
