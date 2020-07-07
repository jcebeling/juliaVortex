"""
navigating vortexes:
v1 = vortexes[1,1] through vortexes[2,2]
v2 = vortexes[3,3] through [4,4]
v3 = vortexes[5,5] through [6,6]
v4 = vortexes[7,7] through [8,8]

"""

"""
function newPos!(v1)
    #V4 = v4
    #V2 = v2
    #V3 = v3
    #tS = tStep
    Rx = v4[1, 1] - v1[1, 1]
    Ry = v4[1, 2] - v1[1, 2]
    inducedFromV4 = calcNewV(Rx, Ry) #induced velocity from vortex 4
    Rx = v3[1, 1] - v1[1, 1]
    Ry = v3[1, 2] - v1[1, 2]
    inducedFromV3 = calcNewV(Rx, Ry) #induced velocity from vortex 3
    Rx = v2[1, 1] - v1[1, 1]
    Ry = v2[1, 2] - v1[1, 2]
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
"""
