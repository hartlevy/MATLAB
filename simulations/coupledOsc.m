function [M] = coupledOsc(k1,k3,b,t)
close all
figure

k2=0.04;
y=1:256;
t=int16(t);
X1=ones(1,2)/4;
V1=zeros(1,2);
A1=zeros(1,2);
xlim([0 256]);
ylim([-10,8]);
m1=4;
m2=300;
X2=cos(k2*y);
set(gca,'nextplot','replacechildren');
%for(i=1:t)
 %  plot(0,X(1),'.')
 %  A(1,i+1)=(-k1*X(1,i)-k2*(X(1,i)-X(2,i))-b*V(1,i))/m(1);
 %  A(2,i+1)=(-k3*X(2,i)-k2*(X(2,i)-X(1,i)))/m(2);
 %  V(:,i+1)=V(:,i)+A(:,i+1);
 %   X(:,i+1)=X(:,i)+V(:,i+1);
 %   plot(i ,-X(1,i)-2,'.b');
 %   hold on
 %   plot(1:i ,-(1+X(2,1:i)),'.r');
 %   set(gca,'nextplot','replacechildren');
 %   M(t)=getframe;
%end

for(i=1:t)
    k2=k2*(1);
    A1=(-k3*X1-k2*2*(X1-[X2(100) X2(128)])-b*V1/m1);
    X2=cos(k1*y-k2*double(i)).*(cos(k2*y-k2*2*double(i)));
    V1=V1+A1;
    X1=X1+V1;
    plot([100 128],-X1-0.5,'.-b');
    hold on
    plot(y ,-(1+X2),'.r');
    set(gca,'nextplot','replacechildren');
    M(t)=getframe;
end
