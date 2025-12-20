"""
    Bluna AI - Online Mode Web Scraping Module

This module provides web scraping capabilities for the Online Only Mode of Bluna AI.
It includes DuckDuckGo search integration, content extraction, and result processing.

Usage:
    include("webscraping.jl")
    results = OnlineMode.user_inputs_and_rendering("Julia programming")
    OnlineMode.format_results(results)
"""

module WebScraping

using HTTP
using Gumbo
using Cascadia
using Logging
using URIs
using JSON

export duckduckgo_search, scrape_page, user_inputs_and_rendering, WebScrapingResult, save_results_to_json, OPEN_SOURCE_DOMAINS, construct_educational_query

# Configure logging
Logging.global_logger(Logging.SimpleLogger(stderr, Logging.Info))

const OPEN_SOURCE_DOMAINS = [
    "wikipedia.org",
    "github.com",
    "stackoverflow.com",
    "readthedocs.io",
    "dev.to",
    "freecodecamp.org",
    "w3schools.com",
    "mozilla.org",
    "julialang.org",
    "python.org",
    "geeksforgeeks.org",
    "khanacademy.org"
]

"""
    construct_educational_query(base_query::AbstractString)

Constructs a query optimized for finding educational content from open sources.
"""
function construct_educational_query(base_query::AbstractString)
    # We don't use 'site:...' for all of them as it might limit results too much if the topic isn't there.
    # Instead we add semantic keywords.
    return "$base_query tutorial explanation documentation open source example"
end

# Define result type for better type safety
struct WebScrapingResult
    url::String
    title::String
    description::String
    status::Bool
    content::String
end

"""
    save_results_to_json(results::Vector{WebScrapingResult}, filename::AbstractString)

Converts a vector of WebScrapingResult objects to a JSON array and saves it to a file.
"""
function save_results_to_json(results::Vector{WebScrapingResult}, filename::AbstractString)
    json_data = Dict[]
    for res in results
        push!(json_data, Dict(
            "url" => res.url,
            "title" => res.title,
            "description" => res.description,
            "status" => res.status,
            "content" => res.content
        ))
    end
    
    open(String(filename), "w") do f
        JSON.print(f, json_data, 4) # 4 for pretty printing with 4 spaces indentation
    end
    @info "Results saved to $filename"
end


"""
    duckduckgo_search(query::AbstractString; max_results::Int=5)

Search DuckDuckGo for the given query and return a list of URLs.
"""
function duckduckgo_search(query::AbstractString; max_results::Int=5)
    try
        search_url = "https://html.duckduckgo.com/html/?q=$(HTTP.escapeuri(query))"

        headers = [
            "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36",
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language" => "en-US,en;q=0.5",
            "Accept-Encoding" => "gzip, deflate",
            "Referer" => "https://duckduckgo.com/",
            "Connection" => "keep-alive",
            "Upgrade-Insecure-Requests" => "1"
        ]

        # Add timeout handling
        response = HTTP.get(search_url; headers=headers, timeout=10, readtimeout=10, connect_timeout=10)

        if response.status != 200
            @warn "DuckDuckGo request failed: $(response.status)"
            return String[]
        end

        html = String(response.body)
        parsed = Gumbo.parsehtml(html)

        # Try multiple CSS selectors for DuckDuckGo result links
        selectors_to_try = [
            "a.result__a",             # Standard class
            ".links_main a",           # Another common one
            ".result__body a",
            "a[href^=\"/l/?uddg=\"]",  # URL pattern
            "a"                        # Fallback: check all links
        ]

        results = String[]
        found_selector = false
        
        for selector_str in selectors_to_try
            selector = Selector(selector_str)
            matches = eachmatch(selector, parsed.root)
            
            # Filter matches that look like results
            valid_matches = []
            for link in matches
                href = get(link.attributes, "href", "")
                # We want links that look like external results, usually containing uddg
                if occursin("uddg=", href) || (selector_str != "a" && !isempty(href))
                     push!(valid_matches, link)
                end
            end

            if !isempty(valid_matches)
                @info "Found $(length(valid_matches)) potential results with selector: $selector_str"
                found_selector = true

                for link in valid_matches
                    href = get(link.attributes, "href", "")
                    
                    @debug "Processing href: $href" 

                    if !isempty(href)
                        # Handle different URL formats
                        if occursin("uddg=", href) # Relaxed from startswith
                            try
                                # Parse URI and look for uddg param regardless of path
                                uri = URI(href)
                                q_params = queryparams(uri)
                                if haskey(q_params, "uddg")
                                    real_url = HTTP.unescapeuri(q_params["uddg"])
                                    push!(results, real_url)
                                    @debug "Extracted: $real_url"
                                else
                                    @warn "uddg param not found in: $href"
                                end
                            catch e
                                @warn "Failed to parse URI: $href"
                            end
                        elseif !startswith(href, "/") && (startswith(href, "http") || startswith(href, "https"))
                             # Direct links (rare in html version but possible)
                             push!(results, href)
                             @debug "Direct link: $href"
                        end
                    end
                    
                    if length(results) >= max_results 
                        break 
                    end
                end
                
                if !isempty(results)
                    break 
                end
            end
        end

        if isempty(results)
            @warn "No search results found for query: $query"
            @warn "HTML structure may have changed. First 500 chars: $(html[1:min(500, end)])"
        else
            @info "Successfully found $(length(results)) URLs for query: $query"
        end

        return unique(results)

    catch e
        @error "DuckDuckGo search error" exception=e
        return String[]
    end
