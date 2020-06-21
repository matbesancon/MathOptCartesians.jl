module MathOptCartesians

import MathOptInterface
const MOI = MathOptInterface

"""
    ScalarCartesianSet{N, TS}

Represents the Cartesian product `S` of several scalar sets.
`S = S_1 × S_2 × S_3 ... × S_N`, such that a vector `x ∈ S ⇔ x[i] ∈ S[i] ∀ i`.
The dimension of the set is the number of elementary scalar sets.
"""
struct ScalarCartesianSet{N, TS <: NTuple{N, MOI.AbstractScalarSet}} <: MOI.AbstractVectorSet
    sets::TS
end

ScalarCartesianSet(sets...) = ScalarCartesianSet(sets)

MOI.dimension(::ScalarCartesianSet{N}) where {N} = N

# leverage bridges here?
function MOI.add_constraint(model::MOI.ModelLike, vec::MOI.VectorOfVariables, set::ScalarCartesianSet)
    cons_indices = [
        MOI.add_constraint(model, x[i], set.sets[i]) for i in eachindex(set.sets)
    ]
    # TODO index type?
end


end # module
