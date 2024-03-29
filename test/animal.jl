
using Distributions, Random
using Suppressor
using CSV, DataFrames

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

convertor_s = s -> Symbol(s)
convertor_id = (i::Integer) -> [rand(DiscreteUniform(-10, 10)), randn(), randstring(10)][i]
convertor_en = (i::Integer) -> [abs(randn()), -abs(randn()), randstring(10)][i]
convertor_pr = (i::Integer) -> [abs(randn()), 2+randn()*100, randstring(10)][i]

convertor_bv = (v::DataFrameRow) -> (all(x -> x == 1, v[3:end]) && !any(x -> x == "randstr", v[1:2]))

function convertor(v::DataFrameRow)
    d = Dict()
    d[:A] = convertor_s(v[1])
    d[:S] = convertor_s(v[2])
    d[:id] = convertor_id(v[3]) 
    d[:energy] = convertor_en(v[4]) 
    d[:Δenergy] = convertor_en(v[5])
    d[:reprprob] = convertor_pr(v[6])
    d[:foodprob] = convertor_pr(v[7])
    CreateAnimal(d)
end

function animal_coverage(filename::String)
    testset_name::String = string("animal: ", filename, " coverage")
    @testset "$testset_name" begin
        gc::DataFrame = CSV.read(filename, DataFrame; delim=',')
        for c::DataFrameRow in eachrow(gc)
            if convertor_bv(c) 
                @test_nowarn convertor(c)
            else 
                @test convertor(c) == Nothing
            end
        end
    end
end

animal_coverage("csv/Animal-2way.csv")
animal_coverage("csv/Animal-3way.csv")
animal_coverage("csv/Animal-mixed.csv")

@testset "animal: special occurences" begin
    @test CreateAnimal(Dict(:A => :Grass, :S => :Male, 
        :id => 1, :energy => 1, :Δenergy => 1, :reprprob => 0.8, :foodprob => 0.8)
    ) == Nothing
    @test CreateAnimal(Dict(:A => :Sheep, :S => :Grass, 
        :id => 1, :energy => 1, :Δenergy => 1, :reprprob => 0.8, :foodprob => 0.8)
    ) == Nothing

    sheep1 = Sheep(1, 1, 1, 0.8, 0.8)
    @test typeof(sheep1).parameters[2] ∈ [Female, Male]
    incr_energy!(sheep1, Δenergy(sheep1))
    @test [energy(sheep1), Δenergy(sheep1), reprprob(sheep1), foodprob(sheep1)
        ] == [2, 1, 0.8, 0.8]
end

@testset "animal: world interactions" begin
    sheep1 = Sheep(1, 1, 1, 0.1, 1.0)
    grass1 = Grass(2, 2, 3)
    wolf1 = Animal{Wolf, Female}(3, 1, 1, 1.0, 1.0)
    wolf2 = Animal{Wolf, Male}(4, 1, 1, 1.0, 1.0)
    world = World([sheep1, grass1, wolf1, wolf2])
    agent_step!(sheep1, world)
    agent_step!(wolf1, world)
    @test typeof(world.agents[5]) <: Animal{Wolf}
    @test size(world.agents[2]) == 0
end

@testset "animal: shows" begin
    @test (@capture_out Base.show(Sheep)) == "🐑"
    @test (@capture_out Base.show(Wolf)) == "🐺"
    @test (@capture_out Base.show(Male)) == "♂"
    @test (@capture_out Base.show(Female)) == "♀"
    @test (@capture_out Base.show(Animal{Wolf, Male}(6, 1, 1, 1.0, 1.0))) == "🐺♂ #6 E=1.0 ΔE=1.0 pr=1.0 pf=1.0"
end
