function [theta1,theta2,theta3] = IFKINEdelta_fangzhen(position,Q1,Q2,Q3)
%IFKINEdelta为delata机器人运动学反解的求解，基于指数积公式
% position为目标位置,Q1,Q2,Q3为大致目标角度，若不输入则为[0 -0.5 -0.5]
%% 目标位置
p=position-[0 0 20];
T=transl(p);
%% 目标角度的设置
if nargin==1
    q01=[0 -0.5 -0.5];
    q02=[0 -0.5 -0.5];
    q03=[0 -0.5 -0.5];
else
    q01=Q1;
    q02=Q2;
    q03=Q3;
end
%% 机器人参数的设置
R=220;
r=65;
L1=340;
L2=500;
a=45;
%初始角度和距离
theta1=zeros(1,5);
theta2=zeros(1,5);
theta3=zeros(1,5);
z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));
%% 相关关节的旋量求解
tw1=cell(1,5);
tw2=cell(1,5);
tw3=cell(1,5);
q1=cell(1,5);
q2=cell(1,5);
q3=cell(1,5);
w1=cell(1,5);
w2=cell(1,5);
w3=cell(1,5);
%支链之间的变换矩阵
R0=SE3.Rz(2/3*pi);
%支链1运动旋量求解
w1{1}=[0 1 0]';
w1{2}=w1{1};
w1{5}=w1{2};
w1{3}=[cos(beta) 0 sin(beta)]';
w1{4}=w1{3};

q1{1}=[R 0 0]';
q1{2}=[R-L1*sin(beta) 0 L1*cos(beta)]';
q1{3}=[R-L1*sin(beta) a L1*cos(beta)]';
q1{4}=[r a z0]';
q1{5}=[r 0 z0]';

for i=1:5
    tw1{i}=Twist('R',w1{i},q1{i});
end
%支链2运动旋量求解
for i=1:5
    q2{i}=R0.R*q1{i};
    w2{i}=R0.R*w1{i};
    tw2{i}=Twist('R',w2{i},q2{i});
end
%支链3运动旋量求解
for i=1:5
    q3{i}=R0.R*R0.R*q1{i};
    w3{i}=R0.R*R0.R*w1{i};
    tw3{i}=Twist('R',w3{i},q3{i});
end
%% 第一个支链theta1(2),theta1(3)的求解
%相关参数的设置
T0=SE3(0,0,z0);
T01=T*inv(T0.T);
p1=q1{4};
r1=q1{3};
q11=q1{1};
q12=q1{1}+w1{1}*0.1;
q=SE3(T01)*p1;
de11=norm(q-q11);
de12=norm(q-q12);
%角度的求解
[x1,x2,x3,x4]=Padene(tw1{2},tw1{3},p1,q11,q12,r1,de11,de12);
t1=[q01(2),q01(3)];
x=[x1' x2' x3' x4'];
x11=norm(x1-t1);
x12=norm(x2-t1);
x13=norm(x3-t1);
x14=norm(x4-t1);
x00=[x11 x12 x13 x14];
k=find(x00==min(x00));
if length(k)>1
    k1=k(1);
else
    k1=k;
end
theta1(2)=x(1,k1);
theta1(3)=x(2,k1);
 %% theta1(1)的求解
 T02=tw1{2}.T(theta1(2))*tw1{3}.T(theta1(3));
 q10=SE3(T02)*p1;
 theta1(1)=Paden1(tw1{1},q10,q);
 %% 第二个支链theta2(2),theta2(3)的求解
 T01_2=T*inv(T0.T);
 p2=q2{4};
 r2=q2{3};
 q21=q2{1};
 q22=q2{1}+w2{1}*0.1;
 q_2=SE3(T01_2)*p2;
 de21=norm(q_2-q21);
 de22=norm(q_2-q22);
 %求解角度
 [x1,x2,x3,x4]=Padene(tw2{2},tw2{3},p2,q21,q22,r2,de21,de22);
 t1=[q02(2),q02(3)];
 x=[x1' x2' x3' x4'];
 x11=norm(x1-t1);
 x12=norm(x2-t1);
 x13=norm(x3-t1);
 x00=[x11 x12 x13 x14];
 k=find(x00==min(x00));
 if length(k)>1
    k1=k(1);
 else
    k1=k;
 end
 theta2(2)=x(1,k1);
 theta2(3)=x(2,k1);
 %%  theta2(1)的求解
 T02_2=tw2{2}.T(theta2(2))*tw2{3}.T(theta2(3));
 q20=SE3(T02_2)*p2;
 theta2(1)=Paden1(tw2{1},q20,q_2);
  %% 第三个支链theta3(2),theta3(3)的求解
 T01_3=T*inv(T0.T);
 p3=q3{4};
 r3=q3{3};
 q31=q3{1};
 q32=q3{1}+w3{1}*0.1;
 q_3=SE3(T01_3)*p3;
 de31=norm(q_3-q31);
 de32=norm(q_3-q32);
 [x1,x2,x3,x4]=Padene(tw3{2},tw3{3},p3,q31,q32,r3,de31,de32);
 x=[x1' x2' x3' x4'];
 t1=[q03(2),q03(3)];
 x11=norm(x1-t1);
 x12=norm(x2-t1);
 x13=norm(x3-t1);
 x14=norm(x4-t1);
 x00=[x11 x12 x13 x14];
 k=find(x00==min(x00));
 if length(k)>1
    k1=k(1);
 else
    k1=k;
 end
 theta3(2)=x(1,k1);
 theta3(3)=x(2,k1);
 %%  theta3(1)的求解
 T02_3=tw3{2}.T(theta3(2))*tw3{3}.T(theta3(3));
 q30=SE3(T02_3)*p3;
 theta3(1)=Paden1(tw3{1},q30,q_3);
 %% 三个支链关节角度的求解
theta1(4)=-theta1(3);
theta1(5)=-theta1(1)-theta1(2);

theta2(4)=-theta2(3);
theta2(5)=-theta2(1)-theta2(2);

theta3(4)=-theta3(3);
theta3(5)=-theta3(1)-theta3(2);
%% 
theta1=theta1*180/pi;
theta2=theta2*180/pi;
theta3=theta3*180/pi;
end

