
function ecosystem_define_tdl_1_no_1()
    macro_world = @ecosystem begin
        @add 1 Mushroom
        @add 1 Wolf Female
        @add 1 Grass
        @add 1 Sheep Female
        @add 1 Wolf Male
        @add 1 Mushroom
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_1_no_2()
    macro_world = @ecosystem begin
        @add 1 Wolf Female
        @add 1 Wolf Female
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_1_no_3()
    macro_world = @ecosystem begin
        @add 1 Sheep Male
        @add 1 Wolf Female
        @add 1 Mushroom
        @add 1 Wolf Male
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_1_no_4()
    macro_world = @ecosystem begin
        @add 1 Grass
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_2_no_1()
    macro_world = @ecosystem begin
        @add 1 Mushroom
        @add 1 Wolf Male
        @add 1 Wolf Female
        @add 1 Wolf Male
        @add 1 Mushroom
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_2_no_2()
    macro_world = @ecosystem begin
        @add 1 Grass
        @add 1 Wolf Male
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_2_no_3()
    macro_world = @ecosystem begin
        @add 1 Sheep Male
        @add 1 Grass
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_2_no_4()
    macro_world = @ecosystem begin
        @add 1 Wolf Female
        @add 1 Grass
        @add 1 Sheep Female
        @add 1 Mushroom
        @add 1 Sheep Female
        @add 1 Sheep Male
        @add 1 Sheep Female
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_2_no_5()
    macro_world = @ecosystem begin
        @add 1 Wolf Female
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_2_no_6()
    macro_world = @ecosystem begin
        @add 1 Sheep Male
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_1()
    macro_world = @ecosystem begin
        @add 1 Mushroom
        @add 1 Wolf Male
        @add 1 Wolf Male 
        @add 1 Mushroom
        @add 1 Sheep Female
        @add 1 Wolf Male
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_2()
    macro_world = @ecosystem begin
        @add 1 Mushroom
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_3()
    macro_world = @ecosystem begin
        @add 1 Grass
        @add 1 Wolf Male
        @add 1 Sheep Female 
        @add 1 Mushroom
        @add 1 Wolf Female
        @add 1 Wolf Female
        @add 1 Mushroom
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_4()
    macro_world = @ecosystem begin
        @add 1 Grass
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_5()
    macro_world = @ecosystem begin
        @add 1 Sheep Male
        @add 1 Mushroom
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_6()
    macro_world = @ecosystem begin
        @add 1 Sheep Female
        @add 1 Grass
    end
    agent_count(macro_world)
end

function ecosystem_define_tdl_3_no_7()
    macro_world = @ecosystem begin
        @add 1 Sheep Female
        @add 1 Grass
        @add 1 Sheep Male
        @add 1 Grass 
        @add 1 Wolf Female
    end
    agent_count(macro_world)
end

@testset "ecosystem - tdl - define" begin
    @test_nowarn ecosystem_define_tdl_1_no_1()
    @test_nowarn ecosystem_define_tdl_1_no_2()
    @test_nowarn ecosystem_define_tdl_1_no_3()
    @test_nowarn ecosystem_define_tdl_1_no_4()

    @test_nowarn ecosystem_define_tdl_2_no_1()
    @test_nowarn ecosystem_define_tdl_2_no_2()
    @test_nowarn ecosystem_define_tdl_2_no_3()
    @test_nowarn ecosystem_define_tdl_2_no_4()
    @test_nowarn ecosystem_define_tdl_2_no_5()
    @test_nowarn ecosystem_define_tdl_2_no_6()

    @test_nowarn ecosystem_define_tdl_3_no_1()
    @test_nowarn ecosystem_define_tdl_3_no_2()
    @test_nowarn ecosystem_define_tdl_3_no_3()
    @test_nowarn ecosystem_define_tdl_3_no_4()
    @test_nowarn ecosystem_define_tdl_3_no_5()
    @test_nowarn ecosystem_define_tdl_3_no_6()
end
