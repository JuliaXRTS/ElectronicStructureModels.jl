### Delegations from IonSystem

atomic_number(plasma::AbstractChiharaPlasma) = atomic_number(ion_system(plasma))
ionization_state(plasma::AbstractChiharaPlasma) = ionization_state(ion_system(plasma))
number_bound_electrons(plasma::AbstractChiharaPlasma) = number_bound_electrons(ion_system(plasma))
element(plasma::AbstractChiharaPlasma) = element(ion_system(plasma))
