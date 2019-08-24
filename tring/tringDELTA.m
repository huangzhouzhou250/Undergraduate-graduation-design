clc;
clear;
global R r L1 L2 a;
%  syms R r L1 L2 a real;
%  syms beta z0 real;
theta1=zeros(1,5);
theta2=zeros(1,5);
theta3=zeros(1,5);
% theta1(1)=0.5;
% theta1(2)=-0.2672;
% theta1(3)=0.6497;
% 
% theta2(1)=0.4;
% theta2(2)=2.8869;
% theta2(3)=-2.3842;
% 
% theta3(1)=0.3;
% theta3(2)=1.7990;
% theta3(3)=3.0595;
% syms x11 x12 x13 x14 x15 real;
% syms x21 x22 x23 x24 x25 real;
% syms x31 x32 x33 x34 x35 real;
% 
% theta1=[x11 x12 x13 x14 x15];
% theta2=[x21 x22 x23 x24 x25];
% theta3=[x31 x32 x33 x34 x35];

theta1(4)=-theta1(3);
theta1(5)=-theta1(1)-theta1(2);

theta2(4)=-theta2(3);
theta2(5)=-theta2(1)-theta2(2);

theta3(4)=-theta3(3);
theta3(5)=-theta3(1)-theta3(2);

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

T0=SE3(0,0,z0);
TST=cell(3);
TST{1}=T1{1}*T1{2}*T1{3}*T1{4}*T1{5}*T0.T;
TST{2}=T2{1}*T2{2}*T2{3}*T2{4}*T2{5}*T0.T;
TST{3}=T3{1}*T3{2}*T3{3}*T3{4}*T3{5}*T0.T;
TST{1}
TST{2}
TST{3}
% simplify(TST{1})
% simplify(TST{2})
% simplify(TST{3})
% 
% y(1)=TST{1}(1,4)-TST{2}(1,4);
% y(2)=TST{1}(1,4)-TST{3}(1,4);
% y(3)=TST{1}(2,4)-TST{2}(2,4);
% y(4)=TST{1}(2,4)-TST{3}(2,4);
% y(5)=TST{1}(3,4)-TST{2}(3,4);
% y(6)=TST{1}(3,4)-TST{3}(3,4);
% [x12,x13,x22,x23,x32,x33]=solve('TST{1}(1,4)=TST{2}(1,4)','TST{1}(1,4)=TST{3}(1,4)',...
%     'TST{1}(2,4)=TST{2}(2,4)','TST{1}(2,4)=TST{3}(2,4)',...
%     'TST{1}(3,4)=TST{2}(3,4)','TST{1}(3,4)=TST{3}(3,4)');
    