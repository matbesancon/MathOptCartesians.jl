import MathOptCartesians
const MOC = MathOptCartesians

using Test

import MathOptInterface
const MOI = MathOptInterface

@testset "Scalar set construction" begin
    set = MOC.ScalarCartesianSet(MOI.LessThan(0.0), MOI.GreaterThan(1.3))
    @test MOI.dimension(set) == 2
end
