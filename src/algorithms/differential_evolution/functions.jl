function sample_without_replacement(N::Int, list::Vector{<:Real})::Vector{<:Real}
    @assert N <= length(list)
    return sort(list, by=(_ -> rand()))[1:N]
end
