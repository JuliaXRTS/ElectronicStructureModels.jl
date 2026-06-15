struct ScreeningTable{N}
    zb_min::Int
    values::NTuple{N, Float64}
end
Base.length(::ScreeningTable{N}) where {N} = N

const C1S = ScreeningTable(1, (0.19,))
const C2S = ScreeningTable(2, (1.25, 1.51, 1.78, 2.04, 2.31, 2.57, 2.84, 3.1))
const C2P = ScreeningTable(4, Tuple([2.5, 2.91, 3.33, 3.74, 4.16, fill(4.57, ZA - 9)...]))
const C3S = ScreeningTable(10, (6.6, 6.96, 7.31, 7.67, 8.03, 8.387, 8.744, 9.1, 9.1, 9.1, 9.28, 9.46, 9.64, 9.82, 10.0, 10.18, 10.36, 10.54, 10.72))
const C3P = ScreeningTable(
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

const C4S = ScreeningTable(
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
const C3D = ScreeningTable(20, (1.47e1, 1.503e1, 1.536e1, 1.569e1, 1.603e1, 1.636e1, 1.67e1, 1.703e1, 1.737e1))

@inline function lookup(t::ScreeningTable, ZA::Int, Zb::Int)
    Base.@boundscheck begin
        Zb < t.zb_min && return 0.0
        Zb > ZA       && return 0.0
    end

    idx = min(Zb - t.zb_min, length(t.values))
    @inbounds return t.values[idx]
end

@inline lookup(::Subshell2{:s1s}, ZA::Int, Zb::Int) = lookup(C1S, ZA, Zb)
@inline lookup(::Subshell2{:s2s}, ZA::Int, Zb::Int) = lookup(C2S, ZA, Zb)
@inline lookup(::Subshell2{:s2p}, ZA::Int, Zb::Int) = lookup(C2P, ZA, Zb)
@inline lookup(::Subshell2{:s3s}, ZA::Int, Zb::Int) = lookup(C3S, ZA, Zb)
@inline lookup(::Subshell2{:s3p}, ZA::Int, Zb::Int) = lookup(C3P, ZA, Zb)
@inline lookup(::Subshell2{:s4s}, ZA::Int, Zb::Int) = lookup(C4S, ZA, Zb)
@inline lookup(::Subshell2{:s3d}, ZA::Int, Zb::Int) = lookup(C3D, ZA, Zb)
