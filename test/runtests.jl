import MathOptCartesians
const MOC = MathOptCartesians

using Test

import MathOptInterface
const MOI = MathOptInterface

@testset "Scalar set construction" begin
    set = MOC.ScalarCartesianSet(MOI.LessThan(0.0), MOI.GreaterThan(1.3))
    @test MOI.dimension(set) == 2
end

@testset "Vector set construction and dimensions" begin
    set = MOC.VectorCartesianSet(MOI.Zeros(4), MOI.Nonnegatives(2))
    @test MOI.dimension(set) == 6
    @test set.start_indices == (1, 5)
    @test set.dims == (4, 2)
end

@testset "Cartesian dual" begin
    set = MOC.VectorCartesianSet(MOI.Zeros(4), MOI.Nonnegatives(2))
    dset = MOI.dual_set(set)
    @test MOI.dimension(dset) == MOI.dimension(set)
    @test dset.sets[1] == MOI.Reals(4)
    @test dset.sets[2] == MOI.Nonnegatives(2)
end
