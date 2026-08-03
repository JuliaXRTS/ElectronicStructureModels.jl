struct OneComponentPlasma{E, I} <: AbstractChiharaPlasma
    elec_system::E
    ion_system::I
end

@inline electron_system(plasma::OneComponentPlasma) = plasma.elec_system
@inline electron_temperature(plasma::OneComponentPlasma) = temperature(plasma.elec_system)
@inline electron_density(plasma::OneComponentPlasma) = number_density(plasma.elec_system)
@inline ion_system(plasma::OneComponentPlasma) = plasma.ion_system
@inline ion_temperature(plasma::OneComponentPlasma) = temperature(plasma.ion_system)
@inline ion_density(plasma::OneComponentPlasma) = number_density(plasma.ion_system)
