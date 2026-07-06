using Test
using ElectronicStructureModels
using PeriodicTable
using Random
using Unitful

RNG = Xoshiro(161)

_transform12(x01) = x01 + one(x01)

N_IONS_ccm = 1u"cm^(-3)" .* (
    _transform12(rand(RNG)) * 1.0e20,
)
TEMPS_IONS_eV = 1u"eV" .* (
    rand(RNG),
)

N_ELECS_ccm = 1u"cm^(-3)" .* (
    _transform12(rand(RNG)) * 1.0e20,
)
TEMPS_ELECS_eV = 1u"eV" .* (
    rand(RNG),
)

ZA = 12
ZF = 2

@testset "Ni= $Ni" for Ni in N_IONS_ccm
    @testset "Ti = $Ti" for Ti in TEMPS_IONS_eV
        @testset "Ne= $Ne" for Ne in N_ELECS_ccm
            @testset "Te = $Te" for Te in TEMPS_IONS_eV
                Ne_internal = ElectronicStructureModels._internalize_density(Ne)
                Te_internal = ElectronicStructureModels._internalize_temperature(Te)
                Ni_internal = ElectronicStructureModels._internalize_density(Ni)
                Ti_internal = ElectronicStructureModels._internalize_temperature(Ti)

                electrons = IdealElectronSystem(Ne, Te)
                ions = IonSystem(ZA, ZF, Ni, Ti)
                plasma = OneComponentPlasma(electrons, ions)

                @testset "properties" begin

                    @test electron_system(plasma) == electrons
                    @test isapprox(electron_temperature(plasma), Te_internal)
                    @test isapprox(electron_density(plasma), Ne_internal)

                    @test ion_system(plasma) == ions
                    @test isapprox(ion_temperature(plasma), Ti_internal)
                    @test isapprox(ion_density(plasma), Ni_internal)

                end

                @testset "delegations" begin

                    @test atomic_number(plasma) == ZA
                    @test ionization_state(plasma) == ZF
                    @test number_bound_electrons(plasma) == ZA - ZF
                    @test element(plasma) == elements[ZA]

                end
            end
        end
    end
end
