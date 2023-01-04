
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

convertor_ps = s -> Symbol(s)
convertor_int = (i::Integer) -> [rand(DiscreteUniform(-10, 10)), randn(), randstring(10)][i]

convertor_bv = (v::DataFrameRow) -> (all(x -> x == 1, v[2:end]) && v[1] != "randstr")

function convertor(v::DataFrameRow)
    d = Dict()
    d[:P] = convertor_ps(v[1])
    d[:id] = convertor_int(v[2]) 
    d[:size] = convertor_int(v[3]) 
    d[:max_size] = convertor_int(v[4])
    CreatePlant(d)
end

function plant_coverage(filename::String)
    testset_name::String = string("plant: ", filename, " coverage")
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
    @test CreatePlant(Dict(:P=>:Sheep, :id=>1, :size=>1, :max_size=>1)) == Nothing
end

plant_coverage("csv/Plant-2way.csv")
plant_coverage("csv/Plant-3way.csv")
plant_coverage("csv/Plant-mixed.csv")

@testset "grass: behaviour" begin
    grass1 = Grass(1, 3)
    world = World([grass1])
    @test_nowarn agent_step!(grass1, world)
    @test_nowarn world_step!(world)
    @test agent_count(grass1) == 1
end

@testset "grass: show" begin
    @test (@capture_out Base.show(Grass)) == "🌿"
    @test (@capture_out Base.show(Plant{Grass}(1, 1, 2))) == "🌿  #1 50% grown"
end
