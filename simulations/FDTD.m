function [movie, E, H]=FDTD(x,t,init)
imp=377;
H=zeros(x,t);
E=zeros(x,t);
T=1:t;

%if(init==0)
 %   init=exp(-((T-7)/5).^2);
%end
if(size(init)<t)
    init=[init; zeros(t-size(init),1)];
end

mu(1:x,1)=1;  %relative permitivitty
ep(1:x,1)=1;  %relative permeability

ep(x/2:x,1)=3;
mu(x/2:x,1)=3;
mu(x/2-1,1)=2;

figure
axis xy
box on
view(0,90)

E(1,:)=init;
set(gca,'nextplot','replacechildren');
for(i=2:t)
    %H(end,i)=H(end-1,i-1); %Absorbing boundary
    H(1:end-1,i)=H(1:end-1,i-1)+(E(2:end,i-1)-E(1:end-1,i-1))/imp./mu(1:end-1);
    H(49,i)=H(49,i)-exp(-(i - 30)^2/100)/imp/mu(49); %TFSF boundary source
    E(1,i)=E(2,i-1); %Absorbing boundary
    E(end-1,i)=E(end-2,i-1); %Absorbing boundary
    E(2:end,i)=E(2:end,i-1)+(H(2:end,i)-H(1:end-1,i))*imp./ep(2:end);
    E(50,i)=E(50,i)+exp(-(i - 30+1)^2/100)/ep(50); %TFSF boundary source
    
    %E(50,i) = E(50,i)+exp(-(i - 30)^2/100); %OR additive source
    
    zlim([-6e-3 6e-3])
    ylim([-2 2])
    plot3(1:x,E(:,i),0*(1:x),'g');
    hold on
    plot3(1:x,0*(1:x),H(:,i),'r');
    F(i) = getframe;
    hold off
    set(gca,'nextplot','replacechildren');
end

movie=F;