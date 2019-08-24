function T= FKINEdelta1(q0)
%FKINEdetla1 单个支链的指数积求解和表达
%用于delta反解过程中的验证已经求解
%q0为单个支链的前三个关节的关节角度
%T为单链求解时工具坐标系的位置
%% 角度和参数的设置
theta1(1)=q0(1);
theta1(2)=q0(2);
theta1(3)=q0(3);
theta1(4)=-theta1(3);
theta1(5)=-theta1(1)-theta1(2);
R=0.220;
r=0.065;
L1=0.340;
L2=0.500;
a=0.045;
%初始位置和角度的求解
z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));
%% 支链旋量的求解
tw1=cell(1,5);
q1=cell(1,5);
w1=cell(1,5);
T1=cell(1,5);
%支链关节的运动方向
w1{1}=[0 1 0]';
w1{2}=w1{1};
w1{5}=w1{2};
w1{3}=[cos(beta) 0 sin(beta)]';
w1{4}=w1{3};
%支链关节的 
q1{1}=[R 0 0]';
q1{2}=[R-L1*sin(beta) 0 L1*cos(beta)]';
q1{3}=[R-L1*sin(beta) a L1*cos(beta)]';
q1{4}=[r a z0]';
q1{5}=[r 0 z0]';
% 旋量的求解和变换矩阵
for i=1:5
    tw1{i}=TWIST('R',w1{i},q1{i});
    T1{i}=tw1{i}.T(theta1(i));
end
%% 指数积公式的求解
T0=SE3(0,0,z0);
T1=T1{1}*T1{2}*T1{3}*T1{4}*T1{5}*T0.T;
%工具坐标系的位置求解
T=T1(1:3,4);
end
