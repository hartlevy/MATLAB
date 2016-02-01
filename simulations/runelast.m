close all
clear all
a(1)=1;
m(1)=1;
b(1)=0;
max=10;
for(i=1:max)
    m(i+1)=100^(-1/max)*m(i);
    
    [a(i+1) b(i)]=elast(a(i),m(i),m(i+1));
end

figure
plot(a)

figure
plot(m)

figure
plot(b)

Plost=sum(b.*m(1:end-1))%+a(end)*m(end)
Elost=sum(b.^2.*m(1:end-1))%+a(end)^2*m(end)