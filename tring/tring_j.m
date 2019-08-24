J=zeros(6,6);
theta=[0 0 0 0 0 0];
%% 建立旋量和求解李代数矩阵
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
T=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},r{i});
    T{i}=tw{i}.T(theta(i)); 
end
%% 求解雅克比矩阵
for j=1:6
    for x=1:j
        AD=SE3(eye(4));
      if x==1
         AD=SE3(eye(4));
      else
         AD=AD*tw{x-1}.SE;
      end
    end
    J(:,j)=AD.Ad*(tw{j}.double)';
end