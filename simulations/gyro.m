function [perp1,center,wt,wp,L] =gyro(M,w,r,t)
close all
h=1;                %height
g=0.004;            %gravity
thet=0;             %initial theta
phi=0*ones(1,t);    %main axis angle, over time

I=M*r^2/2;  %moment of inertia
Ix=M*r^2/4+M*h^2;
ang=0:2*pi/80:2*pi; %angle range

figure
axis square
box on
view(30,20)
xlim(2*[-r r])
ylim(2*[-r r])
zlim([-2*r 2*r])
set(gca,'nextplot','replacechildren');
center=h*[-sin(thet)*sin(phi(1)) cos(thet)*sin(phi(1)) cos(phi(1))];
perp1=[cos(thet) sin(thet) 0];
perp2=cross(perp1,center)/h;
L(1,1:3)=I*w*center/h; %angular momentum components
wt=zeros(1,t);
wp=0;
wc=0;

for(i=2:t)
    thet=thet+0*(rand(1))/400;
    phi(i)=phi(i)+0*(rand(1)-0.5)/1000;
    center=h*[-sin(thet)*sin(phi(i)) cos(thet)*sin(phi(i)) cos(phi(i))];
    line3=[2*perp2+center; center; 2*perp1+center]';
    perp1=[cos(thet) sin(thet) 0];
    perp2=-cross(perp1,center)/h;
    L(i,1:3)=L(i-1,1:3)+M*g*cross([(rand(1,1)-0.5)*0.001 (rand(1,1)-0.5)*0.001 (rand(1,1)-0.05)*0.001-1],center);%-0.001*([wp wt(i) 0]);
    a=r*(cos(thet)*cos(ang)+cos(phi(i))*sin(thet)*sin(ang))+center(1);
    b=r*(sin(thet)*cos(ang)-cos(phi(i))*cos(thet)*sin(ang))+center(2);
    c=r*(sin(phi(i))*sin(ang))+center(3);
    disc=[a; b; c];
    
    wt(i)=dot(L(i,1:3),perp2)/(Ix);
    thet=thet+wt(i);
    wp(i)=dot(L(i,1:3),perp1)/(Ix);
    phi(i+1)=phi(i)+wp(i);
    wc=dot(L(i,1:3),center)/(I);
    ang=ang+wc;
    line=[0 0 0; disc(1,(end+1)/2) disc(2,(end+1)/2) disc(3,(end+1)/2); disc(1,1) disc(2,1) disc(3,1);0 0 0; disc(1,(end-1)/4) disc(2,(end-1)/4) disc(3,(end-1)/4); disc(1,3*(end-1)/4) disc(2,3*(end-1)/4) disc(3,3*(end-1)/4); 0 0 0]';
    line2=[0 0 0; center]';
    line3=[2*perp2+center; center; 2*perp1+center]';
    fill3(disc(1,1:int16(end/2)),disc(2,1:int16(end/2)),disc(3,1:int16(end/2)),[0.5 0.5 0.5])
    hold on
    fill3(disc(1,int16(end/2):end),disc(2,int16(end/2):end),disc(3,int16(end/2):end),[0 0 0])
    fill3(line(1,:),line(2,:),line(3,:),'b');
    fill3(line2(1,:),line2(2,:),line2(3,:),'b');
    plot3(line3(1,:),line3(2,:),line3(3,:));
    hold off
    %view(180*thet/pi+50,310+180*phi(i)/pi)
    F(t) = getframe;
    set(gca,'nextplot','replacechildren');
    w2=sqrt(wc^2+wp(i)^2+wt(i)^2);
end
sqrt(dot(line2,line2));