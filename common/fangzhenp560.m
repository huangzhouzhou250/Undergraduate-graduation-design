%puma560����robotic toolbox�Ĺ켣����
y=0.600;
q=zeros(50,6);
q0=[0 0 0 0 0];
for i=1:50
%     �趨Ŀ��켣
    x=0.30*sin(2*pi/50*i);
    z=0.30*cos(2*pi/50*i);
%     Ŀ����λ����
    pose=[0 0 0];
    loca=[x,y,z];
%     ����õ��ؽڽǶ�λ��
    q1=IFKINE(loca,pose,q0);
    q0=q1;
    q(i,:)=q1;
    T=Fkine(q1);
    T=transl(T);
%     ��ȡĿ���λ��
    m=T(1);
    n=T(2);
    k=T(3);
%     Ŀ��켣�Ļ���
    H1=plot3(x,y,z,'b.');
%     ������ĩ����λ�Ĺ켣
    H2=plot3(m,n,k,'r.');
    hold on; 
end
% ���û�����ģ�Ͳ�����
  p560A;
  p560a.plot(q+qn);
  title('PUMA560�˶�ѧ����');
  legend([H1,H2],'Ŀ��켣','����켣');
  
    