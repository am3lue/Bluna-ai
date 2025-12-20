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

## 📦 Installation

### Quick Start (Recommended)

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

### Manual Setup

1. Install Julia (1.9+ recommended):
   - Windows: [Julia Downloads](https://julialang.org/downloads/)
   - Linux/macOS: [julialang.org](https://julialang.org/downloads/)
2. Install Ollama:
   - Linux: `curl -fsSL https://ollama.ai/install.sh | sh`
   - macOS: [Download .dmg](https://github.com/ollama/ollama/releases/latest)
   - Windows: [Download installer](https://github.com/ollama/ollama/releases/latest)
3. Pull the AI model:
```bash
ollama pull qwen2.5-coder:0.5b
```
4. Clone and setup the project:
```bash
git clone https://github.com/am3lue/bluna-ai.git
cd bluna-ai/v2_analyst_release
julia --project=. main.jl
```

### First Run

On your first launch, Bluna AI will:
- Set up your personal profile
- Learn your name and preferred learning style
- Configure optimal settings for your experience

---

## 🤝 Our Amazing Contributors

A huge thank you to the talented team that made Bluna AI possible:

- **[am3lue](https://github.com/am3lue)** (Francis Masanja) – Lead Developer  
- **[emmatiko](https://github.com/emma7iko)** (Emmanuel Matiko) – Project Manager  
- **[Minza](https://github.com/minzaaa19)** (Minza Blue) – Debugging & Quality Assurance  
- **[ayryn](https://github.com/irynsy811-cyber)** (Ireen Sebastian) – AI Specialist  

Their passion and expertise turned this idea into a powerful, friendly learning companion.

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

## 📖 Usage Examples

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

---

For the latest updates, source code, and community chat, visit our [GitHub repository](https://github.com/am3lue/bluna-ai). We'd love to see you there! 🚀
