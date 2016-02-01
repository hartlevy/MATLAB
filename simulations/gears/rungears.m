function [F]=rungears(gears,w0)

%Input: the m x 3 gears matrix, and angular speed of origin gear.
% gears(1,:) is the radii of each gear
% gears(2,:) is the relative position angle of each gear to its parent
% gears(3,:) is the parent gear of each gear
% gears(4,:) is the locked gear flag (gear rotates parallel with parent)

close all
if size(gears,2)~=4
    err = MException('MATLAB:Error','Wrong number of input columns');
    throw(err);
end

ngears=size(gears,1);
parent=gears(:,3);
[parent,I]=sort(parent); %sort gears in parent tree form
r=gears(I,1)
thet=gears(I,2)
lock=gears(I,4);
parent=parent'

if min(parent) ~= 0
    err = MException('MATLAB:Error','Origin gear missing');
    throw(err);
end

if size(find(parent==0))>1
    err = MException('MATLAB:Error','More than 1 origin gear');
    throw(err);
end

if max(parent-(0:ngears-1)) > 0
    err = MException('MATLAB:Error','Parent gear %d does not exist',parent(find(parent-(0:ngears-1)>0,1)));
    throw(err);
end

phi=0:pi/100:2*pi; %full circle angles
x=zeros(ngears,1);
y=zeros(ngears,1);
z=zeros(ngears,1);
w=zeros(ngears,1);
w(1)=w0;

figure
axis square
set(gca,'nextplot','replacechildren');

for(t=1:1000)
    phase=phi(mod(t,length(phi))+1); %time dependant phase
    circ=(0:5*pi/4:10*pi); %spokes about gear circumference
    plot3(x(1)+r(1)*cos(phi),y(1)+r(1)*sin(phi),z(1)*phi./phi); %origin gear
    hold on
    plot3([x(1)+r(1)*cos(thet(1)+w(1)*phase+circ)], [y(1)+r(1)*sin(thet(1)+w(1)*phase+circ)],[z(1)*circ./circ],'r');
    
    for i=2:ngears
        if(lock(i))
            x(i)=x(parent(i));
            y(i)=y(parent(i));
            w(i)=w(parent(i));
            z(i)=z(parent(i))-1;
        else
            
            [x(i),y(i),w(i)]=stepgear(r(parent(i)),r(i),thet(i),w(parent(i)));
            x(i)=x(i)+x(parent(i));
            y(i)=y(i)+y(parent(i));
            z(i)=z(parent(i));
        end
        plot3(x(i)+r(i)*cos(phi),y(i)+r(i)*sin(phi),z(i)*phi./phi);
        plot3([x(i)+r(i)*cos(thet(i)+w(i)*phase+circ)], [y(i)+r(i)*sin(thet(i)+w(i)*phase+circ)],[z(i)*circ./circ],'r');
        
    end
    
    ylim(xlim);
    zlim([2*min(z) max(z)-min(z)]);
    F(t) = getframe;
    hold off
    set(gca,'nextplot','replacechildren');
end


