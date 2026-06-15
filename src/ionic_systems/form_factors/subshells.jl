#abstract type AbstractSubshell end

struct Subshell{S} <: AbstractSubshell

    # consider removing this, because it is not type stable
    function Subshell(s::Symbol)
        return new{s}()
    end
end

# s1s
@inline _n_value(::Subshell{:s1s}) = 1
@inline _l_value(::Subshell{:s1s}) = 0
@inline _cap_value(::Subshell{:s1s}) = 2

# s2s
@inline _n_value(::Subshell{:s2s}) = 2
@inline _l_value(::Subshell{:s2s}) = 0
@inline _cap_value(::Subshell{:s2s}) = 2

# s2p
@inline _n_value(::Subshell{:s2p}) = 2
@inline _l_value(::Subshell{:s2p}) = 1
@inline _cap_value(::Subshell{:s2p}) = 6

# s3s
@inline _n_value(::Subshell{:s3s}) = 3
@inline _l_value(::Subshell{:s3s}) = 0
@inline _cap_value(::Subshell{:s3s}) = 2

# s3p
@inline _n_value(::Subshell{:s3p}) = 3
@inline _l_value(::Subshell{:s3p}) = 1
@inline _cap_value(::Subshell{:s3p}) = 6

# s4s
@inline _n_value(::Subshell{:s4s}) = 4
@inline _l_value(::Subshell{:s4s}) = 0
@inline _cap_value(::Subshell{:s4s}) = 2

# s3d
@inline _n_value(::Subshell{:s3d}) = 3
@inline _l_value(::Subshell{:s3d}) = 2
@inline _cap_value(::Subshell{:s3d}) = 10


# TODO: find better prints

Base.show(io::IO, ::Subshell{S}) where {S} = print(io, string(S))
function Base.show(io::IO, ::MIME"text/plain", s::Subshell)
    return print(io, "Subshell(n=$(_n_value(s)), l=$(_l_value(s)), cap=$(_cap_value(s)))")
end

# (n, l, capacity)
const AUFBAU_SHELLS2 = (
    Subshell{:s1s}(),   # 1s
    Subshell{:s2s}(),   # 2s
    Subshell{:s2p}(),   # 2p
    Subshell{:s3s}(),   # 3s
    Subshell{:s3p}(),   # 3p
    Subshell{:s4s}(),   # 4s
    Subshell{:s3d}(),  # 3d
)
