using Crayons

function user_choices()
    # Colors
    title_color = Crayon(foreground=:light_blue, bold=true)
    option_color = Crayon(foreground=:cyan)
    prompt_color = Crayon(foreground=:light_cyan)
    reset = Crayon(reset=true)

    println(title_color, "\n=============================", reset)
    println(title_color, "       🌙 Bluna ai Menu       ", reset)
    println(title_color, "=============================\n", reset)

    # Genre selection
    genres = [
        "General Basics",
        "Data Structures and Algorithms"
    ]

    println(option_color, "Choose a genre:", reset)
    for (i, g) in enumerate(genres)
        println("  [$i] $g")
    end
    print(prompt_color, "\nEnter your choice: ", reset)
    genre_choice = tryparse(Int, readline())
    genre = (genre_choice in 1:length(genres)) ? genres[genre_choice] : "General Basics"

    println("\nYou selected → ", title_color, genre, reset)
    sleep(0.5)

    # Language selection
    languages = [
        "Julia",
        "Python",
        "Java",
        "C / C++",
        "Rust",
        "Go",
        "PHP",
        "SQL",
        "Web Development (HTML, CSS, JS)"
    ]

    println(option_color, "\nChoose your language:", reset)
    for (i, lang) in enumerate(languages)
        println("  [$i] $lang")
    end
    print(prompt_color, "\nEnter your choice: ", reset)
    lang_choice = tryparse(Int, readline())
    language = (lang_choice in 1:length(languages)) ? languages[lang_choice] : "Julia"

    println("\nYou selected → ", title_color, language, reset)
    println()
    sleep(0.6)

    println(Crayon(foreground=:green, bold=true), "✔ Choices saved successfully!", reset)
    println(prompt_color, "Bluna ai will now adapt to your preferences 🌙💙", reset)
    println()

    # Return values for future use
    return (genre, language)
end
# To use the function, uncomment the line below:
# user_choices()