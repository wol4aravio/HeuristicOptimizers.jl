include("../common/abstracts.jl")
include("../common/problem.jl")
include("../common/base_state.jl")

include("functions.jl")


mutable struct State
    x::Union{Vector{Vector{<:Real}}, Nothing}
    f::Union{Vector{Real}, Nothing}
end

@Base.kwdef struct DifferentialEvolution <: AbstractHeuristicAlgorithm
    N::Int # >= 4
    F::Real # [0; 2]
    Cᵣ::Real # [0; 1]
    state::State = State(nothing, nothing)
end

function DE(N::Int, F::Real, Cᵣ::Real)
    return DifferentialEvolution(N=N, F=F, Cᵣ=Cᵣ)
end



function init!(algorithm::DifferentialEvolution, problem::Problem)::BaseState 
    algorithm.state.x = [generate_vector_in_area(problem.D) for _ in range(1, algorithm.N)]
    algorithm.state.f = [problem(_x) for _x in algorithm.state.x]
    iᵇ = argmin(algorithm.state.f)

    return BaseState(
        num=1,
        xᵇ=algorithm.state.x[iᵇ],
        yᵇ=algorithm.state.f[iᵇ],
    )
end

function step!(algorithm::DifferentialEvolution, problem::Problem, state::BaseState)
    n = size(problem.D)[1]
    for i in range(1, algorithm.N)
        indices::Vector{Int} = range(1, algorithm.N)
        deleteat!(indices, i)
        a, b, c = sample_without_replacement(3, indices)
        xᵃ = algorithm.state.x[a]
        xᵇ = algorithm.state.x[b]
        xᶜ = algorithm.state.x[c]
        R = rand(1, n)

        xⁿ::Vector{Real} = zeros(n)
        for j in range(1, n)
            rⱼ = rand()
            if rⱼ < algorithm.Cᵣ || j == R
                xⁿ[j] = xᵃ[j] + algorithm.F * (xᵇ[j] - xᶜ[j])
            else
                xⁿ[j] = algorithm.state.x[i][j]
            end
        end
        yⁿ = problem(xⁿ)
        if yⁿ ≤ algorithm.state.f[i]
            algorithm.state.x[i] = xⁿ
            algorithm.state.f[i] = yⁿ
        end
    end
    iᵇ = argmin(algorithm.state.f)
    renew_base_state!(state, algorithm.state.x[iᵇ], algorithm.state.f[iᵇ])
end

function term!(algorithm::DifferentialEvolution, problem::Problem, state::BaseState) end
