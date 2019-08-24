

% Linkdata=load('Linkdata.mat');
% setappdata(0,'F1',Linkdata.F1);
% setappdata(0,'L1',Linkdata.L1);
% setappdata(0,'F2',Linkdata.F2);
% setappdata(0,'L2',Linkdata.L2);
% setappdata(0,'F31',Linkdata.F31);
% setappdata(0,'L31',Linkdata.L31);
% setappdata(0,'F32',Linkdata.F32);
% setappdata(0,'L32',Linkdata.L32);
% setappdata(0,'F33',Linkdata.F33);
% setappdata(0,'L33',Linkdata.L33);
% setappdata(0,'F41',Linkdata.F41);
% setappdata(0,'L41',Linkdata.L41);
% setappdata(0,'F42',Linkdata.F42);
% setappdata(0,'L42',Linkdata.L42);
% setappdata(0,'F43',Linkdata.F43);
% setappdata(0,'L43',Linkdata.L43);
% setappdata(0,'F44',Linkdata.F44);
% setappdata(0,'L44',Linkdata.L44);
% setappdata(0,'F45',Linkdata.F45);
% setappdata(0,'L45',Linkdata.L45);
% setappdata(0,'F46',Linkdata.F46);
% setappdata(0,'L46',Linkdata.L46);
% setappdata(0,'C',Linkdata.Color);
% [x1,y1,z1,p1]=stlread('DELTA1 - dimian1-1.STL');
% % h1=patch(x1,y1,z1,[0.5 0 0]);
% h1=patch(x1,z1,y1,[0.5 0 0]);
% set(h1,'EdgeColor',[0.5 0 0])

 %获取连杆数据
%  Linkdata=load('Linkdata.mat');
% setappdata(0,'F1',Linkdata.F1);
% setappdata(0,'L1',Linkdata.L1);
% setappdata(0,'F2',Linkdata.F2);
% setappdata(0,'L2',Linkdata.L2);
% setappdata(0,'F31',Linkdata.F31);
% setappdata(0,'L31',Linkdata.L31);
% setappdata(0,'F32',Linkdata.F32);
% setappdata(0,'L32',Linkdata.L32);
% setappdata(0,'F33',Linkdata.F33);
% setappdata(0,'L33',Linkdata.L33);
% setappdata(0,'F41',Linkdata.F41);
% setappdata(0,'L41',Linkdata.L41);
% setappdata(0,'F42',Linkdata.F42);
% setappdata(0,'L42',Linkdata.L42);
% setappdata(0,'F43',Linkdata.F43);
% setappdata(0,'L43',Linkdata.L43);
% setappdata(0,'F44',Linkdata.F44);
% setappdata(0,'L44',Linkdata.L44);
% setappdata(0,'F45',Linkdata.F45);
% setappdata(0,'L45',Linkdata.L45);
% setappdata(0,'F46',Linkdata.F46);
% setappdata(0,'L46',Linkdata.L46);
% setappdata(0,'C',Linkdata.Color);
%         F1=getappdata(0,'F1');
%         V1=getappdata(0,'L1');
%         F2=getappdata(0,'F2');
%         V2=getappdata(0,'L2');
%         F31=getappdata(0,'F31');
%         V31=getappdata(0,'L31');
%         F32=getappdata(0,'F32');
%         V32=getappdata(0,'L32');
%         F33=getappdata(0,'F33');
%         V33=getappdata(0,'L33');
%         F41=getappdata(0,'F41');
%         V41=getappdata(0,'L41');
%         F42=getappdata(0,'F42');
%         V42=getappdata(0,'L42');
%         F43=getappdata(0,'F43');
%         V43=getappdata(0,'L43');
%         F44=getappdata(0,'F44');
%         V44=getappdata(0,'L44');
%         F45=getappdata(0,'F45');
%         V45=getappdata(0,'L45');
%         F46=getappdata(0,'F46');
%         V46=getappdata(0,'L46');
%         C=getappdata(0,'C');
% [x2,y2,z2,p2]=stlread('DELTA1 - dingmian-1.STL');
% % h2=patch(x2,y2,z2,[0 0 0]);
% h2=patch(x2,z2,y2,[0 0 0]);
% set(h2,'EdgeColor',[0 0 0]);
% F20=get(h2,'Faces');
% V20=get(h2,'Vertices');
% [m,n]=size(V2);
% L2=zeros(m,n+1);
% for i=1:1:m
%     L2(i,:)=[V1(i,:) 1];
% end
%  

        %绘制连杆
