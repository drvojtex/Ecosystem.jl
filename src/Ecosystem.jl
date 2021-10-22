module Ecosystem


using StatsBase
 

export World
export Species, PlantSpecies, AnimalSpecies, Grass, Sheep, Wolf, Mushroom
export Sex, Female, Male
export Agent, Plant, Animal
export agent_step!, eat!, eats, find_food, reproduce!, world_step!
export energy, energy!, incr_energy!, Δenergy, reprprob, foodprob, decr_energy!
export every_nth, agent_count, simulate!


##################################################################
# ECOSYSTEMCORE
abstract type Species end
abstract type Agent{S<:Species} end
 
abstract type PlantSpecies <: Species end
abstract type Grass <: PlantSpecies end
 
abstract type AnimalSpecies <: Species end
abstract type Sheep <: AnimalSpecies end
abstract type Wolf <: AnimalSpecies end
 
abstract type Sex end
abstract type Male <: Sex end
abstract type Female <: Sex end
 
id(a::Agent) = a.id

include("world.jl")
include("plant.jl")
include("animal.jl")
include("mashroom.jl")

##################################################################


##################################################################
#COUNTING section
function agent_count(p::Plant)
    return size(p)/max_size(p)
end
agent_count(::Animal) = 1
function agent_count(v::Vector{<:Agent})
    return sum(map(x->agent_count(x), v))
end
function agent_count(w::World)
    d = Dict()
    agents_names = map(x->typeof(x), values(w.agents))
    for name in unique(agents_names)
        d[name] = sum(
            map(
                x->agent_count(w.agents[x]), 
                findall(x->typeof(x)==name, w.agents)
            )
        )
    end
    return d
end
##################################################################
 
 
##################################################################
# every_nth
function every_nth(f::Function, n::Int)
    iter = 0
    function task(x)
        iter += 1
        if iter%n == 0 f(x) end
    end
    return task
end
##################################################################


##################################################################
# SIMULATE
function simulate!(w::World, iters::Int, cb=()->())
    for _ in 1:iters
        world_step!(w)
        cb()
    end
end
##################################################################


end # module