end



"""
    url_tester(url::AbstractString)

Test if a URL is reachable and returns the HTTP response or nothing.
"""
function url_tester(url::AbstractString)
    try
        headers = [
            "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        ]
        
        # Enhanced timeout handling - Reduced to 5s for faster failing
        response = HTTP.get(String(url), headers; timeout=5, readtimeout=5, connect_timeout=3)
        
        # Check if response is successful
        if response.status == 200
            return response
        else
            @warn "URL returned status $(response.status): $url"
            return nothing
        end
        
    catch e
        # Silent fail for speed
        return nothing
    end
end

"""
    text_content(node)

Recursively extract text content from a Gumbo node.
"""
function text_content(node::HTMLElement)
    join([text_content(c) for c in node.children], " ")
end

function text_content(node::HTMLText)
    return node.text
end

function text_content(node)
    return ""
end

"""
    scrape_page(url::AbstractString)

Scrape a webpage and extract title, description, and content.
"""
function scrape_page(url::AbstractString)
    try
        response = url_tester(url)
        if response === nothing
            return WebScrapingResult(String(url), "Error", "Failed to access page", false, "")
        end
        
        html = String(response.body)
        parsed_html = Gumbo.parsehtml(html)
        
        # Extract title
        title_selector = Selector("title")
        title_elements = eachmatch(title_selector, parsed_html.root)
        title = if !isempty(title_elements)
            strip(text_content(first(title_elements)))
        else
            h1_selector = Selector("h1")
            h1_elements = eachmatch(h1_selector, parsed_html.root)
            if !isempty(h1_elements)
                strip(text_content(first(h1_elements)))
            else
                "No title found"
            end
        end
        
        # Extract meta description
        meta_selector = Selector("meta[name='description']")
        meta_elements = eachmatch(meta_selector, parsed_html.root)
        meta_description = isempty(meta_elements) ? "No description found" : 
                          get(first(meta_elements).attributes, "content", "No description found")
        
        # Extract main content (basic implementation)
        content_selector = Selector("main, article, .content, #content")
        content_elements = eachmatch(content_selector, parsed_html.root)
        content = if !isempty(content_elements)
            strip(text_content(first(content_elements)))
        else
            # Fallback to body text
            body_elements = eachmatch(Selector("body"), parsed_html.root)
            if isempty(body_elements)
                "No content found"
            else
                body_text = strip(text_content(first(body_elements)))
                length(body_text) > 500 ? body_text[1:500] * "..." : body_text
            end
        end
        
        return WebScrapingResult(String(url), String(title), String(meta_description), true, String(content))
        
    catch e
        @error "Error scraping page $url: $(e)"
        return WebScrapingResult(String(url), "Error", "Failed to parse page", false, "")
    end
end

"""
    user_inputs_and_rendering(input::AbstractString; max_scrape::Int=3)

Main function that processes user input, searches the web, and renders results.
Limits scraping to `max_scrape` pages to prevent hanging.
"""
function user_inputs_and_rendering(input::AbstractString; max_scrape::Int=3)
    try
        @info "Processing user input: $input"
        
        # Search for URLs - Limit to max_scrape + 2 to have some backup if one fails
        urls = duckduckgo_search(input; max_results=max_scrape + 2)
        
        if isempty(urls)
            @warn "No search results found for: $input"
            return WebScrapingResult[]
        end
        
        # Process each URL
        results = WebScrapingResult[]
        
        # Add rate limiting (basic implementation)
        for (i, url) in enumerate(urls)
            if length(results) >= max_scrape
                break
            end

            if i > 1
                sleep(0.5)  # Reduced delay
            end
            
            page_data = scrape_page(url)
            
            # Only add if successfully scraped (status is true)
            if page_data.status
                push!(results, page_data)
            end
        end
        
        @info "Successfully scraped $(length(results)) pages"
        return results
        
    catch e
        @error "Error in user_inputs_and_rendering: $(e)"
        return WebScrapingResult[]
    end
end

"""
    format_results(results::Vector{WebScrapingResult})

Format search results for display.
"""
function format_results(results::Vector{WebScrapingResult})
    if isempty(results)
        println("❌ No results found.")
        return
    end
    
    println("\n🌐 🔍 Search Results:")
    println("═"^60)
    
    for (i, result) in enumerate(results)
        println("📌 [$i] $(result.title)")
        println("   🔗 $(result.url)")
        println("   📝 $(result.description)")
        if !isempty(result.content)
            content_preview = length(result.content) > 200 ? result.content[1:200] * "..." : result.content
            println("   📄 $content_preview")
        end
        println("─"^60)
    end
end

"""
    interactive_search()

Interactive search function for command-line usage.
"""
function interactive_search()
    println("╔" * "═"^58 * "╗")
    println("║  🌐 Bluna AI - Online Mode                               ║")
    println("╚" * "═"^58 * "╝")
    println("💡 Enter your search query (or 'quit' to exit):")
    
    while true
        print("\n🔎 Search > ")
        input_query = strip(readline())
        
        if lowercase(input_query) in ["quit", "exit", "q"]
            println("👋 Goodbye! ✨")
            break
        end
        
        if isempty(input_query)
            println("⚠️  Please enter a valid search query.")
            continue
        end
        
        println("🔄 🔍 Searching...")
        scraped_results = user_inputs_and_rendering(input_query)
        format_results(scraped_results)
        println()
    end
end

"""
    example_usage()

Example usage function demonstrating module capabilities.
"""
function example_usage()
    println("🌐 Bluna AI - Web Scraping Example")
    println("Demonstrating module usage...")
    
    # Example 1: Simple search
    println("\n📝 Example 1: Simple search")
    test_query = "Julia programming language"
    println("Searching for: $test_query")
    
    results = user_inputs_and_rendering(test_query)
    format_results(results)
    
    # Example 2: Custom search with fewer results
    println("\n📝 Example 2: Custom search with 3 results")
    custom_query = "machine learning"
    println("Searching for: $custom_query")
    
    urls = duckduckgo_search(custom_query; max_results=3)
    println("Found $(length(urls)) URLs")
    
    # Example 3: Test individual URL scraping
    if !isempty(urls)
        println("\n📝 Example 3: Individual URL scraping")
        test_url = urls[1]
        println("Scraping: $test_url")
        
        page_data = scrape_page(test_url)
        println("Title: $(page_data.title)")
        println("Description: $(page_data.description)")
        println("Status: $(page_data.status)")
    end
    
    return results
end

# Main execution block - runs when file is executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    println("🚀 Starting Bluna AI Online Mode...")
    
    # Check command line arguments
    if length(ARGS) > 0
        query = ARGS[1]
        println("🔍 Searching for: $query")
        results = user_inputs_and_rendering(query)
        format_results(results)
    else
        # Run interactive mode
        interactive_search()
    end
end

end # module
