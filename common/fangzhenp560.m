%puma560基于robotic toolbox的轨迹仿真
y=0.600;
q=zeros(50,6);
q0=[0 0 0 0 0];
for i=1:50
%     设定目标轨迹
    x=0.30*sin(2*pi/50*i);
    z=0.30*cos(2*pi/50*i);
%     目标形位设置
    pose=[0 0 0];
    loca=[x,y,z];
%     反解得到关节角度位置
    q1=IFKINE(loca,pose,q0);
    q0=q1;
    q(i,:)=q1;
    T=Fkine(q1);
    T=transl(T);
%     获取目标点位置
    m=T(1);
    n=T(2);
    k=T(3);
%     目标轨迹的绘制
    H1=plot3(x,y,z,'b.');
%     机器人末端形位的轨迹
    H2=plot3(m,n,k,'r.');
    hold on; 
end
% 调用机器人模型并仿真
  p560A;
  p560a.plot(q+qn);
  title('PUMA560运动学检验');
  legend([H1,H2],'目标轨迹','仿真轨迹');
  
    