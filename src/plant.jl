
function test_plant_params(id, size, max_size)
    if any(x -> !(typeof(x) <: Integer), [id, size, max_size])
        return false
    elseif !all([0 < size, 0 < max_size])
        return false
    end
    return true
end

mutable struct Plant{P<:PlantSpecies} <: Agent{P}
    id::Int
    size::Int
    max_size::Int
    Plant{P}(id, s, ms) where {P<:PlantSpecies} = 
        test_plant_params(id, s, ms) ? new(id, s, ms) : Nothing
end
 
function CreatePlant(d::Dict)
    if !isdefined(Ecosystem, d[:P])
        return Nothing
    elseif eval(d[:P])<:PlantSpecies
        return Plant{eval(d[:P])}(
            d[:id], d[:size], d[:max_size]
        )
    end
    return Nothing
end
 
Base.size(a::Plant) = a.size
max_size(a::Plant) = a.max_size
grow!(a::Plant) = a.size += 1
 
# constructor for all Plant{<:PlantSpecies} callable as PlantSpecies(...)
(A::Type{<:PlantSpecies})(id, s, m) = Plant{A}(id,s,m)
(A::Type{<:PlantSpecies})(id, m) = (A::Type{<:PlantSpecies})(id,rand(1:m),m)
 
function agent_step!(a::Plant, w::World)
    if size(a) != max_size(a)
        grow!(a)
    end
end
 
function Base.show(io::IO, p::Plant{P}) where P
    x = size(p)/max_size(p) * 100
    print(io,"$P  #$(id(p)) $(round(Int,x))% grown")
end
 
Base.show(io::IO, ::Type{Grass}) = print(io,"🌿")