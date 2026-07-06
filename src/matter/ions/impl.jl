struct IonSystem{T <: Real, I <: Integer, C <: Integer} <: AbstractIonSystem
    ZA::I # atomic number
    ZF::C # ionization state
    density::T
    temperature::T

    function IonSystem(
            ZA::A,
            ZF::F,
            density::T1,
            temperature::T2,
        ) where {
            T <: Real,
            T1 <: Union{T, Quantity{T}},
            T2 <: Union{T, Quantity{T}},
            A <: Int,
            F <: Int,
        }

        n_internal = _internalize_density(density)
        temp_internal = _internalize_temperature(temperature)
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

        return new{T, A, F}(ZA, ZF, n_internal, temp_internal)
    end
end

# interface with PeriodicTables.jl
IonSystem(e::Element, ZF, temp, density) = IonSystem(e.number, ZF, temp, density)
element(ions::IonSystem) = getindex(elements, ions.ZA)

# Plasma Component Interface
atomic_number(ions::IonSystem) = ions.ZA
ionization_state(ions::IonSystem) = ions.ZF
number_bound_electrons(ions::IonSystem) = ions.ZA - ions.ZF

_temperature(ions::IonSystem) = ions.temperature
_number_density(ions::IonSystem) = ions.density
