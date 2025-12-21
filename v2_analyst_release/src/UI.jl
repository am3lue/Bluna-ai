module UI

using Crayons
using FIGlet

export TITLE_COLOR, OPTION_COLOR, PROMPT_COLOR, BLUNA_COLOR, USER_COLOR, SYSTEM_COLOR, RESET
export BOLD, RED, GREEN, YELLOW, CYAN, BLUE, PURPLE, WHITE
export print_header, clear_screen, render_logo

# --- v1 UI Helpers ---
const TITLE_COLOR = Crayon(foreground=:light_blue, bold=true)
const OPTION_COLOR = Crayon(foreground=:cyan)
const PROMPT_COLOR = Crayon(foreground=:light_cyan)
const BLUNA_COLOR = Crayon(foreground=:light_magenta, bold=true)
const USER_COLOR = Crayon(foreground=:green, bold=true)
const SYSTEM_COLOR = Crayon(foreground=:yellow)
const RESET = Crayon(reset=true)

# Base Colors for internal use
const BOLD   = Crayon(bold=true)
const RED    = Crayon(foreground=:red)
const GREEN  = Crayon(foreground=:green)
const YELLOW = Crayon(foreground=:yellow)
const CYAN   = Crayon(foreground=:cyan)
const BLUE   = Crayon(foreground=:blue)
const PURPLE = Crayon(foreground=:magenta)
const WHITE  = Crayon(foreground=:white)

function clear_screen()
    print("\033c")
end

function render_logo()
    FIGlet.render("Bluna AI", "Big Money-nw")
end

function print_header(config)
    clear_screen()
    render_logo()
    println(TITLE_COLOR, "─"^40, RESET)
    println(OPTION_COLOR, " Welcome back, $(config.user_name)!", RESET)
    println(OPTION_COLOR, " Mode: $(config.learning_genre) | $(config.favorite_language)", RESET)
    println(OPTION_COLOR, " Style: $(config.teaching_style)", RESET)
    println(TITLE_COLOR, "─"^40, RESET)
    println(Crayon(foreground=:dark_gray), " (Type 'exit' to quit, 'create schedule' for a plan)", RESET)
    println()
end

end # module
