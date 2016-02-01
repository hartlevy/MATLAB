function [an,bn] = bloch (a,b,w)
close all
vc=3e8;
n=[1.45; 2.65];
k=n*w/vc
G=a+b;
z1=-a+min(a,b)/100:min(a,b)/100:0;
z2=-b+min(a,b)/100:min(a,b)/100:0;
len1=length(z1);
len2=length(z2);
len=len1+len2;
props=exp(-1i*k(1)*z1);
props2=exp(-1i*k(2)*(z2));

nu=k(2)/k(1);
p1=nu+1/nu;
p2=nu-1/nu;

A=exp(1i*k(1)*a)*(cos(k(2)*b)+1i/2*p1*sin(k(2)*b));
B=exp(-1i*k(1)*a)*(1i/2*p2*sin(k(2)*b));
C=conj(B);
%C=exp(1i*k(1)*a)*(-1i/2*p2*sin(k(2)*b));
D=conj(A);
%D=exp(-1i*k(1)*a)*(cos(k(2)*b)-1i/2*p1*sin(k(2)*b));
K=acos(real(A))/G
an=[-1i ;0];
for(i=2:13)
    an(:,i)=[D -B;-C A]*an(:,i-1);
    bn(1:2,i-1)=[1 1;1i*k(2) -1i*k(2)]\[exp(1i*k(1)*a) exp(-1i*k(1)*a); 1i*k(1)*exp(1i*k(1)*a) -1i*k(1)*exp(-1i*k(1)*a)]*an(:,i-1);
    f1((i-2)*len+len2+1:(i-1)*len)=an(1,i-1)*props;
    f2((i-2)*len+len2+1:(i-1)*len)=an(2,i-1)*conj(props);
    g1((i-2)*len+1:(i-2)*len+len2)=bn(1,i-1)*props2;
    g2((i-2)*len+1:(i-2)*len+len2)=bn(2,i-1)*conj(props2);
    
end
g1=[g1 zeros(1,len1)];
g2=[g2 zeros(1,len1)];
figure
axis square
plot(f1+f2);
hold on
plot(g1+g2,'r');
axis square
figure
plot3((1:length(g1))*min(a,b)/100,real(f1+f2+g1+g2),imag(f1+f2+g1+g2))
hold on
reds=find(abs(g1+g2)>0.01);
plot3((reds)*min(a,b)/100,real(g1(reds)+g2(reds)),imag(g1(reds)+g2(reds)),'r')
figure
plot(real(f1+f2+g1+g2))
hold on
plot(real(g1+g2),'r')