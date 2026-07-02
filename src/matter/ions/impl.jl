struct IonSystem{I <: Integer, C <: Integer} <: AbstractIonSystem
    ZA::I # atomic number
    ZF::C # ionization state
end

# interface with PeriodicTables.jl
IonSystem(e::Element, ZF) = IonSystem(e.number, ZF)
element(ions::IonSystem) = getindex(elements, ions.ZA)

# ESM interface
atomic_number(ions::IonSystem) = ions.ZA
ionization_state(ions::IonSystem) = ions.ZF
number_bound_electrons(ions::IonSystem) = ions.ZA - ions.ZF
