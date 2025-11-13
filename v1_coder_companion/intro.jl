using FIGlet
using Crayons
using Dates


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

function loading_bar(task::String; steps=20, delay=0.05)
    print(Crayon(foreground=:light_cyan, bold=true), "⏳ ", task, ": [")
    for i in 1:steps
        print(Crayon(foreground=:light_blue, bold=true), "#", Crayon(reset=true))
        flush(stdout)
        sleep(delay)
    end
    println(Crayon(foreground=:green, bold=true), "] ✔", Crayon(reset=true))
end

function spinner(task::String; duration=2.0)
    spinner_chars = ['|', '/', '-', '\\']
    print(Crayon(foreground=:light_cyan, bold=true), task, " ")
    t0 = time()
    while (time() - t0) < duration
        for c in spinner_chars
            print("\b", c)
            flush(stdout)
            sleep(0.1)
        end
    end
    print("\b", Crayon(foreground=:green, bold=true), "✔", Crayon(reset=true), "\n")
end

function bluna_intro()
    # Clear the screen
    print("\033c")

    # Define colors
    title_color = Crayon(foreground=:light_blue, bold=true)
    subtitle_color = Crayon(foreground=:cyan)
    info_color = Crayon(foreground=:light_cyan)
    success_color = Crayon(foreground=:green, bold=true)
    reset = Crayon(reset=true)

    # Render logo with Figlet.jl
    banner = try
        FIGlet.render("Bluna AI", "slant")
    catch
        try
            FIGlet.figlet("Bluna AI", font="slant")
        catch
            "Bluna AI"
        end
    end
    banner_color = Crayon(foreground=:light_blue, bold=true)
    println(banner_color, banner, reset)
    println(subtitle_color, "Your customizable AI programming buddy 🌙💙", reset)
    println(info_color, "Powered by Julia + Ollama (phi-3-mini)", reset)
    println(info_color, "Version: v0.1 | Started on $(Dates.format(now(), "yyyy-mm-dd HH:MM"))", reset)
    println()

    # Simulated initialization
    spinner("Initializing Bluna core modules")
    loading_bar("Loading language preferences", steps=25, delay=0.03)
    spinner("Checking Ollama connection on port 11434")
    loading_bar("Verifying AI engine integrity", steps=18, delay=0.04)
    spinner("Syncing knowledge datasets")
    loading_bar("Preparing user interface", steps=30, delay=0.025)
    println()

    println(success_color, "✔ All systems online.", reset)
    println(info_color, "Bluna ai is ready to assist you 🌙💙", reset)
    println()
    sleep(0.5)
    println(title_color, "Welcome to Bluna ai", reset)
    println(subtitle_color, "Let’s start your coding journey...", reset)
    println()
end

bluna_intro()

println("\n✅ Instructions loaded successfully!")