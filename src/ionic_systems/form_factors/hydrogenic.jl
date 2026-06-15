# ---------------------------------------------------------------------------
# Hydrogenic sub-shell form factors  f_{nl}(x)
#
# Each function takes the *pre-scaled* variable
#   x_nl = n * a₀ [eV⁻¹] * k [kF] * kF [eV] / (2 * Z_eff)
# which is dimensionless.
#
# Formulae from Pauling & Sherman (1932), consistent with the JAX reference
# implementation.  Where the first Python implementation used the same formula
# for both c3s and c3p contributions, the JAX code (and this port) correctly
# distinguishes f30 (3s) from f31 (3p) and f32 (3d).  The first Python code
# appears to contain a bug by applying the f30/f32 product form to c3p as well.
#
# TODO: check formulae against the original paper!

@inline f10(x) = 1 / (1 + x^2)^2

@inline f21(x) = (1 - x^2) / (1 + x^2)^4
@inline f20(x) = (1 - 2x^2) * f21(x)

@inline f32(x) = ((1 - 3x^2) * (3 - x^2)) / (3 * (1 + x^2)^6)
@inline f31(x) = (1 - 4x^2) * f32(x) # differs from xdave
@inline f30(x) = (1 - 6x^2 + 3x^4) * f32(x)

@inline f43(x) = ((1 - x^2) * (1 - 6x^2 + x^4)) / (1 + x^2)^8
@inline f42(x) = (1 - 6x^2) * f43(x)
@inline f41(x) = (1 - 10x^2 + 10x^4) * f43(x)
@inline f40(x) = (1 - 12x^2 + 18x^4 - 4x^6) * f43(x) # differs from xdave


_hydrogenic_ff(s::Subshell2{:s1s}, x) = f10(x)
_hydrogenic_ff(s::Subshell2{:s2s}, x) = f20(x)
_hydrogenic_ff(s::Subshell2{:s2p}, x) = f21(x)
_hydrogenic_ff(s::Subshell2{:s3s}, x) = f30(x)
_hydrogenic_ff(s::Subshell2{:s3p}, x) = f31(x)
_hydrogenic_ff(s::Subshell2{:s3d}, x) = f32(x)
_hydrogenic_ff(s::Subshell2{:s4s}, x) = f40(x)
