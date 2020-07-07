#=
Initialize positions and velocities of each vortex
d = 1 #user input distance between vortecies?
=#
include("functions.jl")
include("customTypes.jl")

using LinearAlgebra
using Plots

d = 1 # separation
h14 = -(d / 2) # y coordinate for vortexes 1 and 4
h23 = d / 2 # y coordinate for vortexes 2 and 3
sInteger = 4 #size of vArray... for general use need to use size() to get the size
tStep = 0.01 #time interval between calculations
cTime = 0.0 #current time

numOfTSteps = 4000 #number of time steps to calculate


#creating four vortex objects (x pos, y pos, x velocity, y velocity, gamma value)
v1 = vortex(0, h14, 0 ,0, -1)
v2 = vortex(0, h23, 0, 0, 1)
v3 = vortex(d, h23, 0, 0, 1)
v4 = vortex(d, h14, 0, 0, -1)

vortexes = [v1, v2, v3, v4] #creating array of vortex objects

#creating four pairs of (x,y) arrays for position to be recorded each time step
v1pxDeltaT = []
v1pyDeltaT = []

v2pxDeltaT = []
v2pyDeltaT = []

v3pxDeltaT = []
v3pyDeltaT = []

v4pxDeltaT = []
v4pyDeltaT = []



while cTime < tStep * 4000 #This is the main loop of the code...

    if vortexes[1].posx != vortexes[2].posx #Useful for debugging
        println("ERROR: MISMATCHED v1 and v2!!!!")
        diff = vortexes[1].posx - vortexes[2].posx
        println("Difference is $diff")
        println("------- at cTime = $cTime --------")

        cTime = tStep * (numOfTSteps + 1)
    end

    #recording x and y position for each vortex at cTime
    push!(v1pxDeltaT, vortexes[1].posx)
    push!(v1pyDeltaT, vortexes[1].posy)

    push!(v2pxDeltaT, vortexes[2].posx)
    push!(v2pyDeltaT, vortexes[2].posy)

    push!(v3pxDeltaT, vortexes[3].posx)
    push!(v3pyDeltaT, vortexes[3].posy)

    push!(v4pxDeltaT, vortexes[4].posx)
    push!(v4pyDeltaT, vortexes[4].posy)

    println(cTime) #to keep track of cTime
    newPos!(vortexes, sInteger, tStep) #calculates new position and velocity of each vortex
    global cTime += tStep
end

#Plots recorded positions
plot(v1pxDeltaT, v1pyDeltaT, c="Blue", label = "Vortex 1")
plot!(v2pxDeltaT, v2pyDeltaT, c="Blue", label = "")
plot!(v3pxDeltaT, v3pyDeltaT, c="Purple", label = "Vortex 2")
plot!(v4pxDeltaT, v4pyDeltaT, c="Purple", label = "")

title!("Path")
xlabel!("X Coordinate")
ylabel!("Y Coordinate")
ylims!(-2, 2)
