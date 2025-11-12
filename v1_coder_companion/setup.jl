# setup.jl

# Define the required packages
using Pkg

# Read requirements from requirements.txt
open("requirements.txt", "r") do file
    for line in eachline(file)
        pkg = strip(line)
        if !isempty(pkg)
            Pkg.add(pkg)
        end
    end
end

println("All packages from requirements.txt have been installed.")

include("intro.jl")