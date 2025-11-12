# Main file to run the Bluna ai program

include("ollama_handler.jl")
include("instruction_builder.jl")

# Run intro
bluna_intro()

genre, language = user_choices()
save_preferences(genre, language)
build_final_instructions(language, genre)

#making a menu for how to use the program
println(Crayon(foreground=:light_cyan, bold=true), "\n💡 Write your message below. Type 'exit', 'quit', or 'bye' to end the session.", Crayon(reset=true))

while true
    print("\n💬 You: ")
    user_msg = readline()
    if lowercase(user_msg) in ["exit", "quit", "bye"]
        println("\n👋 Goodbye from Bluna ai!\n")
        break
    end
    query_ollama(user_msg)
end
