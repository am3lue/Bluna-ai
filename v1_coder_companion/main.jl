# Main file to run the Bluna ai program
using FIGlet
include("ollama_handler.jl")

Figlet.render("Bluna AI", "Big Money-nw")  # Preload the font to avoid delays later

while true
    print("\n💬 You: ")
    user_msg = readline()
    if lowercase(user_msg) in ["exit", "quit", "bye"]
        println("\n👋 Goodbye from Bluna ai!\n")
        break
    end
    query_ollama(user_msg)
end
