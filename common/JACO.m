function [J] = JACO( theta )
%JACO 求解puma560的雅克比矩阵
%   该函数是依据指数积方法进行求解的。
%theta为关节角度，J为雅克比矩阵
%% 设定相关参数初值
J=zeros(6,6);
a2=0.4318;
a3=0.0203;
d2=0.15005;
d4=0.4318;
%% 建立旋量和求解李代数矩阵
%各个关节运动轴线经过的点
r=cell(1,6);
r{1}=[0 0 0]';
r{2}=[-d2 0 0]';
r{3}=[-d2 a2 0]';
r{4}=[-d2 a2+d4 a3]';
r{5}=[-d2 a2+d4 a3]';
r{6}=[-d2 a2+d4 a3]';
%各个关节运动轴线方向
w=cell(1,6);
w{1}=[0 0 1]';
w{2}=[-1 0 0]';
w{3}=[-1 0 0]';
w{4}=[0 1 0]';
w{5}=[-1 0 0]';
w{6}=[0 0 1]';
%各个关节的运动旋量
tw=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},r{i});
end
%% 求解雅克比矩阵
for j=1:6
    AD=SE3(eye(4));
    for i=1:j
      if i==1
         AD=SE3(eye(4));
      else
         AD=AD*SE3(tw{i-1}.T(theta(i-1)));
      end
    end
    J(:,j)=AD.Ad*(tw{i}.double)';
end
end

