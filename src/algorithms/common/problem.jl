Base.@kwdef mutable struct Problem
    _f::Function
    D::Matrix{<:Real}
    f_calls::Int = 0
end

function (p::Problem)(x::Vector{<:Real})
    p.f_calls += 1
    return p._f(x)
end
