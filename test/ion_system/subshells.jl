using Test
using ElectronicStructureModels

@testset "Subshell invariants" begin

    for s in AUFBAU_SHELLS
        n = n_value(s)
        l = l_value(s)
        @test n >= 1
        @test 0 <= l < n
        @test capacity(s) == 4l + 2
    end
end

@testset "Aufbau ordering" begin

    # odering according to the n+l rule (https://en.wikipedia.org/wiki/Aufbau_principle#Madelung_energy_ordering_rule)
    keys = [(n_value(s) + l_value(s), n_value(s)) for s in AUFBAU_SHELLS]
    @test issorted(keys)
end
