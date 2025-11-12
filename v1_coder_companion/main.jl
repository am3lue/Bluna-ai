# Main file to run the Bluna ai program

include("ollama_handler.jl")
include("instruction_builder.jl")

# Run intro
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
