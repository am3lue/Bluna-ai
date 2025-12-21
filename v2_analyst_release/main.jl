include("src/Config.jl")
include("src/UI.jl")
include("src/OllamaClient.jl")
include("src/WebScraping.jl")
include("src/Memory.jl")
include("src/Scheduler.jl")

using .Config
using .UI
using .OllamaClient
using .WebScraping
using .Memory
using .Scheduler
using Printf
using Markdown
using Dates
using JSON

# --- Global State ---
global CONFIG = Config.load_config()
global GLOBAL_MEMORY = nothing

# --- Setup Wizard ---

function run_first_time_setup()
    UI.clear_screen()
    UI.render_logo()
    println(TITLE_COLOR, "\n=============================", RESET)
    println(TITLE_COLOR, "       ✨ Setup Wizard ✨     ", RESET)
    println(TITLE_COLOR, "=============================\n", RESET)

    # 1. User Name
    print(PROMPT_COLOR, "👤 Enter your name > ", RESET)
    name = strip(readline())
    if isempty(name) name = "Learner" end

    # 2. Genre selection
    genres = ["General Basics", "Data Structures and Algorithms"]
    println(OPTION_COLOR, "\nChoose a learning genre:", RESET)
    for (i, g) in enumerate(genres)
        println("  [$i] $g")
    end
    print(PROMPT_COLOR, "Selection [1-2] > ", RESET)
    g_choice = tryparse(Int, readline())
    genre = (g_choice in 1:length(genres)) ? genres[g_choice] : "General Basics"

    # 3. Language selection
    languages = ["Julia", "Python", "Java", "C / C++", "Rust", "Go", "Web Development"]
    println(OPTION_COLOR, "\nChoose your primary language:", RESET)
    for (i, lang) in enumerate(languages)
        println("  [$i] $lang")
    end
    print(PROMPT_COLOR, "Selection [1-7] > ", RESET)
    l_choice = tryparse(Int, readline())
    language = (l_choice in 1:length(languages)) ? languages[l_choice] : "Julia"

    # 4. Teaching Style
    println(OPTION_COLOR, "\nChoose a Teaching Style:", RESET)
    println("  [1] Friendly - Encouraging, ELI5.")
    println("  [2] Socratic - Asks questions back.")
    println("  [3] Concise  - Direct and technical.")
    print(PROMPT_COLOR, "Selection [1-3] > ", RESET)
    s_choice = strip(readline())
    style = s_choice == "2" ? "Socratic" : s_choice == "3" ? "Concise" : "Friendly"

    # 5. Ollama Settings (Optional defaults)
    model = "qwen2.5-coder:0.5b"
    host = "http://localhost:11434"

    # Save to JSON
    config_dict = Dict(
        "llm" => Dict("model" => model, "host" => host),
        "user" => Dict(
            "name" => name,
            "style" => style,
            "language" => language,
            "genre" => genre
        )
    )

    open("config.json", "w") do f
        JSON.print(f, config_dict, 4)
    end

    println(USER_COLOR, "\n✔ Configuration saved successfully!", RESET)
    println(PROMPT_COLOR, "Bluna AI is now ready to help you learn $(language)! 🌙💙\n", RESET)
    sleep(1.0)
    
    global CONFIG = Config.load_config()
end

# --- AI Logic ---

function get_system_prompt()
    base_prompt = """
You are Bluna AI 🌙 — a calm, intelligent, and adaptive personal programming assistant.
Your mission is to help $(CONFIG.user_name) learn $(CONFIG.favorite_language) with a focus on $(CONFIG.learning_genre).

[CONTEXT]
Current Language: $(CONFIG.favorite_language)
Current Genre: $(CONFIG.learning_genre)
Current Date/Time: $(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"))

[INSTRUCTIONS]
1. Memory: Use [USER FACTS] and [CONVERSATION HISTORY].
2. Style: $(CONFIG.teaching_style).
3. Web Search: If needed, use `SEARCH_WEB: <query>`.
"""
    
    if CONFIG.teaching_style == "Socratic"
        base_prompt *= "\nSOCRATIC: Do not give answers directly. Ask guiding questions."
    elseif CONFIG.teaching_style == "Concise"
        base_prompt *= "\nCONCISE: Be direct, technical, and avoid fluff."
    else
        base_prompt *= "\nFRIENDLY: Use analogies, be warm and encouraging (ELI5)."
    end
    
    return base_prompt
