using Test
using ElectronicStructureModels
using XDaveWrapper

using Random
using Unitful

RNG = Xoshiro(161)

_transform12(x01) = x01 + one(x01)

_groundtruth_ff(ions::IonSystem, q) = XDaveWrapper.groundtruth_form_factor(
    atomic_number(ions), ionization_state(ions), q
)

const QS = [0.2]

const NIS_ccm = 1u"cm^(-3)" .* (
    _transform12(rand(RNG)) * 1.0e20,
)
const TEMPS_eV = 1u"eV" .* (
    rand(RNG),
)
@testset "T = $T" for T in TEMPS_eV
    @testset "N = $N" for N in NIS_ccm
        @testset "ZA = $ZA" for ZA in 1:29
            @testset "ZF = $ZF" for ZF in 1:ZA
                ions = IonSystem(ZA, ZF, N, T)

                @testset "q = $q" for q in QS
                    groundtruth = _groundtruth_ff(ions, q)
                    @test isapprox(groundtruth, form_factor(ions, PaulingSherman(), q))
                end
            end
        end
    end
end
