include("functions.jl")
include("customTypes.jl")

using LinearAlgebra

tStep = 0.01

#creating four vortex objects (x pos, y pos, x velocity, y velocity)
v1 = vortex(0, -0.5, 0, 0, -1)
v2 = vortex(0, 0.5, 0, 0, 1)
v3 = vortex(1, 0.5, 0, 0, 1)
v4 = vortex(1, -0.5, 0, 0, -1)

vtxs = [v1, v2, v3, v4] #creating array of vortex objects


function cNewV(vortexes)
    Rx = 1
    Ry = 0

    indVx = 0
    indVy = 0
    indV = []

    println(vortexes, s)

    g = [0; 0; 1] #gamma
    i = 1
    j = 1
    for j in 1:s
        for i in 2:s
            g = [0; 0; vortexes[i].gamma]
            r = [vortexes[i].posx - vortexes[1].posx; vortexes[i].posy-vortexes[1].posy; 0]
            #print(r)
            rdir = (1/norm(r)) * r #distance vector
            crs = cross(rdir,g)
            indVx += crs[1] * (1/(2*pi * norm(r)))
            indVy += crs[2] * (1/(2*pi * norm(r)))
        end

        push!(indV, [indVx; indVy])
        last = pop!(vortexes)
        pushfirst!(vortexes, last)
        indVx = 0
        indVy = 0
        #println(j)
        #println(indV)
    end
    println(vortexes)
    return indV
end

#println(tStep)


inducedV = cNewV(vtxs, 4)
println(inducedV)

#crossX = cross(g, r)[1] #x component
#crossY = cross(g, r)[2] #y component
#crossZ = cross(g, r)[3] #z component
#newPos!(vortexes, 4, tStep) #takes the first vortex in the array and calculates new position and velocity

#println(vortexes)
