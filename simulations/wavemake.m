function [a,b] = wavemake(n,d,amp,change)
close all
a=zeros(512);
for i=1:n
    a(i*d,i*d)=amp/change^i;
    a(500,500-i*d)=amp/change^i;
end
a=fftshift(a);
b=fftshift(abs(fft2(a)));
figure
imshow(b,[0 max(b(:))]);
figure
imshow(a,[0 max(a(:))]);