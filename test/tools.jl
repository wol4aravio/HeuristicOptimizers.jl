using HeuristicOptimizers

using Test

@testset "Tools" begin
    domain = [[-1, -2, -3] [1, 2, 3]]
    @test HeuristicOptimizers.push_to_domain([0, 0, 0], domain) == [0, 0, 0]
    @test HeuristicOptimizers.push_to_domain([4, 4, 4], domain) == [1, 2, 3]
    @test HeuristicOptimizers.push_to_domain([-4, -4, -4], domain) == [-1, -2, -3]
    @test HeuristicOptimizers.push_to_domain([1.5, -2.5, 2.3], domain) == [1, -2, 2.3]
end
