
using Distributions, Random


"""
equivalence classes:
+--------------------+----------------------+-----------------------------------+---------+
|       .            |         Eq1          |                Eq2                |   Eq3   |
+--------------------+----------------------+-----------------------------------+---------+
| PlantSpecies       | Grass                | Mushroom                          | randstr |
| id, size, max_size | Integer              | non-integer number                | randstr |
+---------------+---------------------------+-----------------------------------+---------+
"""

function generate_combinations()
    eq_classes_combinations::Vector{NTuple{4, Int64}} = Random.shuffle(
        vcat(collect(Iterators.product(1:3, 1:3, 1:3, 1:3))...)
    )
    eq_classes_combinations = eq_classes_combinations[
        1:Int(round(length(eq_classes_combinations)/10))
    ]
end

convertor_ps = (i::Integer) -> [:Grass, :Mushroom, :asd][i]
convertor_int = (i::Integer) -> [rand(DiscreteUniform(-10, 10)), randn(), randstring(10)][i]

convertor_bv = (v::NTuple{4, Int64}) -> (all(x -> x == 1, v[2:end]) && v[1] != 3)

function convertor(v::NTuple{4, Int64})
    d = Dict()
    d[:P] = convertor_ps(v[1])
    d[:id] = convertor_int(v[2]) 
    d[:size] = convertor_int(v[3]) 
    d[:max_size] = convertor_int(v[4])
    CreatePlant(d)
end

@testset "plant: boundaries" begin
    gc::Vector{NTuple{4, Int64}} = generate_combinations()
    for c::NTuple{4, Int64} in gc
        if convertor_bv(c)
            @test_nowarn convertor(c)
        else
            @test convertor(c) == Nothing
        end
    end
    @test CreatePlant(Dict(:P=>:Sheep, :id=>1, :size=>1, :max_size=>1)) == Nothing
end

@testset "grass: behaviour" begin
    grass1 = Grass(1, 2)
    world = World([grass1])
    world_step!(world)
    @test agent_count(grass1) == 1
end

@testset "grass: show" begin
    @test (@capture_out Base.show(Grass)) == "🌿"
    @test (@capture_out Base.show(Plant{Grass}(1, 1, 2))) == "🌿  #1 50% grown"
end
