include("setup.jl")
include("intro.jl")
include("choices.jl")
include("preferences.jl")
include("instruction_builder.jl")
include("ollama_handler.jl")


bluna_intro()

genre, language = user_choices()
save_preferences(genre, language)
build_final_instructions(language, genre)

println("\n✅ Instructions loaded successfully!")

while true
    print("\n💬 You: ")
    user_msg = readline()
    if lowercase(user_msg) in ["exit", "quit", "bye"]
        println("\n👋 Goodbye from Bluna ai!\n")
        break
    end
    query_ollama(user_msg)
end
