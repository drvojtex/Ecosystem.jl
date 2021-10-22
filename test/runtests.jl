
using Test
using Ecosystem

@testset "agent_count" begin
    grass1 = Grass(1,1,5)
    grass2 = Grass(2,2,5)
    sheep1  = Animal{Sheep, Female}(3,1,1,1,1)
    sheep2  = Animal{Sheep, Male}(4,1,1,1,1)
    wolf1   = Animal{Wolf, Male}(5,2,2,2,2)
    wolf2   = Animal{Wolf, Female}(6,2,2,2,2)
    mushroom = Mushroom(7, 4, 5)
    world  = World([sheep1, sheep2, grass1, grass2, wolf1, wolf2, mushroom])

    @test agent_count(grass1) ≈ 0.2
    @test agent_count(sheep1) == 1
    @test agent_count(mushroom) == 0.8
    @test agent_count([grass2,grass1]) ≈ 0.6
    res = agent_count(world)
    tst = Dict(Animal{Wolf, Male}=>1, 
               Animal{Wolf, Female}=>1, 
               Animal{Sheep, Male}=>1,
               Animal{Sheep, Female}=>1,
               Plant{Grass}=>0.6,
               Plant{Mushroom}=>0.8)
    for (k,_) in res
        @test res[k] ≈ tst[k]
    end
end

# every_nth tests
include("every_nth.jl")
