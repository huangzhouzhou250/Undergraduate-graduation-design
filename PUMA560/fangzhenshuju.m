y=0.500;
q=zeros(50,6);
q0=[0 0 0 0 0];
for i=1:1000
    x=0.30*sin(2*pi/1000*i);
    z=0.30*cos(2*pi/1000*i);
    pose=[0 0 0];
    loca=[x,y,z];
    q1=IFKINE(loca,pose,q0);
    q0=q1;
    q2=q1+[pi/2 pi/2 0 0 -pi*3/2 0];
    q2=q2*180/pi;
    q(i,:)=q2;
end

m1.time=0.01:0.01:10;
m1.signals.values=-q(:,1);
m1.signals.dimensions = 1;
m1.signals.label = 'm1';
save m1.mat m1

m2.time=0.01:0.01:10;
m2.signals.values=q(:,2);
m2.signals.dimensions = 1;
m2.signals.label = 'm2';
save m2.mat m2

m3.time=0.01:0.01:10;
m3.signals.values=-q(:,3);
m3.signals.dimensions = 1;
m3.signals.label = 'm3';
save m3.mat m3

m4.time=0.01:0.01:10;
m4.signals.values=q(:,4);
m4.signals.dimensions = 1;
m4.signals.label = 'm4';
save m4.mat m4

m5.time=0.01:0.01:10;
m5.signals.values=-q(:,5);
m5.signals.dimensions = 1;
m5.signals.label = 'm5';
save m5.mat m5

m6.time=0.01:0.01:10;
m6.signals.values=q(:,6);
m6.signals.dimensions = 1;
m6.signals.label = 'm6';
save m6.mat m6

