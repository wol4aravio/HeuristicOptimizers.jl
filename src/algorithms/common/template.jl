include("abstracts.jl")

function init!(algorithm::AbstractHeuristicAlgorithm, problem::Problem)::BaseState end
function step!(algorithm::AbstractHeuristicAlgorithm, problem::Problem, state::BaseState) end
function term!(algorithm::AbstractHeuristicAlgorithm, problem::Problem, state::BaseState) end
