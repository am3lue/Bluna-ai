# Main file to run the Bluna ai program

include("ollama_handler.jl")


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
