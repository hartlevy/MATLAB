function [v3 v2] = elast(v1,m1,m2)

M=m1+m2;
dm=m1-m2;
v3=2*m1/M*v1;
v2=dm/M*v1;
