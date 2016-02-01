function[CO1,CO2]=check(i,j,Z,size2)
%my function for checking speckle decorrelation based on size

X=Z(:,i,j);
Y=Z(:,i-size2:i+size2,j-size2:j+size2);
Y=mean(Y,2);
Y=mean(Y,3);

CO1=xcov(X);
CO2=xcov(Y);

figure
plot(CO1/max(CO1),'g')
hold on
plot(CO2/max(CO2),'k')