end

"""
    handle_user_input(user_input::AbstractString, io_in::IO=stdin, io_out::IO=stdout)

Processes a single user input or command.
"""
function handle_user_input(user_input::AbstractString, io_in::IO=stdin, io_out::IO=stdout)
    global GLOBAL_MEMORY
    lc_input = lowercase(user_input)

    # 1. Memory Commands
    if startswith(lc_input, "remember ")
        fact = replace(user_input, r"^remember (that )?"i => "")
        Memory.add_fact(GLOBAL_MEMORY, fact)
        println(io_out, YELLOW, "📝 I've saved that to my memory!", RESET)
        return
    elseif lc_input in ["clear memory", "forget everything", "reset memory"]
        print(io_out, RED, "⚠️  Are you sure you want to clear all memory? (y/n) > ", RESET)
        confirm = strip(readline(io_in))
        if lowercase(confirm) == "y"
            GLOBAL_MEMORY = Memory.empty_memory()
            Memory.save_memory(GLOBAL_MEMORY)
            println(io_out, YELLOW, "🧹 Memory wiped clean.", RESET)
        else
            println(io_out, GREEN, "Memory preserved.", RESET)
        end
        return
    
    # 2. Scheduler Commands
    elseif lc_input in ["create schedule", "plan learning", "start course", "make plan"]
        run_scheduler_wizard(io_in, io_out)
        return
    end

    # 3. AI Processing
    process_request(user_input, io_out)
end

function run_scheduler_wizard(io_in::IO=stdin, io_out::IO=stdout)
    println(io_out, BOLD, CYAN, "\n📅 --- Interactive Learning Scheduler ---", RESET)
    println(io_out, "Let's build a personalized learning plan for you!")
    
    # 1. Choose Language
    print(io_out, "\n1️⃣  Which language do you want to learn? (Julia/Python/General) > ")
    lang_input = String(strip(readline(io_in)))
    if isempty(lang_input) lang_input = CONFIG.favorite_language end
    
    # 2. Choose Days
    println(io_out, "\n2️⃣  Which days of the week can you study?")
    println(io_out, "   (Enter numbers separated by commas: 1=Mon, 7=Sun)")
    println(io_out, "   e.g., '1, 3, 5' for Mon, Wed, Fri")
    print(io_out, "   > ")
    days_input = strip(readline(io_in))
    
    days = Int[]
    try
        parts = split(days_input, r"[, ]+")
        for p in parts
            if !isempty(p)
                d = parse(Int, p)
                if 1 <= d <= 7 push!(days, d) end
            end
        end
    catch
        days = [6, 7] # Default to weekends
    end
    
    if isempty(days) days = [6, 7] end
    
    # 3. Generate
    start_date = today()
    println(io_out, YELLOW, "\n⏳ Generating your schedule starting from today ($start_date)...", RESET)
    
    schedule, final_lang = Scheduler.generate_schedule(lang_input, start_date, days)
    
    # 4. Display Summary
    println(io_out, GREEN, "\n✅ Plan Generated for $(uppercase(final_lang))!", RESET)
    println(io_out, "Total Sessions: $(length(schedule))")
    println(io_out, "Estimated Completion: $(schedule[end].date)")
    
    # 5. Save
    filename = "LearningPlan_$(uppercase(final_lang)).md"
    Scheduler.save_schedule_to_file(schedule, final_lang, filename)
    println(io_out, BOLD, CYAN, "\n💾 Schedule saved to '$filename'", RESET)
    println(io_out, "Open this file to track your progress!\n")
    
    # Add to memory
    Memory.add_fact(GLOBAL_MEMORY, "I am following a learning plan for $final_lang starting $start_date.")
