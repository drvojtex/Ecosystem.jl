
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

@testset "mushroom: behaviour" begin
    sheep = Sheep(1, 5, 1, 1, 1)
    mushroom = Mushroom(2, 1, 2)
    world = World([sheep, mushroom])
    agent_step!(sheep, world)
    @test size(mushroom) == 0 && energy(sheep) == 3

    wolf = Wolf(1, 5, 1, 1, 1)
    mushroom = Mushroom(2, 1, 2)
    world = World([wolf, mushroom])
    agent_step!(wolf, world)
    @test size(mushroom) == 1 && energy(wolf) == 4
end

@testset "mushroom: show" begin
    @test (@capture_out Base.show(Mushroom)) == "🍄"
    @test (@capture_out Base.show(Plant{Mushroom}(1, 1, 2))) == "🍄  #1 50% grown"
end
