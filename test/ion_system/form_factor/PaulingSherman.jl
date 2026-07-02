using Test
using ElectronicStructureModels
using XDaveWrapper

_groundtruth_ff(ions::IonSystem, q) = XDaveWrapper.groundtruth_form_factor(
    atomic_number(ions), ionization_state(ions), q
)

const QS = [0.2]

@testset "ZA = $ZA" for ZA in 1:29
    @testset "ZF = $ZF" for ZF in 1:ZA
        ions = IonSystem(ZA, ZF)

        @testset "q = $q" for q in QS
            groundtruth = _groundtruth_ff(ions, q)
            @test isapprox(groundtruth, form_factor(ions, PaulingSherman(), q))
        end
    end
end
