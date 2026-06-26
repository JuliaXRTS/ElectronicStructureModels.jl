"""

    AbstractPlasma

Abstract base type representing a plasma, e.g. a system with electrons and ions.

"""
abstract type AbstractPlasma <: AbstractMatterModel end

"""

    AbstractChiharaPlasma

Abstract base type representing a plasma described by the Chihara model.

"""
abstract type AbstractChiharaPlasma <: AbstractPlasma end

"""

    electron_system(plasma::AbstractChiharaPlasma)::AbstractElectronSystem

Interface function: return the electron system of a given Chihara plasma.
"""
function electron_system end

"""

    ion_system(plasma::AbstractChiharaPlasma)::AbstractIonSystem

Interface function: return the ion system of a given Chihara plasma.
"""
function ion_system end

"""

    electron_temperature(plasma::AbstractChiharaPlasma)

Interface function: return the electron temperature of a given Chihara Plasma.
"""
function electron_temperature end

"""

    electron_density(plasma::AbstractChiharaPlasma)

Interface function: return the electron number density of a given Chihara Plasma.
"""
function electron_density end

"""

    ion_temperature(plasma::AbstractChiharaPlasma)

Interface function: return the ion temperature of a given Chihara Plasma.
"""
function ion_temperature end

"""

    ion_density(plasma::AbstractChiharaPlasma)

Interface function: return the ion number density of a given Chihara Plasma.
"""
function ion_density end
