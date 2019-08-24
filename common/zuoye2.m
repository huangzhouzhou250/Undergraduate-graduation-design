L1 =   Link([0      0        0     0      0],'modified');
L2 =   Link([0      0       15     pi/2  0],'modified');
L3 =   Link([0      0       10     0      0],'modified');
zuoye=SerialLink([L1 L2 L3], 'name', 'PUMA560A');
% syms theta1 theta2 theta3 real;
% t=zuoye.fkine([theta1 theta2 theta3]);
% simplify(t)
t=zuoye.fkine([pi/2 pi/2 0])
