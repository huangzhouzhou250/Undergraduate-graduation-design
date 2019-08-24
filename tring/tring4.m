theta1=[0.28 0 -0.2 0 0 1];
T=Fkine(theta1);
m=tr2rpy(T);
T1=inv(rpy2tr(m))*T;
n=transl(T1);
rpy2tr(m)*transl(n);
p=IFKINE(n,m,theta1)
Fkine(p);

% m=[0 0.3 0.6];
% n=[0.3 0.3 0.4];
% p=IFKINE(m,n,theta1);
% T=Fkine(p);
% m=tr2rpy(T);
% T1=inv(rpy2tr(m))*T;
% n=transl(T1);