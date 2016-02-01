function [field,spec,center]= genfield(L,D,pix)
close all
field=zeros(L,L);
downsamp=1;
if(D>L-2)
    D2=D;
    D=L-2;
    downsamp=D2/D;
end

center=randi([D/2+1 L-D/2],2,1);
for i=(-D/2:pix:D/2)+center(1)
 ang=asin((i-center(1))/(D+2)*2);
 start=int16(D/2*cos(pi-ang));
 fin=int16(D/2*cos(ang));
    for j=(start:pix:fin)+center(2)
        phase=2*pi*(rand(1)-0.5);
        field(i:i+pix-1,j:j+pix-1)=exp(1i*phase);
    end
end
figure
imshow(angle(field),pi*[-1 1]);
spec=fftshift(fft2(field));
spec=spec.*conj(spec)./L^2;
[XI,YI]=meshgrid(1:downsamp:L);
spec=interp2(spec,XI,YI);
[XI,YI]=meshgrid(1:1/downsamp:L);
spec=interp2(spec,XI,YI);
spec=spec(1:L,1:L)/max(spec(:));

figure
imshow(spec,[0 max(max(spec))])

[N,X]=hist(spec(:),1000);
figure
N=N/length(spec(:))/(X(2)-X(1));
semilogy(X,N);
xlabel('Intensity','FontSize',16)
ylabel('Probability Density','FontSize',16)
Dist=exp(-X/mean(spec(:)));
Dist=Dist/sum(Dist(:))/(X(2)-X(1));
hold on;
plot(X,Dist,'r');
sum(N*(X(2)-X(1)))
sum(Dist*(X(2)-X(1)))