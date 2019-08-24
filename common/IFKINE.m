function [ theta ] = IFKINE(location,pose,theta0)
%IFKINE为puma560的运动学反解，基于Paden子问题
% location为末端工具坐标系的位置，pose工具坐标系的姿态;
%theta0为大致目标关节角，若不输入则为[0 0 0 0 0 0];
%theta为反解的得到的各个关节的角度，该解只是其中的一组解
%% 设置相关参数的变量
p=pose;
l=location';
%工具坐标系的位姿矩阵
Tp=rpy2tr(p);
% Tp=Tp*transl(l);
Tp=transl(l)*Tp;
%theta的初值
if nargin==3
    theta1=theta0;
else
    theta1=zeros(1,6);
end
theta=zeros(1,6);
%% 建立机器人各个轴线的旋量
%连杆参数的设置
a2=0.4318;
a3=0.0203;
d2=0.15005;
d4=0.4318;
% 关节轴线上的一点
r=cell(1,6);
r{1}=[0 0 0]';
r{2}=[-d2 0 0]';
r{3}=[-d2 a2 0]';
r{4}=[-d2 a2+d4 a3]';
r{5}=[-d2 a2+d4 a3]';
r{6}=[-d2 a2+d4 a3]';
%关节运动的方向
w=cell(1,6);
w{1}=[0 0 1]';
w{2}=[-1 0 0]';
w{3}=[-1 0 0]';
w{4}=[0 1 0]';
w{5}=[-1 0 0]';
w{6}=[0 0 1]';
%各个关节的旋量的求解
tw=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},r{i});
end
%% 求解theta（3）
%取tw{4}、tw{5}、tw{6}的交点和tw{1}和tw{2}的交点，用于theta(3)求解
% 相关参数的求解和设置
l1=[-d2 a2+d4 a3];
l0=[-d2 a2+d4 a3]';%tw{4},tw{5},tw{6}的交点
T0=SE3(l1);
T=Tp*inv(T0.T);
pb=[0 0 0]';%tw{1}和tw{2}的交点
de=SE3(T)*l0-pb;
De=norm(de);
% theta(3)的求解，Paden3的可以具体参考其程序描述
[x1,x2]=Paden3(tw{3},l0,pb,De);
% 判断并选取合适的角度
if abs(theta1(3)-x1)<=abs(theta1(3)-x2)
    theta(3)=x1;
else
    theta(3)=x2;
end
%% 求解theta(1)和theta(2)
%相关参数的求解和设置
T3=tw{3}.T(theta(3));
p2=SE3(T3)*l0;
q2=SE3(T)*l0;
%theta(1)、theta(2)的求解，Paden2的可以具体参考其程序描述
[x1,x2,x3,x4]=Paden2(tw{1},tw{2},p2,q2,pb);
% 判断并选取靠近目标角度的角度组合
m=norm(theta1(1:2)-[x1 x3]);
n=norm(theta1(1:2)-[x2 x4]);
if abs(m)<=abs(n)
    theta(1)=x1;
    theta(2)=x3;
else
    theta(1)=x2;
    theta(2)=x4;
end
%% 求解theta（4）和theta（5 ）
%相关参数的求解和设置
T1=tw{1}.T(theta(1));
T2=tw{2}.T(theta(2));
T3=tw{3}.T(theta(3));
Ta=inv(T1*T2*T3)*T;
p3=l0+w{6};
q3=SE3(Ta)*p3;
%theta(4)、theta(5)的求解，Paden2的可以具体参考其程序描述
[x1,x2,x3,x4]=Paden2(tw{4},tw{5},p3,q3,l0)
% 判断并选取合适的角度
m=norm(theta1(4:5)-[x1 x3]);
n=norm(theta1(4:5)-[x2 x4]);
if abs(m)<=abs(n)
    theta(4)=x1;
    theta(5)=x3;
else
    theta(4)=x2;
    theta(5)=x4;
end
%% 求解theta（6）
T4=tw{4}.T(theta(4));
T5=tw{5}.T(theta(5));
Tb=inv(T4*T5)*Ta;
p4=[0 0 0]';
q4=SE3(Tb)*p4;
theta(6)=Paden1(tw{6},p4,q4);
T6=tw{6}.T(theta(6));
end
 