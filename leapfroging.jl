#=
Initialize positions and velocities of each vortex
d = 1 #user input distance between vortecies

for the future
make the vortecies into an array to be able to cycle through them
=#
include("functions.jl")

struct vortex # new vortex type
    posx::Real
    posy::Real
    velx::Real
    vely::Real
end

d = 1 # x separation
h14 = -(d / 2) # y coordinate for vortexes 1 and 4
h23 = d / 2 # y coordinate for vortexes 2 and 3
s::Integer = 4 #size of vArray... for general use need to use size() to get the size
tStep::Float16 = 0.00


#creating four vortex objects (x pos, y pos, x velocity, y velocity)
v1 = vortex(0, h14, 0 ,1)
v2 = vortex(0, h23, 0, 2)
v3 = vortex(d, h23, 0, 3)
v4 = vortex(d, h14, 0, 4)

vortexes = [v1, v2, v3, v4] #creating array of vortex objects

while 
