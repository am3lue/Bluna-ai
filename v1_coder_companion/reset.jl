# reset.jl

function reset_user_preferences()
    files_to_delete = [
        "choices.txt",
        "prompts/choices.txt",
        "prompts/final_instructions.json"
    ]

    for file in files_to_delete
        if isfile(file)
            try
                rm(file)
                println("Deleted: $file")
            catch e
                println("Error deleting $file: $e")
            end
        else
            println("File not found: $file")
        end
    end
end

# To run the reset function, uncomment the line below
# reset_user_preferences()
