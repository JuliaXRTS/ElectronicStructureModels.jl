"""

    AbstractIonSystem <: AbstractPlasmaComponent

Abstract base type representing an ion component of a Chihara plasma.
"""
abstract type AbstractIonSystem <: AbstractPlasmaComponent end

"""

    atomic_number(ions::AbstractIonSystem)

Interface function: return the atomic number of a given ion system. That is the number of
protons in the nucleus of the ion: ``Z_A``.

"""
function atomic_number end

"""

    ionization_state(ions::AbstractIonSystem)

Interface function: return the ionization_state of a given ion system. That is the net
electric charge in units of the elementary charge, i.e. number of protons minus number of
bound electrons: ``Z_F = Z_A - Z_B``. This is also referred to as the number of free electrons per ion.

"""
function ionization_state end

"""

    number_bound_electrons(ions::AbstractIonSystem)

Interface function: return the number of bound electrons of a given ion system. That is the number of protons minus
the ionization state: ``Z_B = Z_A - Z_F``.

"""
function number_bound_electrons end

### Form Factor Interface

"""

    AbstractIonicFormFactor

Abstract base type for ionic form factor approximations.

"""
abstract type AbstractIonicFormFactor end

"""

    form_factor(ions::AbstractIonSystem, approx::AbstractFormFactor, q::Real)

Interface function: return the ionic form factor for a given ion system and a given form factor approximation/strategy. Detault for the latter is `PaulingShermanFormFactor()`.
"""
function form_factor end