%         L1=patch('Faces',F1,'Vertices',V1(:,1:3));
%         set(L1,'FaceColor',C(1,:),'EdgeColor',C(1,:));
%         L2=patch('Faces',F2,'Vertices',V2(:,1:3));
%         set(L2,'FaceColor',C(2,:),'EdgeColor',C(2,:));
%         L31=patch('Faces',F31,'Vertices',V31(:,1:3));
%         set(L31,'FaceColor',C(3,:),'EdgeColor',C(3,:));
%         L32=patch('Faces',F32,'Vertices',V32(:,1:3));
%         set(L32,'FaceColor',C(3,:),'EdgeColor',C(3,:));        
%         L33=patch('Faces',F33,'Vertices',V33(:,1:3));
%         set(L33,'FaceColor',C(3,:),'EdgeColor',C(3,:));
%         L41=patch('Faces',F41,'Vertices',V41(:,1:3));
%         set(L41,'FaceColor',C(4,:),'EdgeColor',C(4,:));
%         L42=patch('Faces',F42,'Vertices',V42(:,1:3));
%         set(L42,'FaceColor',C(4,:),'EdgeColor',C(4,:));  
%         L43=patch('Faces',F43,'Vertices',V43(:,1:3));
%         set(L43,'FaceColor',C(4,:),'EdgeColor',C(4,:));
%         L44=patch('Faces',F44,'Vertices',V44(:,1:3));
%         set(L44,'FaceColor',C(4,:),'EdgeColor',C(4,:));
%         L45=patch('Faces',F45,'Vertices',V45(:,1:3));
%         set(L45,'FaceColor',C(4,:),'EdgeColor',C(4,:));
%         L46=patch('Faces',F46,'Vertices',V46(:,1:3));
%         set(L46,'FaceColor',C(4,:),'EdgeColor',C(4,:));
%         
%          setappdata(0,'patch_h',[L1,L2,L31,L32,L33,L41,L42,L43,L44,...
%               L45,L46])



% [x2,y2,z2,p2]=stlread('DELTA1 - dingmian-1.STL');
% h2=patch(x2,y2,z2,[0 0 0]);
% h2=patch(x2,z2,y2,[0 0 0]);
% set(h2,'EdgeColor',[0 0 0]);
% F2=get(h2,'Faces');
% V2=get(h2,'Vertices');
% hold on 
%         L2=patch('Faces',F2,'Vertices',V2(:,1:3));
%         set(L2,'FaceColor',C(2,:),'EdgeColor',C(2,:));

q0=[pi/6 0 0];
x0=[1 0 1 0 1 0];
 R=220;
        r=65;
        l1=340;
        l2=500;
        a=45;
        z0=sqrt((l1+l2)^2-(R-r)^2);
        beta=asin((R-r)/(l1+l2));
