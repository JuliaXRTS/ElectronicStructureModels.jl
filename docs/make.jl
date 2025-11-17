using ElectronicStructureModels
using Documenter

DocMeta.setdocmeta!(ElectronicStructureModels, :DocTestSetup, :(using ElectronicStructureModels); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers
const numbered_pages = [
    file for file in readdir(joinpath(@__DIR__, "src")) if
        file != "index.md" && splitext(file)[2] == ".md"
]

makedocs(;
    modules = [ElectronicStructureModels],
    authors = "Uwe Hernandez Acosta <u.hernandez@hzdr.de>",
    repo = "https://github.com/JuliaXRTS/ElectronicStructureModels.jl/blob/{commit}{path}#{line}",
    sitename = "ElectronicStructureModels.jl",
    format = Documenter.HTML(; canonical = "https://JuliaXRTS.github.io/ElectronicStructureModels.jl"),
    pages = ["index.md"; numbered_pages],
)

deploydocs(; repo = "github.com/JuliaXRTS/ElectronicStructureModels.jl", push_preview = true)
