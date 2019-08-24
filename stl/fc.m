function y =fc(q,x)
%fc为delta正运动学求解过程
% q为输入的关节角度，x为待求解角度
%% 求解
%关节角度的设定
x11=q(1);
x21=q(2);
x31=q(3);
theta1=[x11 x(1) x(2) -x(2) -x11-x(1)];
theta2=[x21 x(3) x(4) -x(4) -x21-x(3)];
theta3=[x31 x(5) x(6) -x(6) -x31-x(5)];
% 相关参数的设置
R=220;
r=65;
L1=340;
L2=500;
a=45;
%初始位置和角度
z0=sqrt((L1+L2)^2-(R-r)^2);
beta=asin((R-r)/(L1+L2));
%% 相关旋量的求解
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

R0=SE3.Rz(-2/3*pi);

w1{1}=[0 1 0]';
w1{2}=w1{1};
w1{5}=w1{2};
w1{3}=[cos(beta) 0 sin(beta)]';
w1{4}=w1{3};

q1{1}=[R 0 0]';
q1{2}=[R-L1*sin(beta) 0 L1*cos(beta)]';
q1{3}=[R-L1*sin(beta) a L1*cos(beta)]';
q1{4}=[r a z0]';
q1{5}=[r 0 z0]';
%第一个支链相关旋量的求解
for i=1:5
    tw1{i}=Twist('R',w1{i},q1{i});
    T1{i}=tw1{i}.T(theta1(i));
end
%第二个支链相关旋量的求解
for i=1:5
    q2{i}=R0.R*q1{i};
    w2{i}=R0.R*w1{i};
    tw2{i}=Twist('R',w2{i},q2{i});
    T2{i}=tw2{i}.T(theta2(i));
end
%第三个支链相关旋量的求解
for i=1:5
    q3{i}=R0.R*R0.R*q1{i};
    w3{i}=R0.R*R0.R*w1{i};
    tw3{i}=Twist('R',w3{i},q3{i});
    T3{i}=tw3{i}.T(theta3(i));
end
%% 相关支链的指数积表达
T0=SE3(0,0,z0);
TST=cell(3);
TST{1}=T1{1}*T1{2}*T1{3}*T1{4}*T1{5}*T0.T;
TST{2}=T2{1}*T2{2}*T2{3}*T2{4}*T2{5}*T0.T;
TST{3}=T3{1}*T3{2}*T3{3}*T3{4}*T3{5}*T0.T;
%% 求解的设置
y(1)=TST{1}(1,4)-TST{2}(1,4);
y(2)=TST{1}(1,4)-TST{3}(1,4);
y(3)=TST{1}(2,4)-TST{2}(2,4);
y(4)=TST{1}(2,4)-TST{3}(2,4);
y(5)=TST{1}(3,4)-TST{2}(3,4);
y(6)=TST{1}(3,4)-TST{3}(3,4);
end

