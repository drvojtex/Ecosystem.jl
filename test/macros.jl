
@testset "macros: behaviour" begin
    macro_world = @ecosystem begin
        @add 11 Sheep Female
        @add 22 Sheep Male 
        @add 33 Grass      
        @add 44 Wolf
        @add 44 Wolf Male
        @add 1 Wolf Female       
        @add 55 Mushroom
    end
    @test agent_count(macro_world) == Dict{Any, Any}(
        Animal{Wolf, Male} => 88,
        Animal{Wolf, Female} => 1,
        Animal{Sheep, Female} => 11, 
        Plant{Grass} => 33.0, 
        Plant{Mushroom} => 55.0, 
        Animal{Sheep, Male} => 22
    )
end

macro test_macro_throws(err_type, ex)
    return quote
        @test_throws(
            $(esc(err_type)),
            try
                @eval $(esc(ex))
            catch err
                @show err
                throw(err.error)
            end
        )
    end
end

@testset "macros: error input count" begin
    @test_macro_throws MethodError (@ecosystem begin @add "1" Grass end)
    @test_macro_throws MethodError (@ecosystem begin @add "1" Sheep end)    
    @test_macro_throws MethodError (@ecosystem begin @add "1" Sheep Female end)
    @test_macro_throws MethodError (@ecosystem begin @add "1" Wolf Male end)
    @test_macro_throws MethodError (@ecosystem begin @add "1" Mushroom end)
end