end

function process_request(user_input::AbstractString, io_out::IO=stdout)
    global GLOBAL_MEMORY
    
    print(io_out, SYSTEM_COLOR, "🧠 Thinking...", RESET)
    
    memory_context = Memory.get_memory_context(GLOBAL_MEMORY)
    full_prompt = """
    [MEMORY]
    $memory_context
    
    [USER INPUT]
    $user_input
    """
    
    try
        response = OllamaClient.generate_completion(full_prompt; 
            model=CONFIG.model_name, 
            system=get_system_prompt(), 
            host=CONFIG.ollama_host)

        clean_response = strip(response)
        print(io_out, "\r" * " "^30 * "\r") # Clear thinking

        if startswith(clean_response, "SEARCH_WEB:")
            search_query = strip(replace(clean_response, "SEARCH_WEB:" => ""))
            perform_web_search_and_answer(user_input, search_query, io_out)
        else
            print(io_out, BLUNA_COLOR, "Bluna: ", RESET)
            if io_out == stdout
                display(Markdown.parse(clean_response))
            else
                println(io_out, clean_response)
            end
            println(io_out)
            Memory.add_interaction(GLOBAL_MEMORY, user_input, clean_response)
        end
        
    catch e
        print(io_out, "\r" * " "^30 * "\r")
        println(io_out, RED, "Error: Could not connect to Ollama. Ensure it is running at $(CONFIG.ollama_host)", RESET)
    end
end

function perform_web_search_and_answer(original_question::AbstractString, search_query::AbstractString, io_out::IO=stdout)
    global GLOBAL_MEMORY
    println(io_out, SYSTEM_COLOR, "🌐 Searching for: $search_query...", RESET)
    
    try
        results = WebScraping.user_inputs_and_rendering(search_query)
        
        if isempty(results)
            println(io_out, YELLOW, "⚠️ No web results found. Answering from knowledge...", RESET)
            process_request("Answer this based on your knowledge: $original_question", io_out)
            return
        end

        context = join(["Source $i: $(r.url)\n$(r.content[1:min(500, end)])" for (i, r) in enumerate(results)], "\n\n")
        
        synthesis_prompt = """
        [WEB RESULTS]
        $context
        
        [QUESTION]
        $original_question
        
        Answer based on the results above in $(CONFIG.teaching_style) style.
        """
        
        final_answer = OllamaClient.generate_completion(synthesis_prompt; 
            model=CONFIG.model_name, 
            system="Summarize web results for the user.", 
            host=CONFIG.ollama_host)
            
        print(io_out, BLUNA_COLOR, "Bluna: ", RESET)
        if io_out == stdout
            display(Markdown.parse(final_answer))
        else
            println(io_out, final_answer)
        end
        println(io_out, CYAN, "\n📚 Sources:", RESET)
        for r in results println(io_out, "   🔗 $(r.url)") end
        println(io_out)
        
        Memory.add_interaction(GLOBAL_MEMORY, original_question, final_answer)
    catch e
        println(io_out, RED, "❌ Web search failed.", RESET)
    end
end

# --- Main Loop ---

function main(io_in::IO=stdin, io_out::IO=stdout)
    if !isfile("config.json")
        run_first_time_setup()
    end

    global GLOBAL_MEMORY = Memory.load_memory()
    UI.print_header(CONFIG)

    while true
        print(io_out, USER_COLOR, "💬 You: ", RESET)
        
        if eof(io_in) break end
        user_input = strip(readline(io_in))

        if lowercase(user_input) in ["exit", "quit", "q"]
            println(io_out, TITLE_COLOR, "\n👋 Goodbye from Bluna AI! Keep learning! ✨\n", RESET)
            break
        end

        if isempty(user_input) continue end

        handle_user_input(user_input, io_in, io_out)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
