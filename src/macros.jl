function default_config(a::Type{T}) where T
    if a<:Animal return T(1, 1, 1, 1, 1) end
    if a<:Plant return T(1, 1, 1) end
end

function _add_agents(max_id, count::Int, species::Type{<:Species})
    arr::Vector{Agent{<:Species}} = [] 
    for i=max_id+1:max_id+count
        agent = default_config(Plant{species})
        agent.id = i
        append!(arr, [agent])
    end
    return arr
end

function _add_agents(max_id, count::Int, species::Type{<:Species}, sex::Type{<:Sex})
    arr::Vector{Agent{<:Species}} = []
    for i=max_id+1:max_id+count
        agent = default_config(Animal{species,sex})
        agent.id = i
        append!(arr, [agent])
    end
    return arr
end

function _ecosystem(ex::Expr)
    Base.remove_linenums!(ex)
    id_max = 0 
    world_arr = []
    for expr in ex.args
        expr = eval(expr.args)[3:end]
        tmp_sex = Nothing
        if eval(expr[2]) <: AnimalSpecies
            if length(expr) == 2 tmp_sex = Male
            else tmp_sex = eval(expr[3]) end
            append!(world_arr, _add_agents(id_max, expr[1], eval(expr[2]), tmp_sex))
        else append!(world_arr, _add_agents(id_max, expr[1], eval(expr[2]))) end
        id_max += expr[1]
    end
    return World(convert(Vector{Agent}, world_arr))
end

macro ecosystem(ex)
    return _ecosystem(ex)
end

macro add(a, b)
    return [a, b]
end
