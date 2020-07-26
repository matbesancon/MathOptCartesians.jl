# MathOptCartesians

[![Build Status](https://travis-ci.com/matbesancon/MathOptCartesians.jl.svg?branch=master)](https://travis-ci.com/matbesancon/MathOptCartesians.jl)
[![Codecov](https://codecov.io/gh/matbesancon/MathOptCartesians.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/matbesancon/MathOptCartesians.jl)

This companion package for [MathOptInterface.jl](https://github.com/jump-dev/MathOptInterface.jl)
defines sets based on Cartesian products.
If `S = S_1 × S_2 × ... S_n`, with `S_i` being scalar sets, then
`(x_1, x_2, ... x_n) ∈ S ⇔  x_1 ∈ S_1, x_2 ∈ S_2 ... x_n ∈ S_n`.  

The dual of a Cartesian product of convex cones is the Cartesian product of the duals of each cone.
Being able to "stack" sets in such way can be useful to formulate optimization problem in the form:

```
min_x F(x)
s.t.
A x = b
x ∈ S
```

where `S` needs to be passed as a single cone.