
using Ecosystem
using Test

@testset "mushroom" begin
    for dE=1:rand(1:10)
        for e=1:rand(1:10)
            for mm=1:rand(1:10)
                for ms=1:rand(1:mm)
                    sheep  = Animal{Sheep, Female}(1, e, dE, 1, 1)
                    mushroom = Mushroom(2, ms, mm)
                    @test mushroom.size == ms
                    @test mushroom.max_size == mm
                    world = World([sheep, mushroom])
                    eat!(sheep, mushroom, world);
                    @test size(world.agents[2]) == 0
                    @test energy(world.agents[1]) == e-dE*ms
                end
            end
        end
    end
end
