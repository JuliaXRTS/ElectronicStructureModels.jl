struct PaulingShermanScreeningTable{N}
    zb_min::Int
    values::NTuple{N, Float64}
end
Base.length(::PaulingShermanScreeningTable{N}) where {N} = N

const _PS_C1S = PaulingShermanScreeningTable(1, (0.19,))
const _PS_C2S = PaulingShermanScreeningTable(2, (1.25, 1.51, 1.78, 2.04, 2.31, 2.57, 2.84, 3.1))
const _PS_C2P = PaulingShermanScreeningTable(4, Tuple([2.5, 2.91, 3.33, 3.74, 4.16, fill(4.57, 29)...])) # extent with last element
const _PS_C3S = PaulingShermanScreeningTable(10, (6.6, 6.96, 7.31, 7.67, 8.03, 8.387, 8.744, 9.1, 9.1, 9.1, 9.28, 9.46, 9.64, 9.82, 10.0, 10.18, 10.36, 10.54, 10.72))
const _PS_C3P = PaulingShermanScreeningTable(
    12, (
        8.7e0,
        9.14e0,
        9.58e0,
        1.002e1,
        1.046e1,
        1.09e1,
        1.09e1,
        1.09e1,
        1.113e1,
        1.136e1,
        1.159e1,
        1.182e1,
        1.205e1,
        1.228e1,
        1.251e0,
        1.274e1,
        1.297e1,
    )
)

const _PS_C4S = PaulingShermanScreeningTable(
    18, (
        1.34e1,
        1.39e1,
        1.466e1,
        1.542e1,
        1.618e1,
        1.694e1,
        1.77e1,
        1.846e1,
        1.922e1,
        1.998e1,
        2.074e1,
    )
)
const _PS_C3D = PaulingShermanScreeningTable(20, (1.47e1, 1.503e1, 1.536e1, 1.569e1, 1.603e1, 1.636e1, 1.67e1, 1.703e1, 1.737e1))

### generic lookup
@inline function _lookup(t::PaulingShermanScreeningTable, ZA::Int, Zb::Int)
    Base.@boundscheck begin
        Zb <= t.zb_min && return 0.0
        Zb > ZA       && return 0.0
    end

    idx = min(Zb - t.zb_min, length(t.values))
    @inbounds return t.values[idx]
end

### lookup based on subshells
@inline _lookup(::Subshell{:s1s}, ZA::Int, Zb::Int) = _lookup(_PS_C1S, ZA, Zb)
@inline _lookup(::Subshell{:s2s}, ZA::Int, Zb::Int) = _lookup(_PS_C2S, ZA, Zb)
@inline _lookup(::Subshell{:s2p}, ZA::Int, Zb::Int) = _lookup(_PS_C2P, ZA, Zb)
@inline _lookup(::Subshell{:s3s}, ZA::Int, Zb::Int) = _lookup(_PS_C3S, ZA, Zb)
@inline _lookup(::Subshell{:s3p}, ZA::Int, Zb::Int) = _lookup(_PS_C3P, ZA, Zb)
@inline _lookup(::Subshell{:s4s}, ZA::Int, Zb::Int) = _lookup(_PS_C4S, ZA, Zb)
@inline _lookup(::Subshell{:s3d}, ZA::Int, Zb::Int) = _lookup(_PS_C3D, ZA, Zb)

function effective_nuclear_charge(s::Subshell, Z, Zb)
    return Z - _lookup(s, Z, Zb)
end


### Taken from Pauling, Sherman
@inline f10(x) = 1 / (1 + x^2)^2

@inline f21(x) = (1 - x^2) / (1 + x^2)^4
@inline f20(x) = (1 - 2x^2) * f21(x)

@inline f32(x) = ((1 - 3x^2) * (3 - x^2)) / (3 * (1 + x^2)^6)
#@inline f31(x) = (1 - 4x^2) * f32(x) # differs from xdave
@inline f31(x) = (1 - 6 * x^2 + 3 * x^4) * f32(x) # xdave variant
@inline f30(x) = (1 - 6x^2 + 3x^4) * f32(x)

@inline f43(x) = ((1 - x^2) * (1 - 6x^2 + x^4)) / (1 + x^2)^8
@inline f42(x) = (1 - 6x^2) * f43(x)
@inline f41(x) = (1 - 10x^2 + 10x^4) * f43(x)
#@inline f40(x) = (1 - 12x^2 + 18x^4 - 4x^6) * f43(x) # differs from xdave
@inline f40(x) = (1 - 1.2 * x^2 + 18x^4 - 4x^6) * f43(x) # differs from xdave


@inline _hydrogenic_ff(s::Subshell{:s1s}, x) = f10(x)
@inline _hydrogenic_ff(s::Subshell{:s2s}, x) = f20(x)
@inline _hydrogenic_ff(s::Subshell{:s2p}, x) = f21(x)
@inline _hydrogenic_ff(s::Subshell{:s3s}, x) = f30(x)
@inline _hydrogenic_ff(s::Subshell{:s3p}, x) = f31(x)
@inline _hydrogenic_ff(s::Subshell{:s3d}, x) = f32(x)
@inline _hydrogenic_ff(s::Subshell{:s4s}, x) = f40(x)

function _pauling_sherman_ff(Z, Zb, q)

    remaining = Zb
    ff = zero(q)
    for s in AUFBAU_SHELLS
        if remaining == 0
            break
        end

        occ = min(remaining, _cap_value(s))
        remaining -= occ
        Zeff = effective_nuclear_charge(s, Z, Zb)
        x = _n_value(s) * BOHR_RADIUS_INV_ME * q / (2 * Zeff)
        ff += occ * _hydrogenic_ff(s, x)

    end
    return ff
end

struct PaulingSherman <: AbstractIonicFormFactor end

@inline function form_factor(ions::AbstractIonSystem, ::PaulingSherman, q::Real)
    return _pauling_sherman_ff(
        atomic_number(ions),
        number_bound_electrons(ions),
        q # in internal units, i.e. in m_e
    )
end
