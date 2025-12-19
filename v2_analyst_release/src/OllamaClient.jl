module OllamaClient

using HTTP
using JSON

export generate_completion

"""
    generate_completion(prompt::AbstractString; model::String="qwen2.5-coder:0.5b", system::String="", host::String="http://localhost:11434")

Generates a completion from the Ollama API.
"""
function generate_completion(prompt::AbstractString; model::String="qwen2.5-coder:0.5b", system::String="", host::String="http://localhost:11434")
    url = "$host/api/generate"
    
    body = Dict(
        "model" => model,
        "prompt" => prompt,
        "stream" => false
    )
    
    if !isempty(system)
        body["system"] = system
    end

    try
        response = HTTP.post(url, 
            ["Content-Type" => "application/json"], 
            JSON.json(body),
            readtimeout=120,
            connect_timeout=10
        )
        
        if response.status == 200
            result = JSON.parse(String(response.body))
            return get(result, "response", "Error: No response field in JSON")
        else
            return "Error: HTTP $(response.status)"
        end
    catch e
        return "Error connecting to Ollama: $e. Ensure Ollama is running at $host"
    end
end

end # module
