include("src/OllamaClient.jl")
include("src/WebScraping.jl")

using .OllamaClient
using .WebScraping
using Printf

# --- Configuration ---
const MODEL_NAME = "qwen2.5-coder:0.5b"
const SYSTEM_PROMPT = """
You are a friendly and helpful coding tutor designed to help beginners learn programming. 
Your goal is to explain concepts simply and clearly.

IMPORTANT INSTRUCTION:
If the user asks a question that requires up-to-date information (e.g., "latest version of Julia", "current weather", "news") or if you are not confident in your internal knowledge, you MUST strictly reply with a request to search the web.
The format for this request is:
SEARCH_WEB: <search_query>

Example:
User: \"What is the latest version of Python?\"
You: SEARCH_WEB: latest python version release date

If you know the answer (e.g., basic syntax, logic explanations), just answer directly and kindly.
"""

function main()
    println("="^60)
    println("🎓 Bluna AI - Coding Tutor (Powered by $MODEL_NAME)")
    println("   Type 'exit', 'quit', or 'q' to stop.")
    println("="^60)

    while true
        print("\nUser > ")
        user_input = strip(readline())

        if lowercase(user_input) in ["exit", "quit", "q"]
            println("👋 Happy coding! See you next time.")
            break
        end

        if isempty(user_input)
            continue
        end

        process_request(user_input)
    end
end


function process_request(user_input::AbstractString)
    # Step 1: Initial Query to LLM
    print("🤖 Thinking...")
    
    try
        # Construct the full prompt structure for the chat
        # Note: Ollama's /api/generate usually takes a single prompt, but we can simulate a chat structure 
        # or just prepend the system prompt if the model supports it via the 'system' parameter in the client.
        # Our client supports 'system'.
        
        response = OllamaClient.generate_completion(user_input; model=MODEL_NAME, system=SYSTEM_PROMPT)

        # Clean up response just in case
        clean_response = strip(response)

        # Step 2: Check for Web Search Request
        if startswith(clean_response, "SEARCH_WEB:")
            # Extract the search query
            search_query = strip(replace(clean_response, "SEARCH_WEB:" => ""))
            
            perform_web_search_and_answer(user_input, search_query)
        else
            # Direct Answer
            println("\r" * " "^20 * "\r") # Clear "Thinking..."
            println("Bluna: $clean_response")
        end
        
    catch e
        println("\r" * " "^20 * "\r") # Clear "Thinking..."
        println("Bluna: I apologize, but I'm having trouble connecting to my AI model right now. $(typeof(e))")
        @error "Error in AI processing: $(e)"
    end
end


function perform_web_search_and_answer(original_question::AbstractString, search_query::AbstractString)
    println("\r🔍 I need to check the web. Searching for: '$search_query'...")
    println("   (Please wait, this might take a moment...)")

    try
        # Call the existing web scraping module with timeout
        # user_inputs_and_rendering returns Vector{WebScrapingResult}
        results = WebScraping.user_inputs_and_rendering(search_query)

        if isempty(results)
            # Graceful degradation - provide offline response
            println("⚠️  Web search is currently unavailable. Let me answer based on my knowledge:")
            fallback_prompt = "The user asked: '$original_question'. I couldn't access the web to search for '$search_query'. Please answer the user's question as best as you can using your internal knowledge, and mention that web search is temporarily unavailable."
            final_answer = OllamaClient.generate_completion(fallback_prompt; model=MODEL_NAME, system="You are a helpful coding tutor.")
            println("Bluna: $final_answer")
            return
        end

        # Build context from results
        context = ""
        sources = String[]
        
        for (i, res) in enumerate(results)
            # Limit context size to avoid overwhelming the small model
            if i > 3 break end 
            content_snippet = length(res.content) > 500 ? res.content[1:500] * "..." : res.content
            context *= "\n--- Source $(i): $(res.url) ---\nTitle: $(res.title)\nContent: $content_snippet\n"
            push!(sources, res.url)
        end

        # Step 3: Synthesize Answer
        println("🧠 Reading search results and summarizing...")
        
        synthesis_prompt = """
        User Question: "$original_question"
        
        I have found the following information from the web:
        $context
        
        Instruction:
        1. Answer the user's question simply and clearly using the information above.
        2. Since you are a coding tutor, explain any technical terms if necessary.
        3. Explicitly mention that you found this information online.
        """

        final_answer = OllamaClient.generate_completion(synthesis_prompt; model=MODEL_NAME, system="You are a helpful coding tutor. Summarize the provided search results to answer the user.")

        println("\nBluna: $final_answer")
        if !isempty(sources)
            println("\nSources:")
            for src in sources
                println("- $src")
            end
        end
        
    catch e
        # Comprehensive error handling
        println("⚠️  Web search encountered an error: $(typeof(e))")
        println("I'm having trouble accessing the web right now. Let me try to help based on my knowledge:")
        
        try
            fallback_prompt = "The user asked: '$original_question'. I encountered an error when trying to search for '$search_query'. Please answer the user's question as best as you can using your internal knowledge, and mention that web search is temporarily unavailable due to technical issues."
            final_answer = OllamaClient.generate_completion(fallback_prompt; model=MODEL_NAME, system="You are a helpful coding tutor.")
            println("Bluna: $final_answer")
        catch inner_e

            println("Bluna: I apologize, but I'm having technical difficulties both with web search and my AI model. Please try again in a moment.")
            @error "Critical error in web search and fallback: $(inner_e)"
        end
        
        @error "Error in web search: $(e)"
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
