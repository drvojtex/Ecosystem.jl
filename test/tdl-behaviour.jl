
function create_tmp_world()
    sheep1 = Sheep(1, 1, 1, 0.8, 0.8)
    sheep2 = Sheep(2, 1, 1, 0.8, 0.8)
    wolf = Wolf(3, 1, 1, 0.8, 0.8)
    grass = Grass(4, 3)
    mushroom = Mushroom(5, 1, 2)
    return sheep1, sheep2, wolf, grass, mushroom, 
        World([sheep1, sheep2, wolf, grass, mushroom])
end

function ecosystem_behaviour_tdl_1_no_1()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    eat!(wolf, sheep2, world)
end

function ecosystem_behaviour_tdl_1_no_2()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    grow!(grass, world)
    eat!(wolf, sheep2, world)
end

function ecosystem_behaviour_tdl_1_no_3()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    eat!(sheep1, grass, world)
    grow!(grass, world)
    grow!(grass, world)
    grow!(mushroom, world)
    eat!(wolf, sheep2, world)
end

function ecosystem_behaviour_tdl_1_no_4()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    grow!(mushroom, world)
    eat!(wolf, sheep2, world)
end

function ecosystem_behaviour_tdl_1_no_5()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    eat!(sheep1, mushroom, world)
    grow!(mushroom, world)
    eat!(wolf, sheep2, world)
end

function ecosystem_behaviour_tdl_3_no_3()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    eat!(sheep1, grass, world)
    grow!(grass, world)
    grow!(mushroom, world)
    grow!(mushroom, world)
    grow!(grass, world)
    grow!(mushroom, world)
    eat!(wolf, sheep2, world)
end

function ecosystem_behaviour_tdl_3_no_4()
    sheep1, sheep2, wolf, grass, mushroom, world = create_tmp_world()
    eat!(sheep1, grass, world)
    grow!(grass, world)
    grow!(mushroom, world)
    grow!(mushroom, world)
    grow!(grass, world)
    grow!(mushroom, world)
    eat!(wolf, sheep2, world)
end

@testset "ecosystem - tdl - behaviour" begin
    @test_nowarn ecosystem_behaviour_tdl_1_no_1()
    @test_nowarn ecosystem_behaviour_tdl_1_no_2()
    @test_nowarn ecosystem_behaviour_tdl_1_no_3()
    @test_nowarn ecosystem_behaviour_tdl_1_no_4()
    @test_nowarn ecosystem_behaviour_tdl_1_no_5()

    @test_nowarn ecosystem_behaviour_tdl_3_no_3()
    @test_nowarn ecosystem_behaviour_tdl_3_no_4()
end
