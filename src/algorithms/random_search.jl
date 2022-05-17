using HeuristicOptimizers

include("abstracts.jl")

mutable struct State
    x::Union{Vector{<:Real}, Nothing}
    f::Union{Real, Nothing}
end

@Base.kwdef struct RandomSearch <: AbstractHeuristicAlgorithm
    r::Real
    state::State = State(nothing, nothing)
end



function init!(algorithm::RandomSearch, problem::Problem)::BaseState 
    algorithm.state.x = generate_vector_in_area(problem.D)
    algorithm.state.f = problem(algorithm.state.x)

    return BaseState(
        num = 1,
        xᵇ = algorithm.state.x,
        yᵇ = algorithm.state.f,
    )
end

function step!(algorithm::RandomSearch, problem::Problem, state::BaseState) 
    xⁿ = generate_in_sphere(algorithm.state.x, algorithm.r)
    push_to_domain!(xⁿ, problem.D)
    fⁿ = problem(xⁿ)
    if fⁿ < algorithm.state.f
        algorithm.state.x = xⁿ
        algorithm.state.f = fⁿ
        renew_base_state!(state, xⁿ, fⁿ)
    end
    renew_base_state!(state)
end

function term!(algorithm::RandomSearch, problem::Problem, state::BaseState) end
