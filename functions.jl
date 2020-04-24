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
function newPos!(vArray, s)
    tStep::Float16 = 0.01
    affV = vArray[1]
    actV1 = vArray[2]
    actV2 = vArray[3]
    actV3 = vArray[4]


    Rx = vortexes[4].posx - affV.posx
    Ry = vortexes[4].posy - vortexes[1].posy
    inducedFromV4 = calcNewV(Rx, Ry) #induced velocity from vortex 4
    Rx = vortexes[3].posx - vortexes[1].posx
    Ry = vortexes[3].posy - vortexes[1].posy
    inducedFromV3 = calcNewV(Rx, Ry) #induced velocity from vortex 3
    Rx = vortexes[2].posx - vortexes[1].posx
    Ry = vortexes[2].posy - vortexes[1].posy
    inducedFromV2 = calcNewV(Rx, Ry) #induced velocity from vortex 2
    totalInducedV = inducedFromV2 + inducedFromV3 + inducedFromV4

    v1[2, 1] += totalInducedV[1]
    v1[2, 2] += totalInducedV[2]

    v1[1, 1] += v1[2, 1] * tStep
    v1[1, 2] += v1[2, 2] * tStep

    #distanceTraveled = totalInducedV * tStep
    #println(distanceTraveled)

    #v1Newx = v1[1, 1] + distanceTraveled[1]
    #v1Newy = v2[1, 2] + distanceTraveled[2]
    return v1
end

#=
Name: calcNewV
Description: calculates new induced vortex velocity based on relative position of another vortex
Input:
    - Rx is the x distance between the centers of the affected and acting vortexes
    - Ry is the y distance ""
=#
function calcNewV(Rx, Ry)
    r = [Rx Ry 0] #distance vector
    g = [0, 0, 1] #gamma
    crossX = -(g[3]*r[2]) #x component
    crossY = (g[3]*r[1]) #y component
    crossZ = (g[1]*r[2])-(g[2]*r[1]) #z component
    R = sqrt((r[1])^2+(r[2])^2) #magnitude of the distance vector
    inducedVx = crossX / (2*pi*(R^2))
    inducedVy = crossY / (2*pi*(R^2))
    inducedV = [inducedVx inducedVy]
    return inducedV
end
