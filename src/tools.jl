function push_to_domain!(x::Vector{<:Number}, domain::Matrix{<:Number})
    @assert size(x)[1] == size(domain)[1]
    for (i, (v, low, high)) in enumerate(zip(x, domain[:, 1], domain[:, 2]))
        x[i] = clamp(v, low, high)
    end
end
