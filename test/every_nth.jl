
@testset "every_nth: boundary values" begin
    iter = 0
    function incr_iter()
        iter += 1
    end
    @test_throws MethodError typeof(every_nth((x)->incr_iter(), "2")) <: Function
    @test_throws MethodError typeof(every_nth((x)->incr_iter(), [])) <: Function
    @test_throws MethodError typeof(every_nth((x)->incr_iter(), Nothing)) <: Function
    @test_throws MethodError typeof(every_nth((x)->incr_iter(), 1.2)) <: Function
end

@testset "every_nth: behaviour" begin
    max_i = 10
    max_j = 30
    iter = 0
    function incr_iter()
        iter += 1
    end

    for i=1:max_i
        iter = 0
        en = every_nth((x)->incr_iter(), i);
        for _=1:max_j
            en(Nothing);
        end
        @test iter == Int(floor(max_j/i))
    end
end