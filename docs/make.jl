using MatterModels
using Documenter

DocMeta.setdocmeta!(MatterModels, :DocTestSetup, :(using MatterModels); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers
const numbered_pages = [
    file for file in readdir(joinpath(@__DIR__, "src")) if
        file != "index.md" && splitext(file)[2] == ".md"
]

makedocs(;
    modules = [MatterModels],
    authors = "Uwe Hernandez Acosta <u.hernandez@hzdr.de>",
    repo = "https://github.com/JuliaXRTS/MatterModels.jl/blob/{commit}{path}#{line}",
    sitename = "MatterModels.jl",
    format = Documenter.HTML(; canonical = "https://JuliaXRTS.github.io/MatterModels.jl"),
    pages = ["index.md"; numbered_pages],
)

deploydocs(; repo = "github.com/JuliaXRTS/MatterModels.jl")
