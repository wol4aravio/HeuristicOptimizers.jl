using HeuristicOptimizers

using Test

@testset "RandomSearch" begin
    f = (x) -> sum(x .^ 2)
    D = [[-10, -10, -10] [10, 10, 10]]
    termination = (s) -> (s.num > 100_000)
    algorithm = RandomSearch(r=1e-1)

    dummy_test_var = true
    for _ in range(1, 100)
        solution = optimize(f, D, algorithm, termination)
        dummy_test_var &=  HeuristicOptimizers.l2_norm(solution.xᵇ) <= 1e-1
    end
    @test dummy_test_var
end
