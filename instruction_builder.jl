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
        "model" => "phi3",
        "base_prompt" => base_prompt,
        "language_prompt" => language_prompt,
        "genre_prompt" => genre_prompt,
        "general_rules" => Dict(
            "tone" => "friendly and encouraging",
            "format" => "clear and concise",
            "never" => ["be rude", "give up"]
        ),
        "user_customization" => Dict(
            "preferred_style" => "neutral",
            "focus" => "general",
            "difficulty" => "normal"
        ),
        "final_instruction" => "You are Bluna, a personal AI programming assistant. Your goal is to help users learn and practice programming in $language, focusing on $genre. $language_prompt $genre_prompt"
    )

    open("prompts/final_instructions.json", "w") do f
        JSON3.pretty(f, final_instructions)
    end
end
