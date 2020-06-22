"""
    VectorCartesianSet{N, TS}

Represents the Cartesian product `S` of several vector sets.
`S = S_1 × S_2 × S_3 ... × S_N`, such that a vector `x ∈ S ⇔ x[i:i+dim(x)] ∈ S[i] ∀ i`.
The dimension of the set is the sum of the dimensions of the individual vector sets.
"""
struct VectorCartesianSet{N, TS <: NTuple{N, MOI.AbstractVectorSet}} <: MOI.AbstractVectorSet
    sets::TS
    dims::NTuple{N, Int}
    start_indices::NTuple{N, Int}
end

function VectorCartesianSet(sets...)
    dims = MOI.dimension.(sets)
    start_indices = tuple(1, dims[1:end-1]...)
    for i in 2:length(sets)
        start_indices = Base.setindex(start_indices,
            start_indices[i-1] + dims[i-1],
            i,
        )
    end
    return VectorCartesianSet(sets, dims, start_indices)
end

MOI.dimension(set::VectorCartesianSet) = sum(set.dims)

function MOI.dual_set(set::VectorCartesianSet)
    dual_sets = MOI.dual_set.(set.sets)
    return VectorCartesianSet(dual_sets...)
end

MOI.dual_set_type(set::VectorCartesianSet) = typeof(MOI.dual_set(set))
