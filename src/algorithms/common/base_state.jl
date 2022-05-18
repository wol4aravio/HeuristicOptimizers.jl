include("tools.jl")

Base.@kwdef mutable struct BaseState
    num::Int
    ts::Float64 = time()
    xᵇ::Vector{<:Real}
    Δˣ::Real = Inf
    yᵇ::Real
    Δʸ::Real = Inf
end

function renew_base_state!(state::BaseState, x::Union{Vector{<:Real}, Nothing}=nothing, y::Union{Real, Nothing}=nothing)
    state.num += 1
    if !(isnothing(x) || isnothing(y))
        state.Δˣ = l2_norm(state.xᵇ - x)
        state.xᵇ = x
        state.Δʸ = abs(state.yᵇ - y)
        state.yᵇ = y
    end
end
