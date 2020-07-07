#=
 functions for leapfroging.jl :
    indexShift!
    CalcNewV
    CalcNewPos
=#
using LinearAlgebra
#=
Name: indexShift!
Description: cycle the given array by one so that the last entry becomes the first
=#
include("customTypes.jl")

function indexShift!(vArray, s)
    i::Integer = 0
    for i in 1:s
        currentLast = pop!(vArray)
        pushfirst!(vArray, currentLast) #the last shall be first!
        #println(vArray)
    end
    return vArray
end


#=
Name: calcNewV
Description: calculates new induced vortex velocity based on relative position of another vortex
Input:
    - Rx is the x distance between the centers of the affected and acting vortexes
    - Ry is the y distance ""

function calcNewV!(Rx, Ry)
    r = [Rx; Ry; 0] #distance vector
    g = [0; 0; 1] #gamma
    crossX = cross(r, g)[1] #x component
    crossY = cross(r, g)[2] #y component
    crossZ = cross(r, g)[3] #z component
    R = length(r) #magnitude of the distance vector
    inducedVx = crossX / (2*pi*(R^2))
    inducedVy = crossY / (2*pi*(R^2))
    inducedV = [inducedVx, inducedVy]
    return inducedV
end
=#

function cNewV(vortexes, s)
    Rx = 1
    Ry = 0

    indVx = 0
    indVy = 0
    indV = []

    g = [0; 0; 1] #gamma
    i = 0
    j = 0

    for j in 1:s
        for i in 1:s
            g = [0; 0; vortexes[i].gamma]
            r = [vortexes[i].posx - vortexes[j].posx; vortexes[i].posy-vortexes[j].posy; 0]
            #println("for j = $j and i = $i, we have r = $r")
            if r == [0; 0; 0] #if r is zero then the formula will give an undefined value but in this special case the inducedV is just zero
                #println("r is zero")
            else
                rdir = (1/norm(r)) * r #distance vector
                crs = cross(rdir,g)
                indVx += crs[1] * (1/(2*pi * norm(r)))
                indVy += crs[2] * (1/(2*pi * norm(r)))
                #println("indVx is $indVx")
                #println("indVy is $indVy")
            end

        end

        #println("we have that ind Vx is $indVx and Vy is $indVy")


        #println(indVx)
        #println(indVy)

        push!(indV, [indVx; indVy])
        #last = pop!(vortexes)
        #pushfirst!(vortexes, last)
        indVx = 0
        indVy = 0
        #println(j)
        #println(indV)
    end
    #print("The new velocites are ")
    #println(indV)

    return indV
end
#=
Name: newPos!
Description: calculate new position values for the affected vortex based on the positions of the acting vortexes
Input:
    - vArray is the array of vortexes
    - s is the size of the array
Notes:
Since arrays are mutable we need to replace the affV (element 1 in the vArray) with an array object
that has the newly calculated positions and velocities
=#
function newPos!(vArray, s, tStep)
    affV = vArray[1]
    inducedV = [] #this array will be filled with arrays containing the x and y induced velocities by each vortex on the affected vortex
    newVortexArray = []
    #x::Float32 = 0
    #y::Float32 = 0
    #vx::Float32 = 0
    #vy::Float32 = 0

    i::Int = 1

    inducedV = cNewV(vArray, s)
    #println("inducedV is")
    #println(inducedV)
    #println("After calcNewV vArray is")
    #println(vArray)
    #println("gamma values are")
    #println(vArray[1].gamma)
    #println(vArray[2].gamma)
    #println(vArray[3].gamma)
    #println(vArray[4].gamma)

    for i in 1:s # or v in inducedV... for one vortex calc new pos and create replacement vortex
        x::Float32 = 0
        y::Float32 = 0
        vx::Float32 = 0
        vy::Float32 = 0

        #println("i is")
        #println(i)
        #println("in the loop vArray is")
        #println(vArray)

        x += inducedV[i][1] * tStep #double indexed array
        y += inducedV[i][2] * tStep

        #println("x and y are")
        #println(x)
        #println(y)

        vx += inducedV[i][1] # sum the velocity by component
        vy += inducedV[i][2]

        #println("vx and vy are")
        #println(vx)
        #println(vy)
        #println("gamma is")
        #println(vArray[i].gamma)

        x += vArray[i].posx # add the original x position to the distance traveled (x)
        y += vArray[i].posy

        push!(newVortexArray, vortex(x, y, vx, vy, vArray[i].gamma))
        #last = pop!(vArray)
        #pushfirst!(vArray, last)
        x = 0
        y = 0
        vx = 0
        vy = 0
    end

    #=
        Distance = rate * time... this loop uses the induced velocities and given time step to
        sum up the traveled distance from the velocity vecotors
    =#

    for i in 1:s
        popfirst!(vArray)
        push!(vArray, newVortexArray[i])
    end
    #=i = 1

    for i in newVortexArray
        #We need to replace the affected vortex with nVortex:
        popfirst!(vArray)
        pushfirst!(vArray, newVortexArray[i])
    end=#
    #println(vArray)

    return vArray
end
