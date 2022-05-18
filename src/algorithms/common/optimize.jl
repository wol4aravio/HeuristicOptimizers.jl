include("abstracts.jl")


function optimize(f::Function, D::Matrix{<:Real}, algorithm::AbstractHeuristicAlgorithm, stop_condition::Function)::BaseState
    problem = Problem(_f=f, D=D)
    state = init!(algorithm, problem)
    while !stop_condition(state)
        step!(algorithm, problem, state)
    end
    term!(algorithm, problem, state)
    return state
end
