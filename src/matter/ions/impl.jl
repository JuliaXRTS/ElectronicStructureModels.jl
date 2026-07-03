struct IonSystem{I <: Integer, C <: Integer} <: AbstractIonSystem
    ZA::I # atomic number
    ZF::C # ionization state
    function IonSystem(ZA::A, ZF::F) where {A <: Int, F <: Int}
        ZA > 0 || throw(
            ArgumentError(
                "atomic number must be striclty positive"
            )
        )

        ZF >= 0 || throw(
            ArgumentError(
                "only non-negative ionization states are supported"
            )
        )

        return new{A, F}(ZA, ZF)
    end
end

# interface with PeriodicTables.jl
IonSystem(e::Element, ZF) = IonSystem(e.number, ZF)
element(ions::IonSystem) = getindex(elements, ions.ZA)

# ESM interface
atomic_number(ions::IonSystem) = ions.ZA
ionization_state(ions::IonSystem) = ions.ZF
number_bound_electrons(ions::IonSystem) = ions.ZA - ions.ZF
