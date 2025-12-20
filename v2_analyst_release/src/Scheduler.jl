module Scheduler

using Dates
using Printf

export generate_schedule, LearningSession, save_schedule_to_file

struct LearningSession
    date::Date
    topic::String
    description::String
    resources::String
end

# --- Curricula Database ---
const CURRICULA = Dict(
    "julia" => [
        ("Introduction & Setup", "Installing Julia, VS Code, REPL basics.", "https://julialang.org/downloads/"),
        ("Variables & Types", "Integers, Floats, Strings, and basic type system.", "https://docs.julialang.org/en/v1/manual/variables/"),
        ("Control Flow", "If/else, Loops (for, while), Short-circuit evaluation.", "https://docs.julialang.org/en/v1/manual/control-flow/"),
        ("Functions", "Defining functions, arguments, return values, multiple dispatch introduction.", "https://docs.julialang.org/en/v1/manual/functions/"),
        ("Data Structures", "Arrays, Tuples, Dictionaries, Sets.", "https://docs.julialang.org/en/v1/base/collections/"),
        ("Modules & Packages", "Using, import, Pkg manager, installing packages.", "https://docs.julialang.org/en/v1/manual/modules/"),
        ("Structs & Types", "Defining composite types, mutable vs immutable.", "https://docs.julialang.org/en/v1/manual/types/"),
        ("Multiple Dispatch", "Deep dive into methods and dispatch.", "https://docs.julialang.org/en/v1/manual/methods/"),
        ("File I/O", "Reading and writing files, CSV processing.", "https://docs.julialang.org/en/v1/base/io-network/"),
        ("Project: Data Analysis", "Building a simple data analysis script using CSV.jl and DataFrames.jl.", "Top 10 Julia Projects for Beginners"),
        ("Metaprogramming Basics", "Macros and generated functions (intro).", "https://docs.julialang.org/en/v1/manual/metaprogramming/"),
        ("Final Project", "Build a CLI tool or simple web server.", "Genie.jl or HTTP.jl docs")
    ],
    "python" => [
        ("Setup & Hello World", "Installing Python, pip, virtual environments.", "python.org"),
        ("Variables & Data Types", "Strings, Numbers, Booleans, Lists.", "docs.python.org"),
        ("Control Structures", "If/elif/else, For loops, While loops.", "w3schools.com/python"),
        ("Functions", "def, args, kwargs, lambda functions.", "realpython.com"),
        ("Data Structures", "Dictionaries, Sets, Tuples, List Comprehensions.", "docs.python.org"),
        ("Modules & PIP", "Importing modules, installing packages with pip.", "pypi.org"),
        ("File Handling", "Open, read, write, with context managers.", "geeksforgeeks.org"),
        ("OOP Basics", "Classes, Objects, Inheritance, Init.", "realpython.com/python3-object-oriented-programming/"),
        ("Error Handling", "Try, except, finally, raising exceptions.", "docs.python.org"),
        ("Project: Web Scraper", "Using requests and BeautifulSoup.", "beautiful-soup-4.readthedocs.io"),
        ("Project: Simple API", "Using Flask or FastAPI.", "fastapi.tiangolo.com"),
        ("Final Project", "Build a complete automation script.", "automatetheboringstuff.com")
    ],
    "generic" => [
        ("Logic & Algorithms", "Basic logic, flowcharts, pseudocode.", "khanacademy.org"),
        ("Variables & Memory", "How computers store data.", "cs50.harvard.edu"),
        ("Loops & Iteration", "Repeating tasks efficiently.", "geeksforgeeks.org"),
        ("Functions & Modularity", "Breaking code into reusable blocks.", "clean-code-developer.com"),
        ("Data Structures", "Arrays, Linked Lists, Hash Maps.", "programiz.com"),
        ("Object-Oriented Design", "Classes, Objects, Encapsulation.", "wikipedia.org/wiki/Object-oriented_programming"),
        ("Databases", "SQL basics, Relational vs NoSQL.", "w3schools.com/sql"),
        ("Web Basics", "HTTP, HTML, CSS, JavaScript intro.", "developer.mozilla.org"),
        ("Version Control", "Git basics: init, add, commit, push.", "git-scm.com/doc"),
        ("Testing", "Unit testing, TDD basics.", "guru99.com/unit-testing-guide.html")
    ]
)

"""
    generate_schedule(language::AbstractString, start_date::Date, days_per_week::Vector{Int})

Generates a learning schedule.
`days_per_week`: Vector of integers where 1=Monday, 7=Sunday.
"""
function generate_schedule(language::AbstractString, start_date::Date, days_per_week::Vector{Int})
    lang_key = lowercase(String(language))
    if !haskey(CURRICULA, lang_key)
        lang_key = "generic"
    end
    
    curriculum = CURRICULA[lang_key]
    schedule = LearningSession[]
    
    current_date = start_date
    topic_index = 1
    
    while topic_index <= length(curriculum)
        # Check if current_date is a learning day
        if dayofweek(current_date) in days_per_week
            topic, desc, res = curriculum[topic_index]
            push!(schedule, LearningSession(current_date, topic, desc, res))
            topic_index += 1
        end
        current_date += Day(1)
        
        # Safety break: don't schedule beyond 1 year
        if current_date > start_date + Year(1)
            break
        end
    end
    
    return schedule, lang_key
end

"""
    save_schedule_to_file(schedule::Vector{LearningSession}, language::AbstractString, filename::AbstractString)

Saves the schedule to a readable Markdown file.
"""
function save_schedule_to_file(schedule::Vector{LearningSession}, language::AbstractString, filename::AbstractString)
    open(String(filename), "w") do f
        println(f, "# 📅 Personalized Learning Schedule: $(uppercase(language))")
        println(f, "Generated on: $(now())\n")
        
        println(f, "| Date | Topic | Description | Resources |")
        println(f, "|------|-------|-------------|-----------|")
        
        for session in schedule
            date_str = Dates.format(session.date, "yyyy-mm-dd (E)")
            println(f, "| **$date_str** | $(session.topic) | $(session.description) | [Link]($(session.resources)) |")
        end
        
        println(f, "\n## 🚀 Your Goal")
        println(f, "Complete all modules by **$(Dates.format(schedule[end].date, "yyyy-mm-dd"))**. Good luck!")
    end
    return true
end

end # module
