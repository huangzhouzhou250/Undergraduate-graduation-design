% theta=[0 0 0 0 0 0];
% clc;
% clear;
syms theta;
% theta=[-pi/2 pi/4 pi/2 0 0 0];
global a2 a3 d2 d4;
a2=0.4318;
a3=0.02032;
d2=0.14909;
d4=0.43307;

r1=[0 0 0]';
r2=[-d2 0 0]';
r3=[-d2 a2 0]';
r4=[-d2 a2+d4 a3]';
r5=[-d2 a2+d4 a3]';
r6=[-d2 a2+d4 a3]';

w1=[0 0 1]';
w2=[-1 0 0]';
w3=[-1 0 0]';
w4=[0 1 0]';
w5=[-1 0 0]';
w6=[0 1 0]';

tw1=Twist('R',w1,r1);
tw2=Twist('R',w2,r2);
tw3=Twist('R',w3,r3);
tw4=Twist('R',w4,r4);
tw5=Twist('R',w5,r5);
tw6=Twist('R',w6,r6);

T0=SE3(-d2,a2+d4,a3);
T1=tw1.T(theta(1));
T2=tw2.T(theta(2));
T3=tw3.T(theta(3));
T4=tw4.T(theta(4));
T5=tw5.T(theta(5));
T6=tw6.T(theta(6));

T=T0.T*T1*T2*T3*T4*T5*T6;
