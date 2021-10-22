
using Test
using Ecosystem

@testset "agent_count" begin
    grass1 = Grass(1,1,5)
    grass2 = Grass(2,2,5)
    sheep  = Animal{Sheep, Female}(3,1,1,1,1)
    wolf   = Animal{Wolf, Male}(5,2,2,2,2)
    world  = World([sheep,grass1,grass2,wolf])

    @test agent_count(grass1) ≈ 0.2
    @test agent_count(sheep) == 1
    @test agent_count([grass2,grass1]) ≈ 0.6
    res = agent_count(world)
    tst = Dict(Animal{Wolf, Male}=>1, Plant{Grass}=>0.6, Animal{Sheep, Female}=>1)
    for (k,_) in res
        @test res[k] ≈ tst[k]
    end
end