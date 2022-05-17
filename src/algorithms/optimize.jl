using HeuristicOptimizers

include("abstracts.jl")
include("template.jl")


function optimize(problem::Problem, algorithm::AbstractHeuristicAlgorithm, stop_condition::Function)::BaseState
    state = init!(algorithm, problem)
    while !stop_condition(state)
        step!(algorithm, problem, state)
    end
    term!(algorithm, problem, state)
    return state
end
