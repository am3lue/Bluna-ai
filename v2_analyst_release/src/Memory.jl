module Memory

using JSON
using Dates

export load_memory, save_memory, add_interaction, add_fact, get_memory_context, MemoryData

const MEMORY_FILE = "bluna_memory.json"
const MAX_HISTORY = 10  # Keep last 10 interactions for context

mutable struct MemoryData
    facts::Vector{String}
    history::Vector{Dict{String, String}}
    last_updated::String
end

# Default empty memory
function empty_memory()
    return MemoryData(String[], Dict{String, String}[], string(now()))
end

"""
    load_memory(filename::String=MEMORY_FILE)

Loads memory from the JSON file or creates a new one if it doesn't exist.
"""
function load_memory(filename::String=MEMORY_FILE)
    if isfile(filename)
        try
            data = JSON.parsefile(filename)
            return MemoryData(
                Vector{String}(get(data, "facts", String[])),
                Vector{Dict{String, String}}(get(data, "history", Dict{String, String}[])),
                get(data, "last_updated", string(now()))
            )
        catch e
            @warn "Failed to parse memory file. Creating new memory." exception=e
            return empty_memory()
        end
    else
        return empty_memory()
    end
end

"""
    save_memory(mem::MemoryData, filename::String=MEMORY_FILE)

Saves the current memory state to the JSON file.
"""
function save_memory(mem::MemoryData, filename::String=MEMORY_FILE)
    data = Dict(
        "facts" => mem.facts,
        "history" => mem.history,
        "last_updated" => string(now())
    )
    
    open(filename, "w") do f
        JSON.print(f, data, 4)
    end
end

"""
    add_interaction(mem::MemoryData, user_input::AbstractString, ai_response::AbstractString; filename::String=MEMORY_FILE)

Adds a User/AI interaction pair to history and saves.
"""
function add_interaction(mem::MemoryData, user_input::AbstractString, ai_response::AbstractString; filename::String=MEMORY_FILE)
    push!(mem.history, Dict("role" => "user", "content" => String(user_input)))
    push!(mem.history, Dict("role" => "assistant", "content" => String(ai_response)))
    
    # Prune history if too long (keep pairs)
    while length(mem.history) > MAX_HISTORY * 2
        popfirst!(mem.history)
    end
    
    save_memory(mem, filename)
end

"""
    add_fact(mem::MemoryData, fact::AbstractString; filename::String=MEMORY_FILE)

Adds a specific fact to long-term memory.
"""
function add_fact(mem::MemoryData, fact::AbstractString; filename::String=MEMORY_FILE)
    s_fact = String(fact)
    if !(s_fact in mem.facts)
        push!(mem.facts, s_fact)
        save_memory(mem, filename)
        return true
    end
    return false
end

"""
    get_memory_context(mem::MemoryData)

Formats the memory into a string suitable for LLM context.
"""
function get_memory_context(mem::MemoryData)
    context = ""
    
    if !isempty(mem.facts)
        context *= "\n\n[USER FACTS]\n"
        for fact in mem.facts
            context *= "- $fact\n"
        end
    end
    
    if !isempty(mem.history)
        context *= "\n[CONVERSATION HISTORY]\n"
        for msg in mem.history
            role = uppercase(msg["role"])
            content = msg["content"]
            context *= "$role: $content\n"
        end
    end
    
    return context
end

end # module