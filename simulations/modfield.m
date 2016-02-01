function [field2,spec]= modfield(field,D,center,amp)
L=size(field,1)
field2=field;

for i=(-D/2:D/2)+center(1)
 ang=asin((i-center(1))/(D+2)*2);
 start=int16(D/2*cos(pi-ang));
 fin=int16(D/2*cos(ang));
    for j=(start:fin)+center(2)
        phase=amp*2*pi*(rand(1)-0.5);
        field2(i,j)=exp(1i*(angle(field(i,j))+phase));
    end
end
spec=fftshift(fft2(field2));
spec=spec.*conj(spec)./L^2;
spec=spec(1:L,1:L);
%figure
%imshow(spec,[0 max(max(spec))]);