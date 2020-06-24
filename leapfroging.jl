#=
Initialize positions and velocities of each vortex
d = 1 #user input distance between vortecies

for the future
make the vortecies into an array to be able to cycle through them
=#
include("functions.jl")
include("customTypes.jl")

using LinearAlgebra
using Plots

d = 1 # x separation
h14 = -(d / 2) # y coordinate for vortexes 1 and 4
h23 = d / 2 # y coordinate for vortexes 2 and 3
sInteger = 4 #size of vArray... for general use need to use size() to get the size
tStep = 0.01
cTime = 0.0

finalTime = 1


#creating four vortex objects (x pos, y pos, x velocity, y velocity, gamma value)
v1 = vortex(0, h14, 0 ,0, -1)
v2 = vortex(0, h23, 0, 0, 1)
v3 = vortex(d, h23, 0, 0, 1)
v4 = vortex(d, h14, 0, 0, -1)

v1pxDeltaT = []
v2pxDeltaT = []
v3pxDeltaT = []
v4pxDeltaT = []

v1pyDeltaT = []
v2pyDeltaT = []
v3pyDeltaT = []
v4pyDeltaT = []



vortexes = [v1, v2, v3, v4] #creating array of vortex objects
#I cannot change any one vortex until I have calculated the changes in the other vortexes

while cTime < tStep * 4000 #

    if vortexes[1].posx != vortexes[2].posx
        println("ERROR: MISMATCHED v1 and v2!!!!")
        diff = vortexes[1].posx - vortexes[2].posx
        println("Difference is $diff")
        println("------- at cTime = $cTime --------")

        cTime = tStep * 4001

        #vortexes[2].posx = vortexes[1].posx
    end

    if vortexes[3].posx != vortexes[4].posx

        println("ERROR: MISMATCHED v3 and v4!!!!")
        diff = vortexes[4].posx - vortexes[3].posx
        println("Difference is $diff")
        println("------- at cTime = $cTime --------")

        cTime = tStep * 4001

        #vortexes[4].posx = vortexes[3].posx
    end

    push!(v1pxDeltaT, vortexes[1].posx)
    push!(v1pyDeltaT, vortexes[1].posy)
    push!(v2pxDeltaT, vortexes[2].posx)
    push!(v2pyDeltaT, vortexes[2].posy)
    push!(v3pxDeltaT, vortexes[3].posx)
    push!(v3pyDeltaT, vortexes[3].posy)
    push!(v4pxDeltaT, vortexes[4].posx)
    push!(v4pyDeltaT, vortexes[4].posy)

    println(cTime)
    println(vortexes)
    newPos!(vortexes, sInteger, tStep) #takes the first vortex in the array and calculates new position and velocity
    global cTime += tStep
    #println(vortexes)
end

plot(v1pxDeltaT, v1pyDeltaT)
plot!(v2pxDeltaT, v2pyDeltaT)
plot!(v3pxDeltaT, v3pyDeltaT)
plot!(v4pxDeltaT, v4pyDeltaT)
