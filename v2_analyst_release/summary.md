# Project Summary: Bluna-ai v2 Analyst Release

## Date: 2025-12-18

## Status: Development

### Objectives
1.  **Refactor into Code Learning Helper**:
    *   **Goal**: Create a CLI for learning to code.
    *   **Entry Point**: `main.jl` (Root).
    *   **AI Model**: `qwen2.5-coder:0.5b` (via Ollama).
    *   **Fallback**: Auto-web search when AI is unsure.
    *   **Constraint**: Use `offline/ollama_client.jl` and `online/webscraping.jl`.

### Analysis of Existing Code
*   **`main.jl`**: Currently a PDF analysis script. **Action**: Will be completely rewritten.
*   **`offline/ollama_client.jl`**: Basic Ollama wrapper. Defaults to `llama3`. **Action**: Update default model to `qwen2.5-coder:0.5b` and ensure robust error handling.
*   **`offline/main.jl`**: Existing offline CLI. **Action**: Logic will be migrated/adapted to root `main.jl`.
*   **`online/webscraping.jl`**: DuckDuckGo scraper. **Action**: Integrate as a library for `main.jl`.
*   **"v1" Files**: Searched but not found. **Action**: Will implement general coding support (Julia, Python, etc.) unless specified otherwise.

## Current Actions
- [x] Create `summary.md`
- [x] Read and analyze existing files.
- [x] Update `summary.md` with analysis.
- [x] Refactor `offline/ollama_client.jl` (Model change to `qwen2.5-coder:0.5b`).
- [x] Create/Update `main.jl` with new Logic:
    -   Implemented interactive CLI loop.
    -   Integrated `OllamaClient` and `OnlineMode`.
    -   Added `SEARCH_WEB:` protocol for automatic fallback.
    -   Added logic to synthesize web results and cite sources.

## Implementation Details
- **Entry Point**: Run `julia main.jl` to start the coding tutor.
- **AI Integration**: Uses `src/OllamaClient.jl`. The system prompt instructs the model to request a web search if needed.
- **Web Search**: Uses `src/WebScraping.jl`. When the model returns `SEARCH_WEB: query`, the app scrapes DuckDuckGo results, feeds them back to the model, and produces a summarized answer with citations.
- **Dependencies**: Cleaned up `Project.toml` to remove unused packages from the previous iteration.

## File Structure
- `main.jl`: Entry point.
- `src/OllamaClient.jl`: Ollama API wrapper.
- `src/WebScraping.jl`: Web scraping functionality.
- `README.md`: User instructions.

## Testing Results
- **Offline Query**: "What is a variable?" -> Answered correctly by `qwen2.5-coder:0.5b` with code examples.
- **Online Query (Fallback)**: "What is the current price of Bitcoin today?" -> Triggered `SEARCH_WEB`, scraped live data, and returned the current price with sources (e.g., ~$87k).
- **Environment**: Ollama confirmed running; Dependencies (`JSON`, `HTTP`, etc.) instantiated and verified.

## Conclusion
The Bluna AI Coding Tutor is fully functional, meeting all specified requirements for a lightweight, offline-first coding helper with intelligent web fallback.