x=fsolve(@(x) fc(q0,x), x0);%利用方程求解各个关节角
                %三个支链各个关节的角度求解
                %theta1为第一个单链的各个关节角度
                %theta2为第二个单链的各个关节角度
                %theta3为第三个单链的各个关节角度
                theta1=zeros(1,5);
                theta2=zeros(1,5);
                theta3=zeros(1,5);
                theta1(1)=q0(1);
                theta2(1)=q0(2);
                theta3(1)=q0(3);
                theta1(2)=x(1);
                theta1(3)=x(2);
                theta2(2)=x(3);
                theta2(3)=x(4);
                theta3(2)=x(5);
                theta3(3)=x(6);
                setappdata(0,'Theta1',[x(1) x(1) x(2)])
                setappdata(0,'Theta2',[x(3) x(3) x(4)])
                setappdata(0,'Theta3',[x(5) x(5) x(6)])
                %单链关节角度之间的关系
                theta1(4)=-theta1(3);
                theta1(5)=-theta1(1)-theta1(2);
                theta2(4)=-theta2(3);
                theta2(5)=-theta2(1)-theta2(2);
                theta3(4)=-theta3(3);
                theta3(5)=-theta3(1)-theta3(2);
                theta1(6)=theta1(3);
                theta2(6)=theta2(3);
                theta3(6)=theta3(3);
            %% 三个支链的单链雅克比矩阵的求解
                %各个参数的初值设置
                tw1=cell(1,6);
                tw2=cell(1,6);
                tw3=cell(1,6);
                q1=cell(1,6);
                q2=cell(1,6);
                q3=cell(1,6);
                w1=cell(1,6);
                w2=cell(1,6);
                w3=cell(1,6);
                T1=cell(1,6);
                T2=cell(1,6);
                T3=cell(1,6);
                %相邻连杆之间的变换矩阵
                R0=SE3.Rz(-2/3*pi); 
                R1=SE3.Rz(pi/2);
                % 第一个支链的关节方向向量
                w1{1}=[0 1 0]';
                w1{2}=w1{1};
                w1{5}=w1{2};
                w1{3}=[cos(beta) 0 sin(beta)]';
                w1{4}=w1{3};
                w1{6}=w1{3};
                %第一个关节的关节轴线经过的点
                q1{1}=[R 0 0]'+[0 0 20]';
                q1{2}=[R-l1*sin(beta) 0 l1*cos(beta)]'+[0 0 20]';
                q1{3}=[R-l1*sin(beta) a l1*cos(beta)]'+[0 0 20]';
                q1{4}=[r a z0]'+[0 0 20]';
                q1{5}=[r 0 z0]'+[0 0 20]';
                q1{6}=[R-l1*sin(beta) -a l1*cos(beta)]';
                % 支链1的相关旋量的求解
                for i=1:6
                    tw1{i}=Twist('R',w1{i},q1{i});
                    T1{i}=tw1{i}.T(theta1(i));
                end
                % 支链2的相关旋量的求解
                for i=1:6
                    q2{i}=R0.R*q1{i};
                    w2{i}=R0.R*w1{i};
                    tw2{i}=Twist('R',w2{i},q2{i});
                    T2{i}=tw2{i}.T(theta2(i));
                end
                % 支链3的相关旋量的求解
                for i=1:6
                    q3{i}=R0.R*R0.R*q1{i};
                    w3{i}=R0.R*R0.R*w1{i};
                    tw3{i}=Twist('R',w3{i},q3{i});
                    T3{i}=tw3{i}.T(theta3(i));
                end
         

            T1_01=T1{1};
            T1_12=T1{2};
            T1_23=T1{3};
            T1_34=T1{4};
            T1_45=T1{5};
            T1_26=T1{6};
            T2_01=T2{1};
            T2_12=T2{2};
            T2_23=T2{3};
            T2_34=T2{4};
            T2_45=T2{5};
            T2_26=T2{6};
            T3_01=T3{1};
            T3_12=T3{2};
            T3_23=T3{3};
            T3_34=T3{4};
            T3_45=T3{5};
            T3_26=T3{6};
            

            T1_01=T1_01;
            T1_02 = T1_01*T1_12;
            T1_03 = T1_02*T1_23;
            T1_04 = T1_03*T1_34;
            T1_05 = T1_04*T1_45;
            T1_06=T1_02*T1_26;
            T2_01=T2_01;
            T2_02 = T2_01*T2_12;
            T2_03 = T2_02*T2_23;
            T2_04 = T2_03*T2_34;
            T2_05 = T2_04*T2_45;
            T2_06=T2_02*T2_26;
            T3_01=T3_01;
            T3_02 = T3_01*T3_12;
            T3_03 = T3_02*T3_23;
            T3_04 = T3_03*T3_34;
            T3_05 = T3_04*T3_45;
            T3_06=T3_02*T3_26;
        