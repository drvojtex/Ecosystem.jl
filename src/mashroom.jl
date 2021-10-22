abstract type Mushroom <: PlantSpecies end
 
Base.show(io::IO, ::Type{Mushroom}) = print(io,"🍄")
 
eats(::Animal{Sheep}, p::Plant{Mushroom}) = size(p)>0
eats(::Animal{Wolf}, p::Plant{Mushroom}) = false
 
function eat!(a::Animal{Sheep}, p::Plant{Mushroom}, w::World)
    decr_energy!(a, size(p)*Δenergy(a))
    p.size = 0
end
 
decr_energy!(a::Animal{Sheep}, Δe) = energy!(a, energy(a)-Δe)