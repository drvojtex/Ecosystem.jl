
function create_tmp_world()
    sheep1 = Animal{Sheep, Male}(1, 1, 1, 0.8, 0.8)
    sheep2 = Animal{Sheep, Female}(2, 1, 1, 0.8, 0.8)
    wolf1 = Animal{Wolf, Male}(3, 1, 1, 0.8, 0.8)
    wolf2 = Animal{Wolf, Female}(4, 1, 1, 0.8, 0.8)
    World([sheep1, sheep2, wolf1, wolf2])
end

function take_any_sheep(world)
    sheeps = filter(x -> typeof(x) <: Animal{Sheep}, collect(values(world.agents)))
    sheeps[rand(1:length(sheeps))]
end

function take_any_wolf(world)
    wolfs = filter(x -> typeof(x) <: Animal{Wolf}, collect(values(world.agents)))
    wolfs[rand(1:length(wolfs))]
end

function ecosystem_reproduction_tdl_1_no_1()
    world = create_tmp_world()
    
    reproduce!(take_any_sheep(world), world)
    reproduce!(take_any_wolf(world), world)
    reproduce!(take_any_sheep(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_1_no_2()
    world = create_tmp_world()
    
    reproduce!(take_any_sheep(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_2_no_1()
    world = create_tmp_world()

    reproduce!(take_any_wolf(world), world)
    reproduce!(take_any_sheep(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_2_no_2()
    world = create_tmp_world()

    reproduce!(take_any_sheep(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_2_no_3()
    world = create_tmp_world()

    reproduce!(take_any_wolf(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_2_no_4()
    world = create_tmp_world()

    reproduce!(take_any_sheep(world), world)
    reproduce!(take_any_wolf(world), world)
    reproduce!(take_any_sheep(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_3_no_5()
    world = create_tmp_world()

    reproduce!(take_any_wolf(world), world)
    reproduce!(take_any_sheep(world), world)
    reproduce!(take_any_wolf(world), world)
    reproduce!(take_any_sheep(world), world)
    
    agent_count(world)
end

function ecosystem_reproduction_tdl_3_no_6()
    world = create_tmp_world()

    reproduce!(take_any_sheep(world), world)
    reproduce!(take_any_wolf(world), world)
    
    agent_count(world)
end

@testset "ecosystem - tdl - reproduction" begin
    @test_nowarn ecosystem_reproduction_tdl_1_no_1()
    @test_nowarn ecosystem_reproduction_tdl_1_no_2()
    @test_nowarn ecosystem_reproduction_tdl_2_no_1()
    @test_nowarn ecosystem_reproduction_tdl_2_no_2()
    @test_nowarn ecosystem_reproduction_tdl_2_no_3()
    @test_nowarn ecosystem_reproduction_tdl_2_no_4()
    @test_nowarn ecosystem_reproduction_tdl_3_no_5()
    @test_nowarn ecosystem_reproduction_tdl_3_no_6()
end
