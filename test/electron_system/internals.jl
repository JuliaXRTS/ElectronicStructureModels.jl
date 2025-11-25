using Test
using Random
using QuadGK

using ElectronicStructureModels

### Groundtruth

function _general_fermi(x, beta)
    mu = ElectronicStructureModels._chemical_potential_normalized(beta)
    exp(beta * (x^2 - mu))
    denom = exp(beta * (x^2 - mu)) + one(beta)
    return inv(denom)
end

function _general_integrand(x, nu, beta)
    return x * _general_fermi(x, beta) * log(abs(x - nu) / abs(x + nu))
end

function _groundtruth_integral(nu, beta)
    res, _ = quadgk(x -> _general_integrand(x, nu, beta), 0.0, nu, Inf)

    return res
end

RNG = Xoshiro(137137)

NUS = rand(RNG) .* 10.0 .^ (-6:3)
BETAS = (rand(RNG) * 1.0e-6, rand(RNG) * 1.0e-3, rand(RNG), rand(RNG) * 10.0)

@testset "Lindhard integral" begin
    @testset "nu = $nu, beta = $beta" for (nu, beta) in Iterators.product(NUS, BETAS)
        groundtruth = _groundtruth_integral(nu, beta)
        value = ElectronicStructureModels._general_integral(nu, beta)
        @test isapprox(value, groundtruth, rtol = 1.0e-6)
    end
end
