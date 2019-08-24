%p560A为根据robotic toolbox两连杆模型建立机器人的仿真模型
%% 求解过程
% 连杆参数
a2=0.4318;
a3=0.0203;
d2=0.15005;
d4=0.4318;
% 连杆参数的D-H方法建立
%             th      d        a    alpha
L1 =   Link([0       0        0     0      0],'modified');
L2 =   Link([0       d2        0     -pi/2  0],'modified');
L3 =   Link([0       0       a2     0      0],'modified');
L4 =   Link([0       d4       a3     -pi/2  0],'modified');
L5 =   Link([0        0        0     pi/2   0],'modified');
L6 =   Link([0        0        0     -pi/2  0],'modified');
p560a=SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'PUMA560A');
% 相关角度的设置
qz=[0 0 0 0 0 0];
qn=[pi/2 0 -pi/2 0 0 0];