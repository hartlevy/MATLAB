function [balls,V,P] = gravity(N,bounce,A,size,t,drag)

V=zeros(3,N);
P=zeros(3,N);
V(1,:)=(rand([N,1])/2+0.5)*3;
V(2,:)=-rand([N,1])+1;
V(3,:)=(rand([N,1])/2+0.5)*3;
P(:,:)=rand([3,N])*20;
plot3(P(1,:),size-P(2,:),P(3,:),'.')
xlim([0 size])
ylim([0 size]);
zlim([0 size+60]);
%xlim([-60 60])
%ylim([-100 150])
axis square
view(-20,20)
set(gca,'nextplot','replacechildren');
D=((rand([1 N])-1)/4+1)*drag;
D=([D; D; D]);
for j=1:t
    B=((rand([1 N])-1)/5+1)*bounce;
    B=B(randperm(N));
    box on
    F(j) = getframe;
    P(1,:)=P(1,:)+V(1,:);
    P(2,:)=P(2,:)+V(2,:);
    P(3,:)=P(3,:)+V(3,:);
    V(2,:)=V(2,:)+A;
    V=V.*(1-D);
 %   view(-20+j,20)
    for k=1:N
        if (P(2,k)>size)
            ang=(1+randn([1,2]));
            %ang=1;
            V(2,k)=-V(2,k)*B(k);
            sum=dot(V(:,k),V(:,k));
            V(1,k)=ang(1)*V(1,k);
            V(3,k)=ang(2)*V(3,k);
            if ((V(1,k)^2 +V(3,k)^2)>= sum)
                V(1,k)=sqrt(0.45*sum)*sign(V(1,k));
                V(3,k)=sqrt(0.45*sum)*sign(V(3,k));
            end
            V(2,k)=-sqrt((sum-V(1,k)^2-V(3,k)^2));
            P(2,k)=size;
        end
        if (P(1,k)>size || P(1,k)<0)
            V(1,k)=-V(1,k);
            P(1,k)=P(1,k)+V(1,k);
        end
        if (P(3,k)>size || P(3,k)<0)
            V(3,k)=-V(3,k);
            P(3,k)=P(3,k)+V(3,k);
        end
    end
    %plot(P(1,:),size-P(2,:),'.')
    plot3([0 size size 0], [size size size size], [0 0 size+60 size+60],'k');
    hold on 
    plot3([size size size size], [size 0 0 size], [0 0 size+60 size+60],'k');
    plot3(P(1,:),size-P(3,:),zeros(1,N),'.','Color',[0.5 0.5 0.5]);
    plot3(size*ones(1,N),size-P(3,:),size-P(2,:),'.','Color',[1 0.5 0.5]);
    plot3(P(1,:),size*ones(1,N),size-P(2,:),'.','Color',[0.5 1 0.5]);
    plot3(P(1,:),size-P(3,:),size-P(2,:),'ok','MarkerFaceColor','b','MarkerSize',4)
    hold off
    set(gca,'nextplot','replacechildren');
    %plot(V(1,:)*10,V(2,:)*10,'.')
end
balls=F;
