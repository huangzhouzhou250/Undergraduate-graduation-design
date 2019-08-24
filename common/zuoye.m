syms d2 a2;
L1 =   Link([0      0        0     0      0],'modified');
L2 =   Link([0      0        d2     pi/2  0],'modified');
L3 =   Link([0       0       a2     0      0],'modified');
p560a=SerialLink([L1 L2 L3], 'name', 'PUMA560A');
syms theta1 theta2 theta3;
p560a.fkine([theta1 theta2 theta3])