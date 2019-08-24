function [ J1,J2,J3] = JACOD( alp1,alp2,alp3 )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
% x0=[1 0 1 0 1 0];
% x=fsolve(@(x) fc(q0,x), x0);
theta1=zeros(1,5);
theta2=zeros(1,5);
theta3=zeros(1,5);
% theta1(1)=q0(1);
% theta2(1)=q0(2);
% theta3(1)=q0(3);
% theta1(2)=x(1);
% theta1(3)=x(2);
% theta2(2)=x(3);
% theta2(3)=x(4);
% theta3(2)=x(5);
% theta3(3)=x(6);

theta1(1)=alp1(1);
theta2(1)=alp2(1);
theta3(1)=alp3(1);
theta1(2)=alp1(2);
theta1(3)=alp1(3);
theta2(2)=alp2(2);
theta2(3)=alp2(3);
theta3(2)=alp3(2);
theta3(3)=alp3(3);

theta1(4)=-theta1(3);
theta1(5)=-theta1(1)-theta1(2);

theta2(4)=-theta2(3);
theta2(5)=-theta2(1)-theta2(2);

theta3(4)=-theta3(3);
theta3(5)=-theta3(1)-theta3(2);

% theta1
% theta2
% theta3

R=220;
r=65;
L1=340;
L2=500;
a=45;

z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));

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

R0=SE3.Rz(2/3*pi);
% syms alp;
% R0=SE3.Rz(alp);

w1{1}=[0 -1 0]';
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
    tw1{i}=TWIST('R',w1{i},q1{i});
    T1{i}=tw1{i}.T(theta1(i));
end

for i=1:5
    q2{i}=R0.R*q1{i};
    w2{i}=R0.R*w1{i};
    tw2{i}=TWIST('R',w2{i},q2{i});
    T2{i}=tw2{i}.T(theta2(i));
end

for i=1:5
    q3{i}=R0.R*R0.R*q1{i};
    w3{i}=R0.R*R0.R*w1{i};
    tw3{i}=TWIST('R',w3{i},q3{i});
    T3{i}=tw3{i}.T(theta3(i));
end

% T0=SE3(0,0,z0);
% TST=cell(3);
% TST{1}=T1{1}*T1{2}*T1{3}*T1{4}*T1{5}*T0.T;
% TST{2}=T2{1}*T2{2}*T2{3}*T2{4}*T2{5}*T0.T;
% TST{3}=T3{1}*T3{2}*T3{3}*T3{4}*T3{5}*T0.T;
% 
% T1=TST{1};
% T2=TST{2};
% T3=TST{3};
%% 求解雅克比矩阵
J1=zeros(5,6);
J2=zeros(5,6);
J3=zeros(5,6);
for j=1:5
    AD=SE3(eye(4));
    for i=1:j
      if i==1
         AD=SE3(eye(4));
      else
         AD=AD*SE3(tw1{i-1}.T(theta1(i-1)));
      end
    end
    J1(:,j)=AD.Ad*(tw1{i}.double)';
end
for j=1:5
    AD=SE3(eye(4));
    for i=1:j
      if i==1
         AD=SE3(eye(4));
      else
         AD=AD*SE3(tw2{i-1}.T(theta2(i-1)));
      end
    end
    J2(:,j)=AD.Ad*(tw2{i}.double)';
end
for j=1:5
    AD=SE3(eye(4));
    for i=1:j
      if i==1
         AD=SE3(eye(4));
      else
         AD=AD*SE3(tw3{i-1}.T(theta3(i-1)));
      end
    end
    J3(:,j)=AD.Ad*(tw3{i}.double)';
end
end

