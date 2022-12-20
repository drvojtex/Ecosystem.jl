
using Suppressor


@testset "agent_count: world show" begin
    grass1 = Grass(1,1,5)
    grass2 = Grass(2,2,5)
    sheep1 = Animal{Sheep, Female}(3,1,1,0.5,0.9)
    sheep2 = Animal{Sheep, Male}(4,1,1,0.5,0.8)
    wolf1  = Animal{Wolf, Male}(5,2,1,0.3,0.5)
    wolf2  = Animal{Wolf, Female}(6,2,1,0.3,0.5)
    mushroom = Mushroom(7, 4, 5)
    world  = World([sheep1, sheep2, grass1, grass2, wolf1, wolf2, mushroom])

    out = """
    World{Agent}
    🐺♂ #5 E=2.0 ΔE=1.0 pr=0.3 pf=0.5
    🐑♂ #4 E=1.0 ΔE=1.0 pr=0.5 pf=0.8
    🐺♀ #6 E=2.0 ΔE=1.0 pr=0.3 pf=0.5
    🍄  #7 80% grown
    🌿  #2 40% grown
    🐑♀ #3 E=1.0 ΔE=1.0 pr=0.5 pf=0.9
    🌿  #1 20% grown
    """

    @test (replace((@capture_out Base.show(world)), " "=>"")
        == replace((@capture_out print(out)), " "=>""))
end


@testset "world simulation" begin
    grass1 = Grass(1,1,5)
    grass2 = Grass(2,2,5)
    sheep1 = Animal{Sheep, Female}(3,1,1,0.5,0.9)
    sheep2 = Animal{Sheep, Male}(4,1,1,0.5,0.8)
    wolf1  = Animal{Wolf, Male}(5,2,1,0.3,0.5)
    wolf2  = Animal{Wolf, Female}(6,2,1,0.3,0.5)
    mushroom = Mushroom(7, 4, 5)
    world  = World([sheep1, sheep2, grass1, grass2, wolf1, wolf2, mushroom])

    @test_nowarn simulate!(world, 10)
end
