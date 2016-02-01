function [field2,spec2]=reducefield(field,center,D)
%close all
L=size(field,1)
field2=zeros(L,L);
downsamp=1;
for i=(-D/2:D/2+1)+center(1)
 ang=asin((i-center(1))/(D+2)*2);
 start=int16(D/2*cos(pi-ang));
 fin=int16(D/2*cos(ang));
    for j=(start:fin)+center(2)
        field2(i,j)=field(i,j);
    end
end
%figure
%imshow(real(field),[-1 1]);
spec2=fftshift(fft2(field2));
spec2=spec2.*conj(spec2)./L^2;
[XI,YI]=meshgrid(1:downsamp:L);
spec2=interp2(spec2,XI,YI);

figure
imshow(spec2,[min(min(spec2)) max(max(spec2))])

%[N,X]=hist(spec2(:),1000);
%figure
%semilogy(X,N);