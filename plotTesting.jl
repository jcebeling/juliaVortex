include("customTypes.jl")

using Plots

v1 = vortex(0, -0.5, 0 ,0, -1)
v2 = vortex(0, 0.5, 0, 0, 1)
v3 = vortex(1, 0.5, 0, 0, 1)
v4 = vortex(1, -0.5, 0, 0, -1)


v1x = v1.posx
v2x = v2.posx
v3x = v3.posx
v4x = v4.posx

vx = [v1x, v2x, v3x, v4x]

v1y = v1.posy
v2y = v2.posy
v3y = v3.posy
v4y = v4.posy

vy = [v1y, v2y, v3y, v4y]

plot(vx, vy)
#plot(v2x, v2y)


#plot(v1.posx, v1.posy)
#plot(v2.posx, v2.posy)
#plot(v3.posx, v3.posy)
#plot(v4.posx, v4.posy)
