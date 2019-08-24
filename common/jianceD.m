q=[0 0 0 0 0 0];
for i=1:50
    x=50*sin(2*pi/50*i);
    y=50*cos(2*pi/50*i);
    z=750;
    p=[x,y,z];
    [q1,q2,q3]=IFKINEdelta(p);
    q=[q1(2:3) q2(2:3) q3(2:3)];
    t1=q1(1);
    t2=q1(2);
    t3=q1(3);
    T=FKINEdelta1([t1 t2 t3]);
    l=T(1);
    m=T(2);
    n=T(3);
    T1=FKINEdelta([q1(1) q2(1) q3(1)],q);
    u=T1(1);
    v=T1(2);
    w=T1(3);
    H1=plot3(u,v,w,'k.');
    H2=plot3(x,y,z,'b.');
    H3=plot3(l,m,n,'r.');
    hold on;
end
title('delta机器人检验');
legend([H1,H2,H3],'反解—整体求解','目标轨迹点','反解-单链验证');
    