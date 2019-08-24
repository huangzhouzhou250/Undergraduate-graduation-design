
theta=[-pi/2 pi/2 pi 0 0 0];
% theta=[0 0 0 0 0 0];
global a2 a3 d2 d4;
a2=0.4318;
a3=0.02032;
d2=0.14909;
d4=0.43307;

r=cell(1,6);
r{1}=[0 0 0]';
r{2}=[-d2 0 0]';
r{3}=[-d2 a2 0]';
r{4}=[-d2 a2+d4 a3]';
r{5}=[-d2 a2+d4 a3]';
r{6}=[-d2 a2+d4 a3]';

w=cell(1,6);
w{1}=[0 0 1]';
w{2}=[-1 0 0]';
w{3}=[-1 0 0]';
w{4}=[0 1 0]';
w{5}=[-1 0 0]';
w{6}=[0 1 0]';

tw=cell(1,6);
T=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},cross(w{i},r{i}));
    T{i}=tw{i}.T(theta(i));
    TE=eye(4);
    TE=TE.*T{i};
    T0=SE3(-d2,a2+d4,a3); 
    TE=TE*T0.T;
end
% tw1=Twist('R',w1,cross(w1,r1));
% tw2=Twist('R',w2,cross(w2,r2));
% tw3=Twist('R',w3,cross(w3,r3));
% tw4=Twist('R',w4,cross(w4,r4));
% tw5=Twist('R',w5,cross(w5,r5));
% tw6=Twist('R',w6,cross(w6,r6));
% 
% T0=SE3(-d2,a2+d4,a3);
% T1=tw1.T(theta(1));
% T2=tw2.T(theta(2));
% T3=tw3.T(theta(3));
% T4=tw4.T(theta(4));
% T5=tw5.T(theta(5));
% T6=tw6.T(theta(6));
% 
% T=T0.T*T1*T2*T3*T4*T5*T6;



