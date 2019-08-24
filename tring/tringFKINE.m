syms theta real;
% p=pose;
% l=location';
p=[-1 0 0];
l=[-0.1491 0.6829 -0.3534]';
% Tp=rpy2tr(p);
% Tp=Tp*transl(l)
theta=zeros(1,6);
%% 建立机器人各个轴线的旋量
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
w{6}=[0 0 1]';

tw=cell(1,6);
% T=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},r{i});
%     T{i}=tw{i}.T(theta(i)); 
end
%% 求解theta（3）
l0=[-d2 a2+d4 a3]';
Tp=transl(l);
Tp=Tp*rpy2tr(p);
T0=SE3(l0);
T1=Tp*inv(T0.T);
pb=[0 0 0]';
de=SE3(T1)*l-pb;
De=norm(de);
theta(3)=Paden3(tw{3},l,pb,De);
%% 求解theta(1)和theta(2)
T3=tw{3}.T(theta(3)); 
p2=SE3(T3)*l
q2=SE3(T1)*l
[theta(1),theta(2)]=Paden2(tw{1},tw{2},p2,q2,pb);
%% 求解theta4和theta5 
T2=tw{3}.T(-theta(3))*tw{2}.T(-theta(2))*tw{1}.T(-theta(1))*Tp*inv(T0.T);
p3=l+w{6}
q3=SE3(T2)*p3
[theta(4),theta(5)]=Paden2(tw{4},tw{5},p3,q3,l);