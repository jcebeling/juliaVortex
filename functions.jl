#=
 functions for leapfroging.jl :
    indexShift!
    CalcNewV
    CalcNewPos
=#

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
        println(vArray)
        i += 1
    end
    return vArray
end


#=
Name: newPos!
Description: calculate new position values for the affected vortex based on the positions of the acting vortexes
Input:
    - vArray is the array of vortexes
    - s is the size of the array
=#
function newPos!(vArray, s, tStep)
    #tStep::Float16 = 0.01
    affV = vArray[1]
    actV1 = vArray[2]
    actV2 = vArray[3]
    actV3 = vArray[4]
    inducedV = []

    i::Int = 2

    for position in vortexes
        Rx = vortexes[i].posx - affV.posx
        Ry = vortexes[i].posy - affV.posy
        posDiff = [Rx, Ry]
        push!(inducedV, calcNewV!(posDiff))
    end
#=
    Rx = vortexes[4].posx - affV.posx
    Ry = vortexes[4].posy - affV.posy
    inducedFromV4 = calcNewV(Rx, Ry) #induced velocity from vortex 4
    Rx = vortexes[3].posx - vortexes[1].posx
    Ry = vortexes[3].posy - vortexes[1].posy
    inducedFromV3 = calcNewV(Rx, Ry) #induced velocity from vortex 3
    Rx = vortexes[2].posx - vortexes[1].posx
    Ry = vortexes[2].posy - vortexes[1].posy
    inducedFromV2 = calcNewV(Rx, Ry) #induced velocity from vortex 2
    totalInducedV = inducedFromV2 + inducedFromV3 + inducedFromV4
=#
    affV.velx += totalInducedV[1]
    affV.vely += totalInducedV[2]

    affV.posx += affV.posx * tStep
    affV.posy += affV.posy * tStep
    return vArray
end

#=
Name: calcNewV
Description: calculates new induced vortex velocity based on relative position of another vortex
Input:
    - Rx is the x distance between the centers of the affected and acting vortexes
    - Ry is the y distance ""
=#
function calcNewV!(Rx, Ry)
    r = [Rx Ry 0] #distance vector
    g = [0, 0, 1] #gamma
    crossX = -(g[3]*r[2]) #x component
    crossY = (g[3]*r[1]) #y component
    crossZ = (g[1]*r[2])-(g[2]*r[1]) #z component
    R = sqrt((r[1])^2+(r[2])^2) #magnitude of the distance vector
    inducedVx = crossX / (2*pi*(R^2))
    inducedVy = crossY / (2*pi*(R^2))
    inducedV = [inducedVx, inducedVy]
    return inducedV
end
