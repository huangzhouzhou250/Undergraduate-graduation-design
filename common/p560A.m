%p560AΪ����robotic toolbox������ģ�ͽ��������˵ķ���ģ��
%% ������
% ���˲���
a2=0.4318;
a3=0.0203;
d2=0.15005;
d4=0.4318;
% ���˲�����D-H��������
%             th      d        a    alpha
L1 =   Link([0       0        0     0      0],'modified');
L2 =   Link([0       d2        0     -pi/2  0],'modified');
L3 =   Link([0       0       a2     0      0],'modified');
L4 =   Link([0       d4       a3     -pi/2  0],'modified');
L5 =   Link([0        0        0     pi/2   0],'modified');
L6 =   Link([0        0        0     -pi/2  0],'modified');
p560a=SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'PUMA560A');
% ��ؽǶȵ�����
qz=[0 0 0 0 0 0];
qn=[pi/2 0 -pi/2 0 0 0];