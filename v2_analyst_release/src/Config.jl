module Config

using JSON

export AppConfig, load_config

mutable struct AppConfig
    model_name::String
    ollama_host::String
    user_name::String
    teaching_style::String
    favorite_language::String
    learning_genre::String
end

"""
    load_config(filename::String="config.json")

Loads configuration from a JSON file or returns default values.
"""
function load_config(filename::String="config.json")
    default_config = AppConfig("qwen2.5-coder:0.5b", "http://localhost:11434", "Learner", "Friendly", "Julia", "General Basics")
    
    if isfile(filename)
        try
            data = JSON.parsefile(filename)
            if haskey(data, "llm")
                default_config.model_name = get(data["llm"], "model", default_config.model_name)
                default_config.ollama_host = get(data["llm"], "host", default_config.ollama_host)
            end
            if haskey(data, "user")
                default_config.user_name = get(data["user"], "name", default_config.user_name)
                default_config.teaching_style = get(data["user"], "style", default_config.teaching_style)
                default_config.favorite_language = get(data["user"], "language", default_config.favorite_language)
                default_config.learning_genre = get(data["user"], "genre", default_config.learning_genre)
            end
        catch e
            @warn "Failed to parse config.json. Using defaults."
        end
    end
    return default_config
end

end # module
