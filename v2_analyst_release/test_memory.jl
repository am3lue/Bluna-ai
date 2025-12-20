include("src/Memory.jl")
using .Memory
using Test
using Dates
using JSON

const TEST_FILE = "bluna_memory_test.json"

@testset "Memory Module Tests" begin
    # 1. Clean start
    if isfile(TEST_FILE)
        rm(TEST_FILE)
    end
    
    # 2. Test initialization
    mem = load_memory(TEST_FILE)
    @test isempty(mem.facts)
    @test isempty(mem.history)
    
    # 3. Test adding a fact
    add_fact(mem, "The user likes Julia", filename=TEST_FILE)
    @test "The user likes Julia" in mem.facts
    @test isfile(TEST_FILE)
    
    # 4. Test persistence (loading the same file)
    mem2 = load_memory(TEST_FILE)
    @test "The user likes Julia" in mem2.facts
    
    # 5. Test adding interaction
    add_interaction(mem2, "Hello", "Hi there!", filename=TEST_FILE)
    @test length(mem2.history) == 2
    @test mem2.history[1]["content"] == "Hello"
    @test mem2.history[2]["content"] == "Hi there!"
    
    # 6. Test context generation
    context = get_memory_context(mem2)
    @test occursin("[USER FACTS]", context)
    @test occursin("The user likes Julia", context)
    @test occursin("[CONVERSATION HISTORY]", context)
    @test occursin("USER: Hello", context)
    
    println("✅ All Memory tests passed!")
end

# Clean up
if isfile(TEST_FILE)
    rm(TEST_FILE)
end
