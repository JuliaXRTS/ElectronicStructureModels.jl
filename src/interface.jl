"""
    AbstractMatterModel

Abstract base type representing a generic matter model.
"""
abstract type AbstractMatterModel end

"""

    AbstractPlasmaComponent

Abstract base type representing components of a plasma described by the Chihara model.

"""
abstract type AbstractPlasmaComponent end

"""

    _temperature(comp::AbstractPlasmaComponent)

Interface function: return the temperature parameter of the plasma component.

"""
function _temperature end

"""

    _number_density(comp::AbstractPlasmaComponent)

Interface function: return the number density parameter of the plasma component.

"""
function _number_density end
