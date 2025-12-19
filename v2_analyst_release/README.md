# Bluna AI - Coding Tutor 🎓

Bluna AI is an interactive, CLI-based coding tutor powered by the `qwen2.5-coder:0.5b` model via Ollama. It is designed to help beginners learn programming concepts.

## Features ✨

*   **Interactive Chat:** Ask coding questions directly in your terminal.
*   **Rich UI with Emojis:** A friendly, visually appealing CLI experience with clear status indicators (✨, 🔍, 🧠).
*   **Offline First:** Uses a local LLM for fast, private responses.
*   **Smart Web Fallback:** If the AI doesn't know the answer or detects a need for real-time information (e.g., "latest version of X"), it automatically searches the web using DuckDuckGo, summarizes the results, and cites sources.

## Prerequisites 🛠️

1.  **Julia:** Ensure you have Julia installed.
2.  **Ollama:** You must have [Ollama](https://ollama.com/) installed and running.
3.  **Model:** Pull the required model:
    ```bash
    ollama pull qwen2.5-coder:0.5b
    ```

## Installation 📦

1.  Clone this repository.
2.  Instantiate the project dependencies:
    ```bash
    julia --project=. -e 'using Pkg; Pkg.instantiate()'
    ```

## Usage 🚀

Run the application from the project root:

```bash
julia --project=. main.jl
```

**Commands:**
*   Type your question and press Enter.
*   Type `exit`, `quit`, or `q` to close the application.

## Recent Updates (v2.1) 🆕

*   **UI Overhaul:** The interface has been completely redesigned with a modern, box-style layout.
*   **Emoji Support:** Added fun and helpful emojis to guide the user through the experience.
*   **Enhanced Feedback:** Clearer visual cues when the AI is "Thinking" or "Searching".

## Project Structure 📂

*   `main.jl`: The entry point of the application. Handles the main loop and user interaction.
*   `src/`: Contains the core logic modules.
    *   `OllamaClient.jl`: Handles communication with the local Ollama API.
    *   `WebScraping.jl`: Handles DuckDuckGo searching and HTML parsing.
*   `Project.toml` & `Manifest.toml`: Julia dependency files.
