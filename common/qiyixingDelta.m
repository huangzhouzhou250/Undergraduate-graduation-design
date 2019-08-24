%delta在指定角度范围的奇异性可视化表达
R=0.220;
r=0.065;
L1=0.340;
L2=0.500;
a=0.04;
beta=asin((R-r)/(L1+L2));
T1=rotz(2/3*pi);
T2=rotz(4/3*pi);
d=R-r;
x1=[0 0 0 0 0 0];
Q1=[0 0 0];
Q2=Q1;
Q3=Q2;
for m=(0:0.5:10)*pi/180
    for n=(0:0.5:10)*pi/180
         for k=(0:0.5:10)*pi/180
             T=FKINEdelta([m n k],x1);
             [q1,q2,q3]=IFKINEdelta(T,Q1,Q2,Q3);
             x1=[q1(2:3),q2(2:3),q3(2:3)];
             Q1=q1(1:3);
             Q2=q2(1:3);
             Q3=q2(1:3);
             x=T(1);
             y=T(2);
             z=T(3);
             if (abs(y-L2)<=0.001)||(abs((abs(tan(2/3*pi)*x+y)-L2))<=0.001)...
                     ||(abs((abs(tan(4/3*pi)*x+y)-L2))<=0.001)...
                     ||(abs([x+r*cos(2/3*pi)-R*cos(2/3*pi) y+r*sin(2/3*pi)-R*sin(2/3*pi) z]*(T1*...
                        [cos(pi/2-beta+n) 0 sin(pi/2-beta+n)]'))<=0.001)...
                     ||(abs([x+r-R y z]*[cos(pi/2-beta+m) 0 sin(pi/2-beta+m)]')<=0.001)...
                     ||(abs([x+r*cos(4/3*pi)-R*cos(4/3*pi) y+r*sin(4/3*pi)-R*sin(4/3*pi) z]*(T2*...
                        [cos(pi/2-beta+n) 0 sin(pi/2-beta+n)]'))<=0.001)
                 H1=plot3(x,y,z,'r.');
                 hold on;
                 grid on;
             else
                 H2=plot3(x,y,z,'b.');
                 hold on;
                 grid on;
             end
         end
    end
end
title('delta奇异性分析');
legend([H1,H2],'奇异点','非奇异点');
                        