struct DebyeHueckelScreening <: AbstractScreeningCloud end

_Debye_Hueckel_screening_length(n_e, temp_e) = sqrt(n_e / temp_e) * ELECTRON_CHARGE

function screening_cloud(plasma::AbstractChiharaPlasma, ::DebyeHueckelScreening, q::Real)
    kappa_e = _Debye_Hueckel_screening_length(electron_density(plasma), electron_temperature(plasma))
    ZF = ionization_state(plasma)

    return ZF * kappa_e^2 / (q^2 + kappa_e^2)
end
