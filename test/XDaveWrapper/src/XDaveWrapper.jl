module XDaveWrapper

using PythonCall

const xdave = PythonCall.pynew()
const PS = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(xdave, pyimport("xdave"))

    # TODO: add version pass like https://github.com/JuliaPy/PythonPlot.jl/blob/746033b65637bd42fddbc09fb63ab1755db4a7a8/src/init.jl#L151
    return PythonCall.pycopy!(PS, xdave.ii_ff.PaulingShermanIonicFormFactor())
end

export xdave

#const SCALE_ME_TO_INV_METER = 2.589605168714194e12
const SCALE_ME_TO_INV_METER = 2.589605125306988e12

function me2inv_meter(x_me)
    return SCALE_ME_TO_INV_METER * x_me
end

# as function of ZA,Zb and k in inv_meter
function _xdave_form_factor(ZA, Zb, k)
    return pyconvert(Float64, PS.calculate_form_factor(ZA, Zb, k))
end

function groundtruth_form_factor(ZA, ZF, k_me)
    Zb = ZA - ZF
    k_inv_meter = me2inv_meter(k_me)
    return _xdave_form_factor(ZA, Zb, k_inv_meter)
end


end # module XDaveWrapper

# TODO: consider implementing a full wrapper
# - use this for functions: https://github.com/JuliaPy/PythonPlot.jl/blob/746033b65637bd42fddbc09fb63ab1755db4a7a8/src/PythonPlot.jl#L173
# - use wrapper types for xdave-objects: https://github.com/JuliaPy/PythonPlot.jl/blob/746033b65637bd42fddbc09fb63ab1755db4a7a8/src/PythonPlot.jl#L62
