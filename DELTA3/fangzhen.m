[Q1,Q2,Q3]=IFKINEdelta([0 0.050 0.750]);
s1=zeros(1,1000);
s2=zeros(1,1000);
s3=zeros(1,1000);
R=0.220;
r=0.065;
L1=0.340;
L2=0.500;
a=0.045;
z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));
for i=1:1000
    x=0.050*sin(2*pi/1000*i);
    y=0.050*cos(2*pi/1000*i);
    z=0.750;
    p=[x,y,z];
    [q1,q2,q3]=IFKINEdelta(p,Q1,Q2,Q3);
    Q1=q1;
    Q2=q2;
    Q3=q3;
    s1(i)=(q1(1)-beta)*180/pi-90;
    s2(i)=(q2(1)-beta)*180/pi;
    s3(i)=(q3(1)-beta)*180/pi-180;
end
m1.time=0.01:0.01:10;
m1.signals.values=s1';
m1.signals.dimensions = 1;
m1.signals.label = 'm1';
save m1.mat m1

m2.time=0.01:0.01:10;
m2.signals.values=s2';
m2.signals.dimensions = 1;
m2.signals.label = 'm2';
save m2.mat m2

m3.time=0.01:0.01:10;
m3.signals.values=s3';                                                                                                                                                                                                           
m3.signals.dimensions = 1;
m3.signals.label = 'm3';
save m3.mat m3