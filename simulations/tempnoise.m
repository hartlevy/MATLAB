function [images]= tempnoise(pattern,avg,dev,n)

%simulates shot noise on static speckle pattern
%pattern is speckle pattern. if given 0, generate gaussian white noise,
%200x200
%mean is desired mean intensity
%dev is desired level of speckle intensity, as a fraction
%shot noise is calculated as sqrt intensity.


if(pattern==0)
    pattern=randn(200);
end
    

p2=pattern-mean(pattern(:));
p3=pattern/std(pattern(:));

base = (1+p3*dev)*avg;
shot = sqrt(base); %shot noise amplitude
grid = size(base);
images=zeros(n,grid(1),grid(2));


time=clock;
time=sprintf('%d-%02d-%02d-%02d_%02d',int16(time(1:5)));
mkdir(time);
cd(time)

imwrite(uint16(base),'base.tif','tif')
for i=1:n
   del=randn(grid(1),grid(2)).*shot;
   images(i,:,:)=base+del;
   imwrite(uint16(base+del),sprintf('image%d.tif',i),'tif');   
end

cd ..