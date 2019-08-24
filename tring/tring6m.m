% T=FKINEdelta([0 0 0]);
% p=T;
% [q1,q2,q3]=IFKINEdelta(p);
% FKINEdelta([q1(1),q2(1),q3(1)]);
R=220;
r=65;
L1=340;
L2=500;
a=45;
z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));
x=[-1 0 -1 0 -1 0];
theta=[1.12 0.9 1.5];
T1=FKINEdelta(theta,x)
m=theta-beta;
n=m*180/pi;
% Q1=[theta(1) -0.5 0];
% Q2=[theta(2) 0 0];
% Q3=[theta(3) -0.5 0];
% [p1,p2,p3]=IFKINEdelta(T1,Q1,Q2,Q3);
% [p1(1) p2(1) p3(1)]
% T=FKINEdelta([beta+5/180*pi beta+10/180*pi beta+5/180*pi]);
% [q1,q2,q3]=IFKINEdelta(T);
% T2=FKINEdelta1([q1(1:3)]);