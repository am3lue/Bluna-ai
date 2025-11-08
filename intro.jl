using FIGlet
using Crayons
using Dates

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
        FIGlet.render("Bluna ai", font="slant")
    catch
        try
            FIGlet.figlet("Bluna ai", font="slant")
        catch
            "Bluna ai"
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

# Run intro
bluna_intro()

#including choices.jl to get user preferences
include("choices.jl")
genre, language = user_choices()

#saving choices to the choices.txt file

choices = Dict("genre" => genre, "language" => language)
open("choices.txt", "w") do f
    write(f, "genre = $genre\n")
    write(f, "language = $language\n")
end
