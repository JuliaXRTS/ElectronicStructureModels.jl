module ElectronicStructureModels

hello_world() = "Hello, World!"

# matter model
export AbstractMatterModel

# Electron system
export AbstractElectronSystem
export temperature, electron_density, imag_dynamic_response, real_dynamic_response
export fermi_wave_vector,
    fermi_energy, beta, betabar, dynamic_response, dynamic_structure_factor

export AbstractProperElectronSystem
export AbstractInteractingElectronSystem
export proper_electron_system, screening

# screening
export AbstractScreening, Screening, NoScreening
export dielectric_function,
    pseudo_potential, local_field_correction, local_effective_potential
export AbstractPseudoPotential, CoulombPseudoPotential
export AbstractLocalFieldCorrection, NoLocalFieldCorrection

# concrete electron systems
export IdealElectronSystem
export AbstractResponseApproximation, NoApprox, NonDegenerated, Degenerated, ZeroTemperatureApprox
export response_approximation
export InteractingElectronSystem

# constants
export HBARC,
    HBARC_eV_ANG,
    ELECTRONMASS,
    ALPHA,
    ALPHA_SQUARE,
    ELEMENTARY_CHARGE_SQUARED,
    ELEMENTARY_CHARGE,
    HARTREE,
    BOHR_RADIUS_ANG

using QEDcore
using QuadGK
using Unitful
using LogExpFunctions
using SpecialFunctions

include("deprecated.jl")

include("utils.jl")
include("units.jl")
include("constants.jl")
include("interface.jl")
include("generic.jl")
include("lookup.jl")
include("data_driven/impl.jl")
include("matter/electrons/utils.jl")
include("matter/electrons/interface.jl")
include("matter/electrons/generic.jl")
include("matter/electrons/ideal/approximations/interface.jl")
include("matter/electrons/ideal/approximations/no_approx.jl")
include("matter/electrons/ideal/approximations/zero_temperature.jl")
include("matter/electrons/ideal/approximations/non_degenerated.jl")
include("matter/electrons/ideal/approximations/degenerated.jl")
include("matter/electrons/ideal/utils.jl")
include("matter/electrons/ideal/interface.jl")
include("matter/electrons/ideal/generic.jl")
include("matter/electrons/ideal/impl.jl")
include("matter/electrons/interacting/screening/interface.jl")
include("matter/electrons/interacting/screening/generic.jl")
include("matter/electrons/interacting/screening/impl.jl")
include("matter/electrons/interacting/interface.jl")
include("matter/electrons/interacting/generic.jl")
include("matter/electrons/interacting/impl.jl")

end
