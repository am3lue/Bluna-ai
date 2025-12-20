# 📘 Bluna AI - The Lowdown

**Version:** 2.1 (The "Smart & Friendly" Release)
**Date:** Dec 20, 2025

## 🌟 What's This All About?
Hey there! You're looking at Bluna AI v2. This isn't just a script anymore; it's a full-blown intelligent agent that wants to help you code better.

We took everything cool about the first version (like the retro look) and gave it superpowers:
*   **🧠 I Remember You:** I have a long-term memory now! Tell me you like Python, and I won't ask you again five minutes later.
*   **📅 I'm Your Planner:** Type `create schedule` and I'll build a custom learning path for you.
*   **🌐 I Can Google Things:** If I don't know the answer, I'll hop online (via DuckDuckGo) and find it for you. No hallucinations here!
*   **🛡️ I'm Rock Solid:** I won't leave you hanging. If a search takes too long, I'll time out gracefully instead of freezing.

---

## 🚀 How to Use Me

### Quick Start
Just run this in your terminal:
```bash
julia --project=. main.jl
```
If it's our first meeting, I'll run a quick setup wizard to learn your name and style.

### Cool Commands to Try
*   **"Explain recursion"** 👉 I'll teach you like a friend.
*   **"Remember that I use Linux"** 👉 I'll save that info forever.
*   **"Create schedule"** 👉 We'll make a study plan together.
*   **"Clear memory"** 👉 Want a fresh start? No problem.
*   **`exit`** 👉 See ya later!

---

## 🛠️ Under the Hood (For Geeks)

We kept it simple but powerful:
*   **`main.jl`**: The brain. It runs the show.
*   **`src/Memory.jl`**: My hippocampus. Saves your facts to a JSON file.
*   **`src/Scheduler.jl`**: The logic that builds your calendar.
*   **`src/WebScraping.jl`**: My eyes on the web. Scrapes docs when needed.

**Status:**
✅ **Stable & Tested:** I've passed all my exams (tests).
✅ **Friendly UI:** I use `FIGlet` and colors because coding should look cool.

---

**Enjoy learning with Bluna!** 🎓