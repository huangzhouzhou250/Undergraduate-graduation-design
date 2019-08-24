 l1=10;
 l2=5;
theta=[0 pi/2 0 0];
J=zeros(6,4);
r=cell(4);
r{1}=[0 0 0]';
r{2}=[0 l1 0]';
r{3}=[0 l1+l2 0]';
r{4}=r{3};

w{1}=[0 0 1]';
w{2}=w{1};
w{3}=w{2};
w{4}=0;

tw=cell(4);

for i=1:3
    tw{i}=Twist('R',w{i},r{i});
%     T{i}=tw{i}.T(theta(i)); 
end
tw{4}=Twist('T',[0 0 1]');

for j=1:4
    for i=1:j
      if i==1
         AD=SE3(eye(4));
      else
         AD=AD*SE3(tw{i-1}.T(theta(i-1)));
      end
    end
    J(:,j)=AD.Ad*(tw{j}.double)';
end
J