
using Ecosystem
using Test

@testset "every_nth" begin
    for dE=1:rand(1:1000)
        for e=1:rand(1:1000)
            for ms=1:rand(1:1000)
                for mm=1:rand(1:1000)
                    sheep  = Animal{Sheep, Female}(1, e, dE, 1, 1)
                    mushroom = Mushroom(2, ms, mm)
                    world = World([sheep, mushroom])
                    eat!(sheep, mushroom, world);
                    @test size(world.agents[2]) == 0
                    @test energy(world.agents[1]) == e-dE*ms
                end
            end
        end
    end
end
