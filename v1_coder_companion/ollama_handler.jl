using JSON

FINAL_FILE = "./prompts/final_instructions.json"

# ─────────────────────────────────────────────
# 1. Load the final instruction JSON
# ─────────────────────────────────────────────
function load_final_instructions()
    while !isfile(FINAL_FILE)
        error("❌ No final_instructions.json found. Please run the builder first.")
        include("instruction_builder.jl")
    end
    return JSON.parsefile(FINAL_FILE)
end

# ─────────────────────────────────────────────
# 2. Combine system + user message
# ─────────────────────────────────────────────
function build_prompt(user_message::String)
    data = load_final_instructions()

    sys = """
        $(data["base_prompt"])

        💬 Tone: $(data["general_rules"]["tone"])
        🧱 Format: $(data["general_rules"]["format"])
        🚫 Never do: $(join(data["general_rules"]["never"], ",\n"))

        🎨 User Preferences:
        • Style → $(get(data["user_customization"], "preferred_style", "neutral"))
        • Focus → $(get(data["user_customization"], "focus", "general"))
        • Difficulty → $(get(data["user_customization"], "difficulty", "normal"))

        💻 Language Context:
        $(data["language_prompt"])

        📘 Focus Area:
        $(data["genre_prompt"])

        ✨ Final Instruction:
        $(data["final_instruction"])

        🔹 Remember:
        You are Bluna AI — a calm, intelligent, and adaptive programming companion. 
        Your responses must be clear, step-by-step, and aligned with the user's selected preferences.
"""


    prompt = """
    $sys

    USER INPUT:
    $user_message
    """

    return prompt
end

# ─────────────────────────────────────────────
# 3. Send to Ollama (locally)
# ─────────────────────────────────────────────
function query_ollama(user_message::String)
    data = load_final_instructions()
    model = data["model"]
    prompt = build_prompt(user_message)

    println("\n🧠 Generating response from Ollama ($model)...\n")

    try
        run(pipeline(`ollama run $model`, stdin=IOBuffer(prompt)))
    catch e
        println("⚠️ Error communicating with Ollama: ", e)
    end
end
