# TODO: add unitful versions of these, e.g. temperature(u"eV",comp)
@inline number_density(comp::AbstractPlasmaComponent) = _number_density(comp)
@inline temperature(comp::AbstractPlasmaComponent) = _temperature(comp)
