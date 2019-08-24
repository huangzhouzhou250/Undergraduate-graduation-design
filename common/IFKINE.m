function [ theta ] = IFKINE(location,pose,theta0)
%IFKINEΪpuma560���˶�ѧ���⣬����Paden������
% locationΪĩ�˹�������ϵ��λ�ã�pose��������ϵ����̬;
%theta0Ϊ����Ŀ��ؽڽǣ�����������Ϊ[0 0 0 0 0 0];
%thetaΪ����ĵõ��ĸ����ؽڵĽǶȣ��ý�ֻ�����е�һ���
%% ������ز����ı���
p=pose;
l=location';
%��������ϵ��λ�˾���
Tp=rpy2tr(p);
% Tp=Tp*transl(l);
Tp=transl(l)*Tp;
%theta�ĳ�ֵ
if nargin==3
    theta1=theta0;
else
    theta1=zeros(1,6);
end
theta=zeros(1,6);
%% ���������˸������ߵ�����
%���˲���������
a2=0.4318;
a3=0.0203;
d2=0.15005;
d4=0.4318;
% �ؽ������ϵ�һ��
r=cell(1,6);
r{1}=[0 0 0]';
r{2}=[-d2 0 0]';
r{3}=[-d2 a2 0]';
r{4}=[-d2 a2+d4 a3]';
r{5}=[-d2 a2+d4 a3]';
r{6}=[-d2 a2+d4 a3]';
%�ؽ��˶��ķ���
w=cell(1,6);
w{1}=[0 0 1]';
w{2}=[-1 0 0]';
w{3}=[-1 0 0]';
w{4}=[0 1 0]';
w{5}=[-1 0 0]';
w{6}=[0 0 1]';
%�����ؽڵ����������
tw=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},r{i});
end
%% ���theta��3��
%ȡtw{4}��tw{5}��tw{6}�Ľ����tw{1}��tw{2}�Ľ��㣬����theta(3)���
% ��ز�������������
l1=[-d2 a2+d4 a3];
l0=[-d2 a2+d4 a3]';%tw{4},tw{5},tw{6}�Ľ���
T0=SE3(l1);
T=Tp*inv(T0.T);
pb=[0 0 0]';%tw{1}��tw{2}�Ľ���
de=SE3(T)*l0-pb;
De=norm(de);
% theta(3)����⣬Paden3�Ŀ��Ծ���ο����������
[x1,x2]=Paden3(tw{3},l0,pb,De);
% �жϲ�ѡȡ���ʵĽǶ�
if abs(theta1(3)-x1)<=abs(theta1(3)-x2)
    theta(3)=x1;
else
    theta(3)=x2;
end
%% ���theta(1)��theta(2)
%��ز�������������
T3=tw{3}.T(theta(3));
p2=SE3(T3)*l0;
q2=SE3(T)*l0;
%theta(1)��theta(2)����⣬Paden2�Ŀ��Ծ���ο����������
[x1,x2,x3,x4]=Paden2(tw{1},tw{2},p2,q2,pb);
% �жϲ�ѡȡ����Ŀ��ǶȵĽǶ����
m=norm(theta1(1:2)-[x1 x3]);
n=norm(theta1(1:2)-[x2 x4]);
if abs(m)<=abs(n)
    theta(1)=x1;
    theta(2)=x3;
else
    theta(1)=x2;
    theta(2)=x4;
end
%% ���theta��4����theta��5 ��
%��ز�������������
T1=tw{1}.T(theta(1));
T2=tw{2}.T(theta(2));
T3=tw{3}.T(theta(3));
Ta=inv(T1*T2*T3)*T;
p3=l0+w{6};
q3=SE3(Ta)*p3;
%theta(4)��theta(5)����⣬Paden2�Ŀ��Ծ���ο����������
[x1,x2,x3,x4]=Paden2(tw{4},tw{5},p3,q3,l0)
% �жϲ�ѡȡ���ʵĽǶ�
m=norm(theta1(4:5)-[x1 x3]);
n=norm(theta1(4:5)-[x2 x4]);
if abs(m)<=abs(n)
    theta(4)=x1;
    theta(5)=x3;
else
    theta(4)=x2;
    theta(5)=x4;
end
%% ���theta��6��
T4=tw{4}.T(theta(4));
T5=tw{5}.T(theta(5));
Tb=inv(T4*T5)*Ta;
p4=[0 0 0]';
q4=SE3(Tb)*p4;
theta(6)=Paden1(tw{6},p4,q4);
T6=tw{6}.T(theta(6));
end
 