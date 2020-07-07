#=
 functions for leapfroging.jl :
    CalcNewV
    CalcNewPos
=#
using LinearAlgebra


#=
Name: cNewV
Description: calculates new induced vortex velocity based on relative position of another vortex
for each vortex in a given array.
Input:
    - Vortexes - array of vortex objects
    - s - size of array
Output: Returns array of induced x and y velocities
=#
function cNewV(vortexes, s)

    indVx = 0 #initializing induced velocity for x direction
    indVy = 0 #initializing induced velocity for y direction
    indV = [] #initializing array of induced x and y velocities

    g = [0; 0; 1] #gamma as defined in the problem statement
    i = 0 #initializing counter
    j = 0 #initializing counter

    for j in 1:s #for each vortex in the array
        for i in 1:s #compare to each other vortex in the array and calculate
            g = [0; 0; vortexes[i].gamma]
            r = [vortexes[i].posx - vortexes[j].posx; vortexes[i].posy-vortexes[j].posy; 0]

            if r == [0; 0; 0] #if r is zero then the formula will give an undefined value where it should just yield zero
                #do nothing
            else #use formula from the problem statement to calculate the induced velocity
                rdir = (1/norm(r)) * r #distance vector's direction
                crs = cross(rdir,g) #cross product
                indVx += crs[1] * (1/(2*pi * norm(r))) #x induced velocity
                indVy += crs[2] * (1/(2*pi * norm(r))) #y induced velocity
            end
        end

        push!(indV, [indVx; indVy]) #record induced V

        #reset variables
        indVx = 0
        indVy = 0
    end
    return indV
end




#=
Name: newPos!
Description: calculate new position values for the affected vortex based on the positions of the acting vortexes
Input:
    - vArray is the array of vortexes
    - s is the size of the array
    - tStep is the amount of time through which the calculation should occur
=#
function newPos!(vArray, s, tStep)
    inducedV = [] #filled with arrays containing the x and y induced velocities
    newVortexArray = [] #to replace existing vortex array...

    i::Int = 1 #initializing

    inducedV = cNewV(vArray, s) #see inducedV function for more info

    for i in 1:s # or v in inducedV... for one vortex calc new pos and create replacement vortex
        #initializing
        x::Float32 = 0
        y::Float32 = 0
        vx::Float32 = 0
        vy::Float32 = 0


        x += inducedV[i][1] * tStep #distance traveled = rate * time
        y += inducedV[i][2] * tStep


        vx += inducedV[i][1] # sum the velocity by component
        vy += inducedV[i][2]


        x += vArray[i].posx # add the current x position to the distance traveled (x)
        y += vArray[i].posy

        push!(newVortexArray, vortex(x, y, vx, vy, vArray[i].gamma)) #record new vortex vector
    end

    for i in 1:s #replaces old vortexes with new vortexes
        popfirst!(vArray)
        push!(vArray, newVortexArray[i])
    end
    return vArray
end
