using Test
using ElectronicStructureModels
using PeriodicTable

@testset "ZA = $ZA" for ZA in 1:100
    @testset "ZF = $ZF" for ZF in 1:ZA

        @testset "Properties" begin
            ions = IonSystem(ZA, ZF)
            @test atomic_number(ions) == ZA
            @test ionization_state(ions) == ZF
            @test number_bound_electrons(ions) == ZA - ZF
        end

        @testset "PeriodicTable integration" begin
            ions = IonSystem(elements[ZA], ZF)

            @test atomic_number(ions) == ZA
            @test ionization_state(ions) == ZF
            @test number_bound_electrons(ions) == ZA - ZF
            @test element(ions) == elements[ZA]
        end
    end
end
