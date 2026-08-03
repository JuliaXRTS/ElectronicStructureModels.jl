using Test
using SafeTestsets

begin
    @safetestset "OneComponentPlasma" begin
        include("plasma/impl.jl")
    end

end
