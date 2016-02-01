function [x,y,wout]=stepgear(r1,r2,thet,w)
%Input: two gear radii, angle between them, angular speed of first gear
%Output: relative x and y of gear centers, angular speed of second gear
x=(r1+r2)*cos(thet); 
y=(r1+r2)*sin(thet);
wout=-r1/r2*w;