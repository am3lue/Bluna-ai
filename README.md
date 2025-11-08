<h1 align="center"> 🌙 Bluna AI </h1>

**Bluna AI** is a lightweight, locally hosted **terminal-based programming companion** powered by the **Phi-3-mini (3.8B)** model via Ollama.  
It’s designed for **beginners and developers** who want a **customizable, private AI tutor** that helps them learn, practice, and stay consistent in programming.

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

### 1. Install Ollama
Download and install Ollama for your OS:
- [Ollama for Windows](https://ollama.ai/download)
- [Ollama for macOS](https://ollama.ai/download)
- [Ollama for Linux](https://ollama.ai/download)

### 2. Pull the Phi-3-mini model
```bash
ollama pull phi3
````

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

---

## 🧩 Project Structure

```
bluna-ai/
│
├── bluna.jl                  # Main program file
├── prompts/                  # Default language prompts
│   ├── julia_general.txt
│   ├── python_algorithms.txt
│   └── ...
├── user_prompts.json         # Custom user-defined prompt settings
├── roadmap.pdf               # 12-hour roadmap plan
└── README.md
```

---

## ⚙️ How It Works

1. Detects your OS, checks Ollama and firewall setup.
2. Lets you choose your **genre** (Basics / DSA) and **language**.
3. Loads the correct base prompt and merges user preferences.
4. Sends prompt to **Phi-3-mini** via the local Ollama API.
5. Streams the model’s response interactively in your terminal.

---

## 💡 Future Plans

* 🧭 **Progress Tracker** – Monitor improvement across sessions.
* 🔔 **Reminders & Notifications** – Daily challenge reminders.
* 💬 **Offline Discussion Threads** – Local chat-style Q&A archive.
* 🧮 **Performance Graphs** – Visual representation of user growth.

---

## 🧑‍💻 About

**Bluna AI** is developed by [@am3lue](https://github.com/am3lue).
It’s built to **make programming education interactive, personal, and offline-friendly**, empowering beginners to grow at their own pace.

---

## 🪶 License

This project is licensed under the **MIT License** — free to use, modify, and share.

---

> “Your personal coding moonlight — guiding you through the dark lines of code.” 🌙💙


---

## 🧾 Project Description (for GitHub or Portfolio)

> **Bluna AI** is a locally hosted, terminal-based programming assistant built with Julia and powered by the Phi-3-mini model using Ollama.  
It helps programmers — from beginners to experienced devs — learn, debug, and practice coding more effectively.  
With its customizable prompts, practice reminders, and minimalist TUI, Bluna AI provides a private, distraction-free learning experience that adapts to each user’s style.  
It’s open-source, lightweight, and built to make programming education smarter and more human.

---


