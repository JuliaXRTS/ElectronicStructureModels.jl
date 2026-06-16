function _ionic_form_factor(Z, Zb, q_eV)
    remaining = Zb
    ff = zero(k)
    for s in AUFBAU_SHELLS2
        if remaining == 0
            break
        end

        occ = min(remaining, _cap_value(s))
        remaining -= occ
        Zeff = effective_nuclear_charge(s, Z, Zb)
        x = _n_value(s) * BOHR_RADIUS_INV_EV * q_eV / (2 * Zeff)
        ff += occ * _hydrogenic_ff(s, x)

    end
    return ff
end
