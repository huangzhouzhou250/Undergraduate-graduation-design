function T= FKINEdelta(q0,x1)
%FKINEdelta 为delta函数的正运动学求解
%q0为1x3的矩阵，为三条支链驱动轴的角度
%x1为大致目标角度，若不设置为[-1 0 -1 0-1 0]
%T为delta机器人工具坐标系的位置
%% 求解各个关节角的角度
if nargin==1
   x0=[-1 0 -1 0-1 0];
else
    x0=x1;
end
x=fsolve(@(x) fc(q0,x), x0);%利用方程求解各个关节角
%三个支链各个关节的角度求解
%theta1为第一个单链的各个关节角度
%theta2为第二个单链的各个关节角度
%theta3为第三个单链的各个关节角度
theta1=zeros(1,5);
theta2=zeros(1,5);
theta3=zeros(1,5);
theta1(1)=q0(1);
theta2(1)=q0(2);
theta3(1)=q0(3);
theta1(2)=x(1);
theta1(3)=x(2);
theta2(2)=x(3);
theta2(3)=x(4);
theta3(2)=x(5);
theta3(3)=x(6);
%单链关节角度之间的关系
theta1(4)=-theta1(3);
theta1(5)=-theta1(1)-theta1(2);
theta2(4)=-theta2(3);
theta2(5)=-theta2(1)-theta2(2);
theta3(4)=-theta3(3);
theta3(5)=-theta3(1)-theta3(2);
%% 参数的设置和求解
R=0.220;
r=0.065;
L1=0.340;
L2=0.500;
a=0.045;
%初始位置和角度的求解
z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));
%% 三个支链的单链雅克比矩阵的求解
%各个参数的初值设置
tw1=cell(1,5);
tw2=cell(1,5);
tw3=cell(1,5);
q1=cell(1,5);
q2=cell(1,5);
q3=cell(1,5);
w1=cell(1,5);
w2=cell(1,5);
w3=cell(1,5);
T1=cell(1,5);
T2=cell(1,5);
T3=cell(1,5);
%相邻连杆之间的变换矩阵
R0=SE3.Rz(2/3*pi); 
% 第一个支链的关节方向向量
w1{1}=[0 1 0]';
w1{2}=w1{1};
w1{5}=w1{2};
w1{3}=[cos(beta) 0 sin(beta)]';
w1{4}=w1{3};
%第一个关节的关节轴线经过的点
q1{1}=[R 0 0]';
q1{2}=[R-L1*sin(beta) 0 L1*cos(beta)]';
q1{3}=[R-L1*sin(beta) a L1*cos(beta)]';
q1{4}=[r a z0]';
q1{5}=[r 0 z0]';
% 支链1的相关旋量的求解
for i=1:5
    tw1{i}=Twist('R',w1{i},q1{i});
    T1{i}=tw1{i}.T(theta1(i));
end
% 支链2的相关旋量的求解
for i=1:5
    q2{i}=R0.R*q1{i};
    w2{i}=R0.R*w1{i};
    tw2{i}=Twist('R',w2{i},q2{i});
    T2{i}=tw2{i}.T(theta2(i));
end
% 支链3的相关旋量的求解
for i=1:5
    q3{i}=R0.R*R0.R*q1{i};
    w3{i}=R0.R*R0.R*w1{i};
    tw3{i}=Twist('R',w3{i},q3{i});
    T3{i}=tw3{i}.T(theta3(i));
end
%% 机器人工具坐标系相对于惯性系的求解
T0=SE3(0,0,z0);
TST=cell(3);
%各个支链的指数积公式的求解
TST{1}=T1{1}*T1{2}*T1{3}*T1{4}*T1{5}*T0.T;
TST{2}=T2{1}*T2{2}*T2{3}*T2{4}*T2{5}*T0.T;
TST{3}=T3{1}*T3{2}*T3{3}*T3{4}*T3{5}*T0.T;
% 获取动平台的位置
T1=TST{1}(1:3,4);
T2=TST{2}(1:3,4);
T3=TST{3}(1:3,4);
% 考虑到计算误差，求均值输出最终形位
T=(T1+T2+T3)/3;
end

