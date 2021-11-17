
@testset "every_nth" begin
    max_i = 2000
    max_j = 2000
    iter = 0
    function incr_iter()
        iter += 1
    end
    for i=1:max_i
        iter = 0
        en = every_nth(x->incr_iter(), i);
        for j=1:max_j
            en(j);
        end
        @test iter == Int(floor(max_j/i))
    end
end