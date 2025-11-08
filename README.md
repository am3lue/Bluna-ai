<h1 align="center"> 🌙 Bluna AI </h1>

**Bluna AI** is a lightweight, locally hosted **terminal-based programming companion** powered by the **Phi-3-mini (3.8B)** model via Ollama.  
It's designed for **beginners and developers** who want a **customizable, private AI tutor** that helps them learn, practice, and stay consistent in programming.

---

## 🚀 Features

- 💻 **Multi-language Tutor** – Supports Julia, Python, C/C++, Rust, Go, PHP, SQL, Web Development, and more.
- 🧠 **Customizable AI Personality** – Tailor how Bluna responds to match your tone, goals, and coding journey.
- 🧩 **Daily Practice Challenges** – Optional reminders that keep your skills sharp.
- 🪶 **Lightweight & Private** – Runs fully offline with Ollama (no external APIs).
- 🧰 **TUI Interface** – Clean, Carbon-Blue themed terminal UI for easy interaction.
- ⚙️ **Cross-platform Support** – Works on Windows, macOS, and Linux.

---

## 📦 Installation

### Automatic Installation

### 1. Install Ollama
Download and install Ollama for your OS:
- [Ollama for Windows](https://ollama.ai/download)
- [Ollama for macOS](https://ollama.ai/download)
- [Ollama for Linux](https://ollama.ai/download)

### 2. Pull the Phi-3-mini model
```bash
ollama pull phi3
```

### 3. Install Julia and dependencies

Make sure you have Julia installed, then run:

```julia
using Pkg
Pkg.add(["HTTP", "JSON3", "Crayons"])
```

### 4. Clone this repository

```bash
git clone https://github.com/am3lue/bluna-ai.git
cd bluna-ai
```

### 5. Run Bluna AI

```bash
julia bluna.jl
```

### Manual Installation

1. Download and install Julia from [julialang.org](https://julialang.org/downloads/)
2. Install Ollama manually:
    - Linux: `curl -fsSL https://ollama.ai/install.sh | sh`
    - macOS: Download the .dmg file and follow installation steps
    - Windows: Download and run the installer
3. Download this repository as ZIP and extract
4. Open Julia REPL and install packages:
    ```julia
    import Pkg
    Pkg.add("HTTP")
    Pkg.add("JSON3")
    Pkg.add("Crayons")
    ```
5. Navigate to extracted folder and run:
    ```julia
    include("bluna.jl")
    ```

---