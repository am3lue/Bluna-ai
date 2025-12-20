using Test
using Dates
using JSON

# We load the application. 
# main.jl includes the sub-modules (OllamaClient, WebScraping, Memory, Scheduler).
# It uses 'include' so the modules are defined in Main.
include("main.jl")

# Accessing the modules via Main
using .Memory
using .Scheduler

@testset "Bluna AI Comprehensive Tests" begin

    # --- 1. Memory Tests ---
    @testset "Memory Module" begin
        test_file = "test_memory_comprehensive.json"
        if isfile(test_file) rm(test_file) end
        
        # Test Creation
        mem = Memory.load_memory(test_file)
        @test isempty(mem.facts)
        
        # Test persistence
        Memory.add_fact(mem, "I love coding", filename=test_file)
        mem2 = Memory.load_memory(test_file)
        @test "I love coding" in mem2.facts
        
        # Test clearing
        mem2 = Memory.empty_memory()
        Memory.save_memory(mem2, test_file)
        mem3 = Memory.load_memory(test_file)
        @test isempty(mem3.facts)
        
        rm(test_file)
    end

    # --- 2. Scheduler Tests ---
    @testset "Scheduler Module" begin
        # Test Julia Schedule
        schedule, lang = Scheduler.generate_schedule("Julia", today(), [1, 3, 5]) # Mon, Wed, Fri
        @test lang == "julia"
        @test length(schedule) > 0
        @test dayofweek(schedule[1].date) in [1, 3, 5]
        
        # Test Generic Fallback
        schedule, lang = Scheduler.generate_schedule("Rust", today(), [6, 7])
        @test lang == "generic"
        @test dayofweek(schedule[1].date) in [6, 7]
        
        # Test File Saving
        fname = "Test_Plan.md"
        Scheduler.save_schedule_to_file(schedule, lang, fname)
        @test isfile(fname)
        rm(fname)
    end

    # --- 3. Interaction Logic (Wizard) ---
    @testset "Scheduler Wizard Interaction" begin
        # We simulate user input: "Julia" -> "1, 3, 5"
        # Ensure we send Strings
        input_data = "Julia\n1, 3, 5\n"
        io_in = IOBuffer(input_data)
        io_out = IOBuffer()
        
        # Run the wizard with injected IO
        # We need to make sure GLOBAL_MEMORY is initialized because run_scheduler_wizard might access it to save the plan fact
        global GLOBAL_MEMORY = Memory.empty_memory()
        
        run_scheduler_wizard(io_in, io_out)
        
        output = String(take!(io_out))
        
        # Check prompts and outputs
        @test occursin("Which language", output)
        @test occursin("Which days", output)
        @test occursin("Plan Generated for JULIA", output)
        @test occursin("Schedule saved", output)
        
        # Clean up the generated file
        if isfile("LearningPlan_JULIA.md")
            rm("LearningPlan_JULIA.md")
        end
    end
    
    # --- 4. Main Input Handler Logic ---
    @testset "Command Handling" begin
        # Test "Remember" command
        input_str = "Remember that I am a tester"
        io_out = IOBuffer()
        
        # Initialize Memory
        global GLOBAL_MEMORY = Memory.empty_memory()
        
        # We need to make sure handle_user_input uses the correct stream methods
        # Note: handle_user_input for "Remember" uses `println(io_out, ...)` which works with IOBuffer.
        
        handle_user_input(input_str, stdin, io_out)
        output = String(take!(io_out))
        
        @test occursin("I've saved that", output)
        @test "I am a tester" in GLOBAL_MEMORY.facts
        
        # Test "Clear Memory" - Say 'n' (no)
        input_io = IOBuffer("n\n")
        io_out = IOBuffer()
        handle_user_input("clear memory", input_io, io_out)
        output = String(take!(io_out))
        @test occursin("Memory preserved", output)
        
        # Test "Clear Memory" - Say 'y' (yes)
        input_io = IOBuffer("y\n")
        io_out = IOBuffer()
        handle_user_input("clear memory", input_io, io_out)
        output = String(take!(io_out))
        @test occursin("Memory wiped clean", output)
        @test isempty(GLOBAL_MEMORY.facts)
    end

end