using Test
using SafeTestsets

begin
    @safetestset "subshells" begin
        include("ion_system/subshells.jl")
    end

    @safetestset "IonSysten" begin
        include("ion_system/impl.jl")
    end

    @safetestset "FormFactors" begin
        include("ion_system/form_factor/PaulingSherman.jl")
    end
end
