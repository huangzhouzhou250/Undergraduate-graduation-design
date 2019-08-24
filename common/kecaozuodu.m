%puma560可操作度的求解，在求解过程保持后三个关节不变
x=zeros(1,100);
y=zeros(1,100);
z=zeros(1,100);
k=zeros(1,100);
n=1;
for a=(-160:10:160)*pi/180
    for b=(-225:10:45)*pi/180
        for c=(-45:10:225)*pi/180
            T=Fkine([a b c 0 0 0]');
            [x(n),y(n),z(n)]=transl(T);
            J=JACO([a b c 0 0 0]');
            k(n)=abs(det(J));
            n=n+1;
        end
    end
end
scatter3(x,y,z,4,k,'filled');
title('PUMA560可操作度');                       
colorbar