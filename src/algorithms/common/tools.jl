function push_to_domain!(x::Vector{<:Real}, domain::Matrix{<:Real})
    @assert size(x)[1] == size(domain)[1]
    for (i, (v, low, high)) in enumerate(zip(x, domain[:, 1], domain[:, 2]))
        x[i] = clamp(v, low, high)
    end
end

function push_to_domain(x::Vector{<:Real}, domain::Matrix{<:Real})
    x̃ = copy(x)
    push_to_domain!(x̃, domain)
    return x̃
end

function generate_vector_in_area(domain::Matrix{<:Real})
    ω = domain[:, 2] - domain[:, 1]
    x = domain[:, 1] + rand(size(domain)[1]) .* ω
    return x
end

function l2_norm(x::Vector{<:Real})
    return sqrt(sum(x .^ 2))
end

function generate_in_sphere(x::Vector{<:Real}, r::Real)
    normally_distributed = randn(length(x))
    normally_distributed /= l2_norm(normally_distributed)
    Δ = rand() * r * normally_distributed
    return x .+ Δ
end
