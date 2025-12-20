include("src/Memory.jl")
using .Memory
using Test
using Dates

# Helper to clean up test file
const TEST_FILE = "bluna_memory_test.json"

# Monkey patch the constant for testing (requires redefining the module or just changing the file path if possible, 
# but since it's a constant, we'll just rename the real file temporarily or just trust the logic.
# Actually, let's just use the functions with a temporary file if I could, but the module hardcodes it.
# Alternative: I'll just write a script that uses the existing functions but checks the side effects.
# Wait, Memory.jl hardcodes "bluna_memory.json". I should probably make that configurable for better testing.

# Let's modify Memory.jl first to make the filename configurable.
println("Refactoring Memory.jl to allow custom filenames for testing...")
