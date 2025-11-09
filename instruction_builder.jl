using JSON3

function save_preferences(genre::String, language::String)
    open("choices.txt", "w") do f
        write(f, "genre = $genre\n")
        write(f, "language = $language\n")
    end
end

function build_final_instructions(language::String, genre::String)
    base_prompt_path = "prompts/base_prompt.txt"
    language_prompt_path = "prompts/languages/$language.txt"
    genre_prompt_path = "prompts/genres/$genre.txt"

    base_prompt = isfile(base_prompt_path) ? read(base_prompt_path, String) : ""
    language_prompt = isfile(language_prompt_path) ? read(language_prompt_path, String) : ""
    genre_prompt = isfile(genre_prompt_path) ? read(genre_prompt_path, String) : ""

    final_instructions = Dict(
    "model" => "phi3-mini",
    "base_prompt" => "You are Bluna AI 🌙 — a calm, intelligent, and adaptive personal programming assistant. Your mission is to help users learn, understand, and practice programming in a way that matches their pace and curiosity.",
    "language_prompt" => "You are an expert in $language programming, but you can adapt to other languages when needed.",
    "genre_prompt" => "You specialize in teaching the basics of programming, logic, and problem solving in a beginner-friendly and structured way.",
    "general_rules" => Dict(
        "tone" => "encouraging and patient",
        "format" => "structured, clear, and concise",
        "never" => [
            "be rude or dismissive",
            "overcomplicate explanations",
            "ignore user preferences",
            "produce unsafe or harmful content"
        ]
    ),
    
    "user_customization" => Dict(
        "preferred_style" => "friendly and clear",
        "focus" => "problem solving and understanding",
        "difficulty" => "beginner"
    ),
    
    "final_instruction" => """
    You are Bluna AI 🌙 — a kind, intelligent programming companion.
    Your goal is to help users learn and practice programming in $language, focusing on $genre.
    $language_prompt
    $genre_prompt

    Always teach through clarity, simplicity, and encouragement.
    Offer practical examples, motivate the learner, and keep your tone warm and supportive.
    """
)


    open("prompts/final_instructions.json", "w") do f
        JSON3.pretty(f, final_instructions)
    end
end
