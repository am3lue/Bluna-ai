<img src="./images/Bluna-AI-logo.png" alt="Bluna AI Logo" width="200" height="200" style="display: block; margin: auto; border-radius: 50%;"/>


**Bluna AI** is a lightweight, fully local **terminal-based coding assistant** powered by the **Phi-3-mini (3.8B)** model through Ollama.  
Perfect for **beginners and seasoned developers** who want a **private, customizable AI mentor** to guide them, help them practice, and build consistent coding habits.

---

## 🚀 Key Features

- 💻 **Multi-Language Support** – Works with Julia, Python, C/C++, Rust, Go, PHP, SQL, Web Development, and many others.
- 🧠 **Personalized AI Behavior** – Adjust Bluna’s tone, teaching style, and focus to fitily match your learning goals.
- 🧩 **Daily Coding Challenges** – Optional gentle reminders with fresh exercises to keep your skills growing.
- 🪶 **Completely Private & Lightweight** – Runs 100% offline using Ollama (zero data leaves your machine).
- 🧰 **Beautiful TUI** – Intuitive, Carbon-Blue themed terminal interface for a smooth experience.
- ⚙️ **Cross-Platform** – Fully compatible with Windows, macOS, and Linux.

---

## 📦 Installation

### Automatic Setup (Recommended)

1. Download and install [Ollama](https://github.com/ollama/ollama/releases/latest) for your operating system.
2. Clone the repository:
```bash
git clone https://github.com/am3lue/bluna-ai.git
cd bluna-ai
```
3. Run the setup script:
   - **Windows**: Double-click `init.bat` (run as administrator)
   - **Linux/macOS**: `./init.sh`

### Manual Setup

1. Install Julia:
   - Windows: [Julia 1.9.3 (64-bit)](https://julialang-s3.julialang.org/bin/winnt/x64/1.9/julia-1.9.3-win64.exe)
   - Linux/macOS: [julialang.org](https://julialang.org/downloads/)
2. Install Ollama:
   - Linux: `curl -fsSL https://ollama.ai/install.sh | sh`
   - macOS: [Download .dmg](https://github.com/ollama/ollama/releases/latest)
   - Windows: [Download installer](https://github.com/ollama/ollama/releases/latest)
3. Download this repo as ZIP and extract it.
4. Open Julia REPL and install required packages:
```julia
import Pkg
Pkg.add("HTTP")
Pkg.add("JSON3")
Pkg.add("Crayons")
```
5. Go to the extracted folder and launch Bluna:
```julia
include("bluna.jl")
```

### Resetting Bluna

To start fresh (clear settings, history, etc.), run the reset script from the project folder:
```julia
include("reset.jl")
```

---

## 🤝 Our Amazing Contributors

A huge thank you to the talented team that made Bluna AI possible:

- **[am3lue](https://github.com/am3lue)** (Francis Masanja) – Lead Developer  
- **[emmatiko](https://github.com/emma7iko)** (Emmanuel Matiko) – Project Manager  
- **[Minza](https://github.com/minzaaa19)** (Minza Blue) – Debugging & Quality Assurance  
- **[ayryn](https://github.com/irynsy811-cyber)** (Ireen Sebastian) – AI Specialist  

Their passion and expertise turned this idea into a powerful, friendly learning companion.

---

For the latest updates, source code, and community chat, visit our [GitHub repository](https://github.com/am3lue/bluna-ai). We’d love to see you there! 🚀