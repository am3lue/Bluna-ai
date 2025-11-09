<img src="./images/Bluna-AI-logo.png" alt="Bluna AI Logo" width="200" height="200" style="display: block; margin: auto; border-radius: 50%;"/>


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

1. Download and install [Ollama](https://github.com/ollama/ollama/releases/latest) for your OS
2. Clone the repository:
```bash
git clone https://github.com/am3lue/bluna-ai.git
cd bluna-ai
```
3. Run the initialization script:
    - Windows: Run `init.bat` as administrator 
    - Linux/macOS: Run `./init.sh`

### Manual Installation

1. Download and install Julia:
     - Windows: [Julia 1.9.3 (64-bit)](https://julialang-s3.julialang.org/bin/winnt/x64/1.9/julia-1.9.3-win64.exe)
     - Linux/macOS: [julialang.org](https://julialang.org/downloads/)
2. Install Ollama manually:
     - Linux: `curl -fsSL https://ollama.ai/install.sh | sh`
     - macOS: [Download .dmg](https://github.com/ollama/ollama/releases/latest)
     - Windows: [Download installer](https://github.com/ollama/ollama/releases/latest)
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

## 🤝 Contributors

We are grateful for the contributions of our dedicated team members who have helped bring Bluna AI to life:
- **[Blue-Francis](https://github.com/am3lue)** (Francis Masanja) - Lead Developer and Project Manager
- **[Minza ](https://github.com/Minzaaa)** (Minza Blue) - UI/UX Designer and Frontend Developer
- **[Ireen ](https://github.com/ayren)** (Ireen Sebastian) - Backend Developer and AI Specialist

Their expertise and commitment have been invaluable in creating a robust and user-friendly programming companion.

---

For more information, updates, and community discussions, feel free to check out our [GitHub repository](https://github.com/am3lue/bluna-ai) and join our community!