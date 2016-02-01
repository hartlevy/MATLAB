function []= kitty()
close all
figure
set(gca,'nextplot','replacechildren');
t=300;

ang=0:2*pi/80:2*pi;
a=3*cos(ang)-cos(2*ang)+0.7;
b=3*sin(ang)-sin(2*ang);

c=sin(0.1:0.1:pi/2-0.1);
d=cos(0.1:0.1:pi/2-0.1);
x=-1:1;
miao=wavread('miao.wav');
sound(miao,8192*8);
for(j=1:t)
    F(j)=getframe;
    fill(b,a,[1 0.66 0])
    hold on
    for(i=1:3)
        y=[(i-2)/2+0.2*sin(j/4) 0 (i-2)/2+0.2*sin(j/4)];
        plot(1.8*x,y-0.3)
    end
    plot(b/3,a/3-1.1)
    plot(d-0.9,-c*2)
    plot(-d+0.9,-c*2)
    plot(b(1)/2,a(1)/3-1.15,'ob','MarkerFaceColor','r','MarkerSize',18)
    plot(-1.3,1,'or','MarkerFaceColor','k','MarkerSize',24)%int16(24*sin(j/10)^2)+2)
    plot(1.3,1,'or','MarkerFaceColor','k','MarkerSize',24)%int16(24*cos(j/10)^2)+2);
    fill([b(13) b(19) b(21) b(21:13)], [a(13) a(19)+1.4 a(21) a(21:13)],[1 0.66 0])
    fill([b(15) b(18) b(19) b(15:19)], [a(15) a(18)+0.9 a(19) a(15:19)],[0 0 0])
    fill([b(end-13) b(end-19) b(end-21) b(end-21:end-13)], [a(end-13) a(end-19)+1.4 a(end-21) a(end-21:end-13)],[1 0.66 0])
    fill([b(end-15) b(end-17) b(end-19) b(end-19:end-15)], [a(end-15) a(end-18)+0.9 a(end-19) a(end-19:end-15)],[0 0 0])
    if(mod(j,40)==0)
        sound(miao,8192*(7+2*rand(1)));
    end
    %plot(a+0.2,b);
    %plot(a-0.2,b);
    %plot(a,b-0.2);
    hold off
    set(gca,'nextplot','replacechildren');
end
