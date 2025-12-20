# 📘 Bluna AI - Project Summary

**Version:** 2.1 (The "Smart & Friendly" Release)  
**Date:** December 2025

## 🌟 What is Bluna AI?

Hey there! You're looking at Bluna AI v2.1 - your friendly, intelligent coding tutor that lives in your terminal. Think of me as that knowledgeable friend who's always ready to help you understand programming concepts, write better code, and keep your learning on track.

This isn't just a simple script anymore; it's a full-featured learning companion that combines the power of modern AI with practical tools to help you succeed.

## 🚀 What Makes Me Special?

I've got some pretty cool superpowers that make learning programming more enjoyable:

### 🧠 **Intelligent AI Tutoring**
I'm powered by Qwen2.5-coder:0.5b, a specialized coding model that understands programming concepts deeply and explains them in ways that actually make sense.

### 🌐 **Smart Web Search** 
When you ask me about current information (like "What's new in Python 3.12?"), I can search the web to give you up-to-date, accurate answers with sources - no more outdated information!

### 💾 **I Remember Everything**
Tell me once that you prefer learning with examples, and I'll remember it throughout our conversation. I keep track of your learning style, preferred languages, and what we're working on.

### 📅 **Learning Planning**
Just type "create schedule" and I'll help you build a personalized study plan that fits your goals and timeline.

### 🛡️ **Reliable & Stable**
I've been designed to handle errors gracefully. If something goes wrong, you'll know about it instead of waiting forever for a response that never comes.

---

## 🛠️ How I Work (The Technical Stuff)

I've been built with a clean, modular architecture that makes me reliable and easy to maintain:

### Core Components
- **`main.jl`** - My brain and personality. Handles all the conversation logic and user interaction.
- **`src/OllamaClient.jl`** - My connection to the AI model. This is how I think and respond intelligently.
- **`src/WebScraping.jl`** - My research skills. When I need current information, I can search DuckDuckGo.
- **`src/Memory.jl`** - My memory system. Stores your preferences and conversation history.
- **`src/Scheduler.jl`** - My planning skills. Helps create personalized learning schedules.

### Key Features
- **Offline First** - I work completely offline using local AI models (Ollama)
- **Web Fallback** - When I need current information, I can search the web intelligently
- **Personalized** - I adapt my teaching style to match how you prefer to learn
- **Error Resilient** - If something goes wrong, I handle it gracefully instead of crashing

---

## 🎯 What I Can Help You With

### Learning Programming
- Explain complex concepts in simple terms
- Provide code examples in multiple languages
- Help with debugging and problem-solving
- Suggest best practices and patterns

### Current Information
- Latest versions and features of programming languages
- Current best practices and frameworks
- Recent developments in the tech world
- Up-to-date documentation and resources

### Learning Planning
- Create custom study schedules
- Break down complex topics into manageable chunks
- Track your progress and adapt to your pace
- Suggest learning resources and next steps

### Study Support
- Quiz you on concepts you're learning
- Help you practice coding problems
- Explain code you're struggling with
- Provide feedback on your solutions

---

## 🚀 How to Get Started

### Quick Start
```bash
# 1. Make sure Ollama is installed and the model is ready
ollama pull qwen2.5-coder:0.5b

# 2. Navigate to the project directory
cd bluna-ai/v2_analyst_release

# 3. Launch Bluna
julia --project=. main.jl
```

### First Time Setup
On your first launch, I'll ask you a few friendly questions to personalize your experience:
- What should I call you?
- What programming languages are you interested in?
- How do you prefer to learn (examples, theory, hands-on)?

### Cool Commands to Try
```
"Explain what recursion is" - I'll teach you this concept with examples
"Remember that I prefer Python over JavaScript" - I'll remember your preference
"Create a 30-day learning plan for web development" - I'll build you a schedule
"What are the latest features in Rust?" - I'll search for current information
"Clear memory" - Want to start fresh? No problem!
"exit" - See you later!
```

---

## 📈 My Journey & What's Next

I've come a long way from my humble beginnings as a simple coding helper. Each version has brought new capabilities and improvements:

### Version 2.1 Highlights
- ✅ **Enhanced AI** - Upgraded to Qwen2.5-coder:0.5b for better responses
- ✅ **Web Search** - Intelligent search with source attribution
- ✅ **Memory System** - Persistent user preferences and context
- ✅ **Learning Plans** - Customized study schedule generation
- ✅ **Better UX** - Improved interface and error handling

### Coming Soon (v2.2+)
- 🔄 **More Search Options** - Adding Google and Bing as backup search engines
- 🔄 **Enhanced Memory** - Better conversation history and export features
- 🔄 **Code Execution** - Run and test code snippets right in the terminal
- 🔄 **Advanced Scheduling** - More sophisticated learning plan algorithms

---

## 🎓 The Bluna Philosophy

I believe learning to code should be:
- **Personalized** - Adapted to how you think and learn best
- **Current** - Using the latest information and best practices
- **Encouraging** - Supportive feedback that builds confidence
- **Practical** - Focus on real-world applications and skills
- **Accessible** - Free, local, and private for everyone

---

## 💬 What Users Say

> *"Bluna makes complex programming concepts actually make sense. The examples are perfect!"*  
> *"Love that it remembers my learning style. No need to repeat myself."*  
> *"The web search feature is amazing for getting current information."*

---

## 🔧 For Developers

If you're interested in contributing or understanding the technical details:

### Development Setup
```bash
git clone https://github.com/am3lue/bluna-ai.git
cd bluna-ai/v2_analyst_release
julia --project=.
```

### Key Dependencies
- **Ollama** - Local AI model serving
- **Julia 1.9+** - Runtime environment
- **HTTP.jl** - API communication
- **Gumbo.jl + Cascadia.jl** - Web scraping and HTML parsing
- **JSON.jl** - Data handling

### Architecture Notes
- Modular design for easy testing and maintenance
- Type-safe result structures
- Comprehensive error handling
- Graceful degradation for reliability
- Clear separation of concerns

---

**Current Status**: ✅ Stable & Ready for Learning  
**Enjoy learning with Bluna!** 🎓

*Need help or have suggestions? Visit our [GitHub repository](https://github.com/am3lue/bluna-ai) - we'd love to hear from you!*
