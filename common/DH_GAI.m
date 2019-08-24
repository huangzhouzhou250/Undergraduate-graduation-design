
% syms a1 b1 c1 e;
a1=10;
b1=0;
c1=1;
d1=0
e=-pi/2;
%alpha=0 a=a1 theta=b1 d=d1;

T1= SE3.Rx(0)*SE3(a1,0,0)*SE3.Rz(b1)*SE3(0,0,d1)*SE3.Ry(c1)
%alpha=-c1 a=0 theta=b1+pi/2 d=a1/sin£¨c1)+d1;
T2= SE3.Rx(-c1)*SE3(0,0,0)*SE3.Rz(pi/2+b1)*SE3(0,0,d1+a1/sin(c1))
m=SE3.Rz(e)*SE3(0,0,-a1/tan(c1));
T2=simplify(m*T2)

S1=SO3(T1);
S2=SO3(T2);
