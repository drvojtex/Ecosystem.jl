
@testset "macros" begin
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
