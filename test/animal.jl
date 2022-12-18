
using Distributions, Random


"""
equivalence classes:
+---------------+----------------------+-----------------------------------+---------+
|       .       |         Eq1          |                Eq2                |   Eq3   |
+---------------+----------------------+-----------------------------------+---------+
| AnimalSpecies | Sheep                | Wolf                              | randstr |
| Sex           | Male                 | Female                            | randstr |
| id            | integer              | non-integer number                | randstr |
| energy        | real positive number | nonpositive number                | randstr |
| Δenergy       | real positive number | nonpositive number                | randstr |
| reprprob      | float from (0, 1>    | random number out of the interval | randstr |
| foodprob      | float from (0, 1>    | random number out of the interval | randstr |
+---------------+----------------------+-----------------------------------+---------+
"""

function generate_combinations()
    eq_classes_combinations::Vector{NTuple{7, Int64}} = Random.shuffle(
        vcat(collect(Iterators.product(1:3, 1:3, 1:3, 1:3, 1:3, 1:3, 1:3))...)
    )
    eq_classes_combinations = eq_classes_combinations[
        1:Int(round(length(eq_classes_combinations)/10))
    ]
end

convertor_as = (i::Integer) -> [:Sheep, :Wolf, :asd][i]
convertor_se = (i::Integer) -> [:Male, :Female, :asd][i]
convertor_id = (i::Integer) -> [rand(DiscreteUniform(-10, 10)), randn(), randstring(10)][i]
convertor_en = (i::Integer) -> [abs(randn()), -abs(randn()), randstring(10)][i]
convertor_pr = (i::Integer) -> [abs(randn()), 2+randn()*100, randstring(10)][i]

convertor_bv = (v::NTuple{7, Int64}) -> (all(x -> x == 1, v[3:end]) && !any(x -> x == 3, v[1:2]))

function convertor(v::NTuple{7, Int64})
    d = Dict()
    d[:A] = convertor_as(v[1])
    d[:S] = convertor_se(v[2])
    d[:id] = convertor_id(v[3]) 
    d[:energy] = convertor_en(v[4]) 
    d[:Δenergy] = convertor_en(v[5])
    d[:reprprob] = convertor_pr(v[6])
    d[:foodprob] = convertor_pr(v[7])
    CreateAnimal(d)
end

@testset "animal" begin
    gc::Vector{NTuple{7, Int64}} = generate_combinations()
    for c::NTuple{7, Int64} in gc
        if convertor_bv(c)
            @test_nowarn convertor(c)
        else
            @test convertor(c) == Nothing
        end
    end
end