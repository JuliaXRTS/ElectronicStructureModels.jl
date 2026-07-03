# TODO:
# - add checks if the quantities T and N are actually temperatues and densities


using Test
using ElectronicStructureModels
using PeriodicTable
using Random
using Unitful

RNG = Xoshiro(161)

_transform12(x01) = x01 + one(x01)

NIS_ccm = 1u"cm^(-3)" .* (
    _transform12(rand(RNG)) * 1.0e20,
)
TEMPS_eV = 1u"eV" .* (
    rand(RNG),
)
@testset "T = $T" for T in TEMPS_eV
    @testset "N = $N" for N in NIS_ccm
        n_internal = ElectronicStructureModels._internalize_density(N)
        T_internal = ElectronicStructureModels._internalize_temperature(T)

        @testset "ZA = $ZA" for ZA in 1:100
            @testset "ZF = $ZF" for ZF in 1:ZA

                @testset "Properties" begin
                    ions = IonSystem(ZA, ZF, N, T)
                    @test atomic_number(ions) == ZA
                    @test ionization_state(ions) == ZF
                    @test number_bound_electrons(ions) == ZA - ZF

                    @test isapprox(temperature(ions), T_internal)
                    @test isapprox(number_density(ions), n_internal)
                end

                @testset "PeriodicTable integration" begin
                    ions = IonSystem(elements[ZA], ZF, N, T)

                    @test atomic_number(ions) == ZA
                    @test ionization_state(ions) == ZF
                    @test number_bound_electrons(ions) == ZA - ZF
                    @test element(ions) == elements[ZA]

                    @test isapprox(temperature(ions), T_internal)
                    @test isapprox(number_density(ions), n_internal)
                end
            end
        end
    end
end
