function delta_fangzhen
%delta机器人的仿真系统
%% 初始化
    loaddata
    initial
    %% 主体界面绘制
    % Create buttons
demo = uicontrol(fig,'String','演示','callback',@demo_button_press,...
    'Position',[20 5 60 20]);

rnd_demo = uicontrol(fig,'String','随机运动','callback',@rnd_demo_button_press,...
    'Position',[100 5 80 20]);

clr_trail = uicontrol(fig,'String','清除轨迹','callback',@clr_trail_button_press,...
    'Position',[200 5 60 20]);
%
home = uicontrol(fig,'String','初始状态','callback',@home_button_press,...
    'Position',[280 5 70 20]);
%
% Kinematics Panel
%
K_p = uipanel(fig,...
    'units','pixels',...
    'Position',[20 45 270 200],...
    'Title','正运动学','FontSize',11);
IK_p = uipanel(fig,...
    'units','pixels',...
    'Position',[20 270 270 150],...
    'Title','逆运动学','FontSize',11);
TRIAL= uipanel(fig,...
    'units','pixels',...
    'Position',[20 450 270 150],...
    'Title','运动仿真','FontSize',11);
%

LD = 105; % Left, used to set the GUI.
HT = 18;  % Height
BT = 156; % Bottom

% Create buttons
demo = uicontrol(fig,'String','演示','callback',@demo_button_press,...
    'Position',[20 5 60 20]);

rnd_demo = uicontrol(fig,'String','随机运动','callback',@rnd_demo_button_press,...
    'Position',[100 5 80 20]);

clr_trail = uicontrol(fig,'String','清除轨迹','callback',@clr_trail_button_press,...
    'Position',[200 5 60 20]);
%
home = uicontrol(fig,'String','初始状态','callback',@home_button_press,...
    'Position',[280 5 70 20]);
% 
% twist_out= uipanel(fig,...
%     'units','pixels',...
%     'Position',[1100 250 250 200],...
%     'Title','支链1旋量输出','FontSize',11);
%% 主动关节角度
t11_slider = uicontrol(K_p,'style','slider',...
    'Max',120,'Min',0,'Value',0,...
    'SliderStep',[0.05 0.2],...
    'callback',@t1_slider_button_press,...
    'Position',[LD BT 120 HT]);
t11_min = uicontrol(K_p,'style','text',...
    'String','0',...
    'Position',[LD-30 BT+1 25 HT-4]); % L, from bottom, W, H
t11_max = uicontrol(K_p,'style','text',...
    'String','+120',...
    'Position',[LD+125 BT+1 30 HT-4]); % L, B, W, H
t11_text = uibutton(K_p,'style','text',...  % Nice program Doug. Need this
    'String','\theta_11',...                % due to no TeX in uicontrols. 
    'Position',[LD-100 BT 20 HT]); % L, B, W, H
% t1_text = uicontrol(K_p,'style','text',... % when matlab fixes uicontrol
%     'String','t1',...                      % for TeX, then I can use this.  
%     'Position',[LD-100 BT 20 HT]); % L, B, W, H
t11_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t1_edit_button_press,...
    'Position',[LD-75 BT 30 HT]); % L, B, W, H

BT = 126;   % Bottom
t21_slider = uicontrol(K_p,'style','slider',...
    'Max',120,'Min',0,'Value',0,...        % Mech. stop limits !
    'SliderStep',[0.05 0.2],...
    'callback',@t2_slider_button_press,...
    'Position',[LD BT 120 HT]);
t21_min = uicontrol(K_p,'style','text',...
    'String','0',...
    'Position',[LD-30 BT+1 25 HT-4]); % L, from bottom, W, H
t21_max = uicontrol(K_p,'style','text',...
    'String','+120',...
    'Position',[LD+125 BT+1 30 HT-4]); % L, B, W, H
t21_text = uibutton(K_p,'style','text',...
    'String','\theta_21',...
    'Position',[LD-100 BT 20 HT]); % L, B, W, H
t21_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t2_edit_button_press,...
    'Position',[LD-75 BT 30 HT]); % L, B, W, H
%
BT = 96;   % Bottom
t31_slider = uicontrol(K_p,'style','slider',...
    'Max',120,'Min',0,'Value',0,...
    'SliderStep',[0.05 0.2],...
    'callback',@t3_slider_button_press,...
    'Position',[LD BT 120 HT]);
t31_min = uicontrol(K_p,'style','text',...
    'String','0',...
    'Position',[LD-30 BT+1 25 HT-4]); % L, from bottom, W, H
t31_max = uicontrol(K_p,'style','text',...
    'String','+120',...
    'Position',[LD+125 BT+1 30 HT-4]); % L, B, W, H
t31_text = uibutton(K_p,'style','text',...
    'String','\theta_31',...
    'Position',[LD-100 BT 20 HT]); % L, B, W, H
t31_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t3_edit_button_press,...
    'Position',[LD-75 BT 30 HT]); % L, B, W, H
%
BT=36;
t1_text = uibutton(K_p,'style','text',...
    'String','参考角度',...
    'Position',[LD BT+30 20 HT]); % L, B, W, H

t12_text = uibutton(K_p,'style','text',...
    'String','\theta_12',...
    'Position',[LD-100 36 20 HT]); % L, B, W, H
t12_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t12_edit_button_press,...
    'Position',[LD-75 36 30 HT]); % L, B, W, H
t13_text = uibutton(K_p,'style','text',...
    'String','\theta_13',...
    'Position',[LD-100 6 20 HT]); % L, B, W, H
t13_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t13_edit_button_press,...
    'Position',[LD-75 6 30 HT]); % L, B, W, H

t22_text = uibutton(K_p,'style','text',...
    'String','\theta_22',...
    'Position',[LD-15 36 20 HT]); % L, B, W, H
t22_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t22_edit_button_press,...
    'Position',[LD+10 36 30 HT]); % L, B, W, H
t23_text = uibutton(K_p,'style','text',...
    'String','\theta_23',...
    'Position',[LD-15 6 20 HT]); % L, B, W, H
t23_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t23_edit_button_press,...
    'Position',[LD+10 6 30 HT]); % L, B, W, H

t32_text = uibutton(K_p,'style','text',...
    'String','\theta_32',...
    'Position',[LD+70 36 20 HT]); % L, B, W, H
t32_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t32_edit_button_press,...
    'Position',[LD+95 36 30 HT]); % L, B, W, H
t33_text = uibutton(K_p,'style','text',...
    'String','\theta_33',...
    'Position',[LD+70 6 20 HT]); % L, B, W, H
t33_edit = uicontrol(K_p,'style','edit',...
    'String',0,...
    'callback',@t33_edit_button_press,...
    'Position',[LD+95 6 30 HT]); % L, B, W, H

%% 逆运动学相关框图
%% 逆运动学控制
ikine = uicontrol(fig,'String','逆运动学','callback',@ikine_button_press,...
    'Position',[120 280 70 20]);
%% 位置输入框
weizhi_text = uibutton(IK_p,'style','text',...
    'String','位置','FontSize',10,...
    'Position',[LD-95 105 50 HT]); % L, B, W, H
p1_text = uibutton(IK_p,'style','text',...
    'String','x',...
    'Position',[LD-100 80 30 HT]); % L, B, W, H
p1_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@p1_edit_button_press,...
    'Position',[LD-75 80 30 HT]); % L, B, W, H
p2_text = uibutton(IK_p,'style','text',...
    'String','y',...
    'Position',[LD-100 60 30 HT]); % L, B, W, H
p2_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@p2_edit_button_press,...
    'Position',[LD-75 60 30 HT]); % L, B, W, H
p3_text = uibutton(IK_p,'style','text',...
    'String','z',...
    'Position',[LD-100 40 30 HT]); % L, B, W, H
p3_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@p2_edit_button_press,...
    'Position',[LD-75 40 30 HT]); % L, B, W, H
%% 参考角度
cankaojiaodu_text = uibutton(IK_p,'style','text',...
    'String','参考角度','FontSize',10,...
    'Position',[LD+35 105 50 HT]); % L, B, W, H
ip11_text = uibutton(IK_p,'style','text',...
    'String','\theta_11',...
    'Position',[LD-30 80 30 HT]); % L, B, W, H
ip11_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip11_edit_button_press,...
    'Position',[LD-5 80 30 HT]); % L, B, W, H
ip12_text = uibutton(IK_p,'style','text',...
    'String','\theta_12',...
    'Position',[LD-30 60 30 HT]); % L, B, W, H
ip12_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip12_edit_button_press,...
    'Position',[LD-5 60 30 HT]); % L, B, W, H
ip13_text = uibutton(IK_p,'style','text',...
    'String','\theta_13',...
    'Position',[LD-30 40 30 HT]); % L, B, W, H
ip13_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip13_edit_button_press,...
    'Position',[LD-5 40 30 HT]); % L, B, W, H
ip21_text = uibutton(IK_p,'style','text',...
    'String','\theta_21',...
    'Position',[LD+30 80 30 HT]); % L, B, W, H
ip21_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip21_edit_button_press,...
    'Position',[LD+55 80 30 HT]); % L, B, W, H
ip22_text = uibutton(IK_p,'style','text',...
    'String','\theta_22',...
    'Position',[LD+30 60 30 HT]); % L, B, W, H
ip22_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip22_edit_button_press,...
    'Position',[LD+55 60 30 HT]); % L, B, W, H
ip23_text = uibutton(IK_p,'style','text',...
    'String','\theta_23',...
    'Position',[LD+30 40 30 HT]); % L, B, W, H
ip23_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip23_edit_button_press,...
    'Position',[LD+55 40 30 HT]); % L, B, W, H
ip31_text = uibutton(IK_p,'style','text',...
    'String','\theta_31',...
    'Position',[LD+90 80 30 HT]); % L, B, W, H
ip31_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip31_edit_button_press,...
    'Position',[LD+115 80 30 HT]); % L, B, W, H
ip32_text = uibutton(IK_p,'style','text',...
    'String','\theta_32',...
    'Position',[LD+90 60 30 HT]); % L, B, W, H
ip32_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip32_edit_button_press,...
    'Position',[LD+115 60 30 HT]); % L, B, W, H
ip33_text = uibutton(IK_p,'style','text',...
    'String','\theta_33',...
    'Position',[LD+90 40 30 HT]); % L, B, W, H
ip33_edit = uicontrol(IK_p,'style','edit',...
    'String',0,...
    'callback',@ip33_edit_button_press,...
    'Position',[LD+115 40 30 HT]); % L, B, W, H
%% 轨迹仿真
trail_t = uicontrol(fig,'String','三角形','callback',@trialt_button_press,...
    'Position',[65 490 70 20]);
trail_r = uicontrol(fig,'String','圆形轨迹','callback',@trialr_button_press,...
    'Position',[65 530 70 20]);

%% 加载连杆初始数据
function loaddata
Linkdata=load('Linkdata.mat');
setappdata(0,'F10',Linkdata.F1);
setappdata(0,'L10',Linkdata.L1);
setappdata(0,'F20',Linkdata.F2);
setappdata(0,'L20',Linkdata.L2);
setappdata(0,'F310',Linkdata.F31);
setappdata(0,'L310',Linkdata.L31);
setappdata(0,'F320',Linkdata.F32);
setappdata(0,'L320',Linkdata.L32);
setappdata(0,'F330',Linkdata.F33);
setappdata(0,'L330',Linkdata.L33);
setappdata(0,'F410',Linkdata.F41);
setappdata(0,'L410',Linkdata.L41);
setappdata(0,'F420',Linkdata.F42);
setappdata(0,'L420',Linkdata.L42);
setappdata(0,'F430',Linkdata.F43);
setappdata(0,'L430',Linkdata.L43);
setappdata(0,'F440',Linkdata.F44);
setappdata(0,'L440',Linkdata.L44);
setappdata(0,'F450',Linkdata.F45);
setappdata(0,'L450',Linkdata.L45);
setappdata(0,'F460',Linkdata.F46);
setappdata(0,'L460',Linkdata.L46);
setappdata(0,'C',Linkdata.Color);

% F1=Linkdata.F1;
% L1=Linkdata.L1;
% F2=Linkdata.F2;
% L2=Linkdata.L2;
% F31=Linkdata.F31;
% L31=Linkdata.L31;
% F32=Linkdata.F32;
% L32=Linkdata.L32;
% F33=Linkdata.F33;
% L33=Linkdata.L33;
% F41=Linkdata.F41;
% L41=Linkdata.L41;
% F42=Linkdata.F42;
% L42=Linkdata.L42;
% F43=Linkdata.F43;
% L43=Linkdata.L43;
% F44=Linkdata.F44;
% L44=Linkdata.L44;
% F45=Linkdata.F45;
% L45=Linkdata.L45;
% F46=Linkdata.F46;
% L46=Linkdata.L46;
% C=Linkdata.Color;
end
%% 初始化函数
function initial
        set(0,'Units','pixels')
        dim = get(0,'ScreenSize');
        fig=figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-110],...
            'MenuBar','none','Name',' DELTA - Helix Drawing',...
            'NumberTitle','off','CloseRequestFcn',@del_app);
        hold on;
        %light('Position',[-1 0 0]);
        light                               % add a default light
        daspect([1 1 1])                    % Setting the aspect ratio
        view(135,25)
        xlabel('X'),ylabel('Y'),zlabel('Z');
        title('DELTA机器人仿真');
        
        axis([-500 500 -500 500 0 1000]);
%         axis([-1500 1500 -1500 1500 -1120 1500]);
        plot3([-1000 1000],[-1000,-1000],[-1000,-1000],'k')
        plot3([-1000,-1000],[-1000 1000],[-1000,-1000],'k')
        plot3([-1000,-1000],[-1000,-1000],[-1000,1000],'k')
        plot3([-1000,-1000],[1000,1000],[-1000,1000],'k')
        plot3([-1000 1000],[-1000,-1000],[1000,1000],'k')
        plot3([-1000,-1000],[-1000 1000],[1000,1000],'k')
     
        %获取连杆数据
        F1=getappdata(0,'F10');
        V1=getappdata(0,'L10');
        F2=getappdata(0,'F20');
        V2=getappdata(0,'L20');
        F31=getappdata(0,'F310');
        V31=getappdata(0,'L310');
        F32=getappdata(0,'F320');
        V32=getappdata(0,'L320');
        F33=getappdata(0,'F330');
        V33=getappdata(0,'L330');
        F41=getappdata(0,'F410');
        V41=getappdata(0,'L410');
        F42=getappdata(0,'F420');
        V42=getappdata(0,'L420');
        F43=getappdata(0,'F430');
        V43=getappdata(0,'L430');
        F44=getappdata(0,'F440');
        V44=getappdata(0,'L440');
        F45=getappdata(0,'F450');
        V45=getappdata(0,'L450');
        F46=getappdata(0,'F460');
        V46=getappdata(0,'L460');
        Co=getappdata(0,'C');

        %绘制连杆
        L1=patch('Faces',F1,'Vertices',V1(:,1:3));
        set(L1,'FaceColor',Co(1,:),'EdgeColor',Co(1,:));
        L2=patch('Faces',F2,'Vertices',V2(:,1:3));
        set(L2,'FaceColor',Co(2,:),'EdgeColor',Co(2,:));
        L31=patch('Faces',F31,'Vertices',V31(:,1:3));
        set(L31,'FaceColor',Co(3,:),'EdgeColor',Co(3,:));
        L32=patch('Faces',F32,'Vertices',V32(:,1:3));
        set(L32,'FaceColor',Co(3,:),'EdgeColor',Co(3,:));        
        L33=patch('Faces',F33,'Vertices',V33(:,1:3));
        set(L33,'FaceColor',Co(3,:),'EdgeColor',Co(3,:));
        L41=patch('Faces',F41,'Vertices',V41(:,1:3));
        set(L41,'FaceColor',Co(4,:),'EdgeColor',Co(4,:));
        L42=patch('Faces',F42,'Vertices',V42(:,1:3));
        set(L42,'FaceColor',Co(4,:),'EdgeColor',Co(4,:));  
        L43=patch('Faces',F43,'Vertices',V43(:,1:3));
        set(L43,'FaceColor',Co(4,:),'EdgeColor',Co(4,:));
        L44=patch('Faces',F44,'Vertices',V44(:,1:3));
        set(L44,'FaceColor',Co(4,:),'EdgeColor',Co(4,:));
        L45=patch('Faces',F45,'Vertices',V45(:,1:3));
        set(L45,'FaceColor',Co(4,:),'EdgeColor',Co(4,:));
        L46=patch('Faces',F46,'Vertices',V46(:,1:3));
        set(L46,'FaceColor',Co(4,:),'EdgeColor',Co(4,:));
        
         setappdata(0,'patch_h',[L1,L2,L31,L32,L33,L41,L42,L43,L44,...
              L45,L46])
          
        setappdata(0,'xtrail',0); % used for trail tracking.
        setappdata(0,'ytrail',0); % used for trail tracking.
        setappdata(0,'ztrail',0); % used for trail tracking.
        
        setappdata(0,'Thetaold',[0 0 0]);
        setappdata(0,'Theta1',[0 0 0]);
        setappdata(0,'Theta2',[0 0 0]);
        setappdata(0,'Theta3',[0 0 0]);
end


%% 运动学求解
    function pumaANI(theta1,theta2,theta3,theta4,theta5,theta6,n,trail)
        % This function will animate the Puma robot given joint angles.
        % n is number of steps for the animation
        % trail is 'y' or 'n' (n = anything else) for leaving a trail.
        %
        %disp('in animate');
        R=220;
        r=65;
        L1=340;
        L2=500;
        a=45;
        % Err2 = 0;
        %
        ThetaOld = getappdata(0,'ThetaOld');
        %
        theta1old = ThetaOld(1);
        theta2old = ThetaOld(2);
        theta3old = ThetaOld(3);
        theta4old = ThetaOld(4);
        theta5old = ThetaOld(5);
        theta6old = ThetaOld(6);
        %
        t1 = jtraj(theta1old,theta1,n); 
        t2 = jtraj(theta2old,theta2,n); 
        t3 = jtraj(theta3old,theta3,n);% -180;  
        t4 = jtraj(theta4old,theta4,n); 
        t5 = jtraj(theta5old,theta5,n); 
        t6 = jtraj(theta6old,theta6,n); 

        n = length(t1);
        for i = 2:1:n
            % Forward Kinematics
            %
            theta=[t1(i) t2(i) t3(i)+90 t4(i) t5(i)-90 t6(i)]*pi/180;
            r=cell(1,6);
            r{1}=[0 0 0]';
            r{2}=[0 d3 0]';
            r{3}=[a2 d3 0]';
            r{4}=[a2+d4 d3 a3]';
            r{5}=[a2+d4 d3 a3]';
            r{6}=[a2+d4 d3 a3]';
            %w为各个轴线的旋转轴的方向
            w=cell(1,6);
            w{1}=[0 0 1]';
            w{2}=[0 1 0]';
            w{3}=[0 1 0]';
            w{4}=[1 0 0]';
            w{5}=[0 1 0]';
            w{6}=[1 0 0 ]';
            %tw为旋量，T为各个旋量对应角度的变换矩阵
            tw=cell(1,6);
            T=cell(1,6);
            for i=1:6
                tw{i}=Twist('R',w{i},r{i});
                T{i}=tw{i}.T(theta(i)); %各个旋量对应变换矩阵的求解
            end
            %  T的求解
            T_01=T{1};
            T_12=T{2};
            T_23=T{3};
            T_34=T{4};
            T_45=T{5};
            T_56=T{6};

            S_01 = tmat(0, 0, 0, 0);
            S_12 = tmat(-90, 0, 0,0);
            S_23 = tmat(0, a2, d3,-90);
            S_34 = tmat(-90, a3, d4, 0);
            S_45 = tmat(90, 0, 0, 0);
            S_56 = tmat(-90, 0, 0, -90);
            S_02=S_01*S_12;
            S_03=S_02*S_23;
            S_04=S_03*S_34;
            S_05=S_04*S_45;
            S_06=S_05*S_56;
            
        % Each link fram to base frame transformation
%         T_01=T_01;
        T_02 = T_01*T_12*S_02;
        T_03 = T_01*T_12*T_23*S_03;
        T_04 = T_01*T_12*T_23*T_34*S_04;
        T_05 = T_01*T_12*T_23*T_34*T_45*S_05;
        T_06 = T_01*T_12*T_23*T_34*T_45*T_56*S_06;
 
%             T_01 = tmat(0, 0, 0, t1(i));
%             T_12 = tmat(-90, 0, 0, t2(i));
%             T_23 = tmat(0, a2, d3, t3(i));
%             T_34 = tmat(-90, a3, d4, t4(i));
%             T_45 = tmat(90, 0, 0, t5(i));
%             T_56 = tmat(-90, 0, 0, t6(i));
% 
%             S_01 = tmat(0, 0, 0,0);
%             S_12 = tmat(-90, 0, 0,0);
%             S_23 = tmat(0, a2, d3,0);
%             S_34 = tmat(-90, a3, d4, 0);
%             S_45 = tmat(90, 0, 0, 0);
%             S_56 = tmat(-90, 0, 0, 0);
%             S_02=S_01*S_12;
%             S_03=S_02*S_23;
%             S_04=S_03*S_34;
%             S_05=S_04*S_45;
%             S_06=S_05*S_56;
% 
% % 
% %             %     T_67 = [   1            0      0 0
% %             %                0            1      0 0
% %             %                0            0      1 188
% %             %                0            0      0 1];
% 
%             %T_01 = T_01;  % it is, but don't need to say so.
%             T_01=T_01*S_01;
%             T_02 = T_01*T_12*S_02;
%             T_03 = T_02*T_23*S_03;
%             T_04 = T_03*T_34*S_04;
%             T_05 = T_04*T_45*S_05;
%             T_06 = T_05*T_56*S_06;
            %     T_07 = T_06*T_67;
            %
            s1 = getappdata(0,'Link1_data');
            s2 = getappdata(0,'Link2_data');
            s3 = getappdata(0,'Link3_data');
            s4 = getappdata(0,'Link4_data');
            s5 = getappdata(0,'Link5_data');
            s6 = getappdata(0,'Link6_data');
            s7 = getappdata(0,'Link7_data');
            %A1 = getappdata(0,'Area_data');

            Link1 = s1.V1;
            Link2 = (T_01*s2.V2')';
            Link3 = (T_02*s3.V3')';
            Link4 = (T_03*s4.V4')';
            Link5 = (T_04*s5.V5')';
            Link6 = (T_05*s6.V6')';
            Link7 = (T_06*s7.V7')';
            %     Tool = T_07;

            %     if sqrt(Tool(1,4)^2+Tool(2,4)^2)<514
            %         Err2 = 1;
            %         break
            %     end
            %
            handles = getappdata(0,'patch_h');           %
            L1 = handles(1);
            L2 = handles(2);
            L3 = handles(3);
            L4 = handles(4);
            L5 = handles(5);
            L6 = handles(6);
            L7 = handles(7);
            A1=handles(8);
            Tr = handles(9);
            Tw11= handles(10);
            Tw12= handles(11);
            Tw21= handles(12);
            Tw22= handles(13);
            Tw31= handles(14);
            Tw32= handles(15);
            Tw41= handles(16);
            Tw42= handles(17);
            Tw51= handles(18);
            Tw52= handles(19);
            Tw61= handles(20);
            Tw62= handles(21);
            %
            set(L1,'vertices',Link1(:,1:3),'facec', [0.717,0.116,0.123]);
            set(L1, 'EdgeColor','none');
            set(L2,'vertices',Link2(:,1:3),'facec', [0.216,1,.583]);
            set(L2, 'EdgeColor','none');
            set(L3,'vertices',Link3(:,1:3),'facec', [0.306,0.733,1]);
            set(L3, 'EdgeColor','none');
            set(L4,'vertices',Link4(:,1:3),'facec', [1,0.542,0.493]);
            set(L4, 'EdgeColor','none');
            set(L5,'vertices',Link5(:,1:3),'facec', [0.216,1,.583]);
            set(L5, 'EdgeColor','none');
            set(L6,'vertices',Link6(:,1:3),'facec', [1,1,0.255]);
            set(L6, 'EdgeColor','none');
            set(L7,'vertices',Link7(:,1:3),'facec', [0.306,0.733,1]);
            set(L7, 'EdgeColor','none');
            %
            t0=theta*180/pi+[-90 0 0 0 90 0];
            set(t1_edit,'string',num2str(t0(1)));
            set(t1_slider,'value',t0(1));
            set(t2_edit,'string',num2str(t0(2)));
            set(t2_slider,'value',t0(2));
            set(t3_edit,'string',num2str(t0(3)));
            set(t3_slider,'value',t0(3));
            set(t4_edit,'string',num2str(t0(4)));
            set(t4_slider,'value',t0(4)); 
            set(t5_edit,'string',num2str(t0(5)));
            set(t5_slider,'value',t0(5)); 
            set(t6_edit,'string',num2str(t0(6)));
            set(t6_slider,'value',t0(6));            
            %显示旋量
%             hold on;
%             p10=[0 0 0]; 
%             p11=[0 0 1000];
%             h1=arrow3(p10,p11,'w',2);
%             h11=h1(1);
%             h12=h1(2);
%             a1=get(h11,'xdata');
%             b1=get(h11,'ydata');
%             c1=get(h11,'zdata');
%             d1=get(h12,'XData');
%             e1=get(h12,'YData');
%             f1=get(h12,'ZData');
%             h111=arrow3([0 0 0],[1 1 1],'r',2);
%             Tw11=h111(1);
%             Tw12=h111(2);
%             set(Tw12,'xdata',d1,'ydata',e1,'zdata',f1);
%             set(Tw11,'xdata',a1,'ydata',b1,'zdata',c1);
            %

            p20=[0 d3 0]';
            p21=(p20+1000*w{2})';
            p30=r{3};
            p31=p30+1000*w{3};
            p40=r{4};
            p41=p40+800*w{4};
            p50=r{5};
            p51=p50+1000*w{5};
            p60=r{6};
            p61=p60+1000*w{6};     
            m=arrow3([-2000 -2000 -1500],[2000 2000 1500]);
            n1=m(1);
            n2=m(2);
            T01=T{1};
            p20=SE3(T01)*p20;
            p21=SE3(T01)*p21';
            hold on;
            h2=arrow3(p20',p21','r',2);
            h21=h2(1);
            h22=h2(2);
            aa2=get(h21,'xdata');
            bb2=get(h21,'ydata');
            cc2=get(h21,'zdata');
            dd2=get(h22,'xdata');
            ee2=get(h22,'ydata');
            ff2=get(h22,'zdata');
            set(Tw22,'xdata',dd2,'ydata',ee2,'zdata',ff2);
            set(Tw21,'xdata',aa2,'ydata',bb2,'zdata',cc2); 
            delete(h2);
            T02=T{1}*T{2};
            p30=SE3(T02)*p30; 
            p31=SE3(T02)*p31;
            h3=arrow3(p30',p31','r',2);
            h31=h3(1);
            h32=h3(2);
            aa3=get(h31,'xdata');
            bb3=get(h31,'ydata');
            cc3=get(h31,'zdata');
            dd3=get(h32,'xdata');           
            ee3=get(h32,'ydata');
            ff3=get(h32,'zdata');
            set(Tw32,'xdata',dd3,'ydata',ee3,'zdata',ff3);
            set(Tw31,'xdata',aa3,'ydata',bb3,'zdata',cc3);
            delete(h3);
            % 
            T03=T{1}*T{2}*T{3};
            p40=SE3(T03)*p40; 
            p41=SE3(T03)*p41;
            h4=arrow3(p40',p41','r',2);
            h41=h4(1);
            h42=h4(2);
            aa4=get(h41,'xdata');
            bb4=get(h41,'ydata');
            cc4=get(h41,'zdata');
            dd4=get(h42,'xdata');           
            ee4=get(h42,'ydata');
            ff4=get(h42,'zdata');
            set(Tw42,'xdata',dd4,'ydata',ee4,'zdata',ff4);
            set(Tw41,'xdata',aa4,'ydata',bb4,'zdata',cc4);
            delete(h4);
            %
            T04=T{1}*T{2}*T{3}*T{4};
            p50=SE3(T04)*p50; 
            p51=SE3(T04)*p51;
            h5=arrow3(p50',p51','r',2);
            h51=h5(1);
            h52=h5(2);
            aa5=get(h51,'xdata');
            bb5=get(h51,'ydata');
            cc5=get(h51,'zdata');
            dd5=get(h52,'xdata');           
            ee5=get(h52,'ydata');
            ff5=get(h52,'zdata');
            set(Tw52,'xdata',dd5,'ydata',ee5,'zdata',ff5);
            set(Tw51,'xdata',aa5,'ydata',bb5,'zdata',cc5);
            delete(h5);
            %
            T05=T{1}*T{2}*T{3}*T{4}*T{5};
            p60=SE3(T05)*p60; 
            p61=SE3(T05)*p61;
            h6=arrow3(p60',p61','r',2);
            h61=h6(1);
            h62=h6(2);
            aa6=get(h61,'xdata');
            bb6=get(h61,'ydata');
            cc6=get(h61,'zdata');
            dd6=get(h62,'xdata');           
            ee6=get(h62,'ydata');
            ff6=get(h62,'zdata');
            set(Tw62,'xdata',dd6,'ydata',ee6,'zdata',ff6);
            set(Tw61,'xdata',aa6,'ydata',bb6,'zdata',cc6);
            delete(h6);
            delete(m);
            clear m;
            %
            J=Jacopuma(theta);
            ks1=mat2str((J(:,1))');
            ks2=mat2str((J(:,2))');
            ks3=mat2str((J(:,3))');
            ks4=mat2str((J(:,4))');
            ks5=mat2str((J(:,5))');
            ks6=mat2str((J(:,6))');
%             ks6=num2str([10 20 30 40 50 60]);
            set(ks1_edit,'string',ks1);
            set(ks2_edit,'string',ks2);
            set(ks3_edit,'string',ks3);
            set(ks4_edit,'string',ks4);
            set(ks5_edit,'string',ks5);
            set(ks6_edit,'string',ks6);
            % store trail in appdata 
            if trail == 'y'
                x_trail = getappdata(0,'xtrail');
                y_trail = getappdata(0,'ytrail');
                z_trail = getappdata(0,'ztrail');
                %
                xdata = [x_trail T_04(1,4)];
                ydata = [y_trail T_04(2,4)];
                zdata = [z_trail T_04(3,4)];
                %
                setappdata(0,'xtrail',xdata); % used for trail tracking.
                setappdata(0,'ytrail',ydata); % used for trail tracking.
                setappdata(0,'ztrail',zdata); % used for trail tracking.
                %
                set(Tr,'xdata',xdata,'ydata',ydata,'zdata',zdata);
            end
            drawnow
        end
        setappdata(0,'ThetaOld',[theta1,theta2,theta3,theta4,theta5,theta6]);
    end
%% 删除图形函数
function del_app(varargin)
        %This is the main figure window close function, to remove any
        % app data that may be left due to using it for geometry.
        %CloseRequestFcn
        % here is the data to remove:
        %     Link1_data: [1x1 struct]
        %     Link2_data: [1x1 struct]
        %     Link3_data: [1x1 struct]
        %     Link4_data: [1x1 struct]
        %     Link5_data: [1x1 struct]
        %     Link6_data: [1x1 struct]
        %     Link7_data: [1x1 struct]
        %      Area_data: [1x1 struct]
        %        d3: [1x9 double]
        %       ThetaOld: [90 -182 -90 -106 80 106]
        %         xtrail: 0
        %         ytrail: 0
        %         ztrail: 0
        % Now remove them.

        rmappdata(0,'patch_h');
%         rmappdata(0,'xtrail');
%         rmappdata(0,'ytrail');
%         rmappdata(0,'ztrail');
        delete(fig);
end
%% 附加函数
 function user_entry = check_edit(h,min_v,max_v,default,h_edit)
        % This function will check the value typed in the text input box
        % against min and max values, and correct errors.
        %
        % h: handle of gui
        % min_v min value to check
        % max_v max value to check
        % default is the default value if user enters non number
        % h_edit is the edit value to update.
        %
        user_entry = str2double(get(h,'string'));
        if isnan(user_entry)
            errordlg(['You must enter a numeric value, defaulting to ',num2str(default),'.'],'Bad Input','modal')
            set(h_edit,'string',default);
            user_entry = default;
        end
        %
        if user_entry < min_v
            errordlg(['Minimum limit is ',num2str(min_v),' degrees, using ',num2str(min_v),'.'],'Bad Input','modal')
            user_entry = min_v;
            set(h_edit,'string',user_entry);
        end
        if user_entry > max_v
            errordlg(['Maximum limit is ',num2str(max_v),' degrees, using ',num2str(max_v),'.'],'Bad Input','modal')
            user_entry = max_v;
            set(h_edit,'string',user_entry);
        end
 end

function [hout,ax_out] = uibutton(varargin)
        %uibutton: Create pushbutton with more flexible labeling than uicontrol.
        % Usage:
        %   uibutton accepts all the same arguments as uicontrol except for the
        %   following property changes:
        %
        %     Property      Values
        %     -----------   ------------------------------------------------------
        %     Style         'pushbutton', 'togglebutton' or 'text', default =
        %                   'pushbutton'.
        %     String        Same as for text() including cell array of strings and
        %                   TeX or LaTeX interpretation.
        %     Interpreter   'tex', 'latex' or 'none', default = default for text()
        %
        % Syntax:
        %   handle = uibutton('PropertyName',PropertyValue,...)
        %   handle = uibutton(parent,'PropertyName',PropertyValue,...)
        %   [text_obj,axes_handle] = uibutton('Style','text',...
        %       'PropertyName',PropertyValue,...)
        %
        % uibutton creates a temporary axes and text object containing the text to
        % be displayed, captures the axes as an image, deletes the axes and then
        % displays the image on the uicontrol.  The handle to the uicontrol is
        % returned.  If you pass in a handle to an existing uicontol as the first
        % argument then uibutton will use that uicontrol and not create a new one.
        %
        % If the Style is set to 'text' then the axes object is not deleted and the
        % text object handle is returned (as well as the handle to the axes in a
        % second output argument).
        %
        % See also UICONTROL.

        % Version: 1.6, 20 April 2006
        % Author:  Douglas M. Schwarz
        % Email:   dmschwarz=ieee*org, dmschwarz=urgrad*rochester*edu
        % Real_email = regexprep(Email,{'=','*'},{'@','.'})


        % Detect if first argument is a uicontrol handle.
        keep_handle = false;
        if nargin > 0
            h = varargin{1};
            if isscalar(h) && ishandle(h) && strcmp(get(h,'Type'),'uicontrol')
                keep_handle = true;
                varargin(1) = [];
            end
        end

        % Parse arguments looking for 'Interpreter' property.  If found, note its
        % value and then remove it from where it was found.
        interp_value = get(0,'DefaultTextInterpreter');
        arg = 1;
        remove = [];
        while arg <= length(varargin)
            v = varargin{arg};
            if isstruct(v)
                fn = fieldnames(v);
                for i = 1:length(fn)
                    if strncmpi(fn{i},'interpreter',length(fn{i}))
                        interp_value = v.(fn{i});
                        v = rmfield(v,fn{i});
                    end
                end
                varargin{arg} = v;
                arg = arg + 1;
            elseif ischar(v)
                if strncmpi(v,'interpreter',length(v))
                    interp_value = varargin{arg+1};
                    remove = [remove,arg,arg+1];
                end
                arg = arg + 2;
            elseif arg == 1 && isscalar(v) && ishandle(v) && ...
                    any(strcmp(get(h,'Type'),{'figure','uipanel'}))
                arg = arg + 1;
            else
                error('Invalid property or uicontrol parent.')
            end
        end
        varargin(remove) = [];

        % Create uicontrol, get its properties then hide it.
        if keep_handle
            set(h,varargin{:})
        else
            h = uicontrol(varargin{:});
        end
        s = get(h);
        if ~any(strcmp(s.Style,{'pushbutton','togglebutton','text'}))
            delete(h)
            error('''Style'' must be pushbutton, togglebutton or text.')
        end
        set(h,'Visible','off')

        % Create axes.
        parent = get(h,'Parent');
        ax = axes('Parent',parent,...
            'Units',s.Units,...
            'Position',s.Position,...
            'XTick',[],'YTick',[],...
            'XColor',s.BackgroundColor,...
            'YColor',s.BackgroundColor,...
            'Box','on',...
            'Color',s.BackgroundColor);
        % Adjust size of axes for best appearance.
        set(ax,'Units','pixels')
        pos = round(get(ax,'Position'));
        if strcmp(s.Style,'text')
            set(ax,'Position',pos + [0 1 -1 -1])
        else
            set(ax,'Position',pos + [4 4 -8 -8])
        end
        switch s.HorizontalAlignment
            case 'left'
                x = 0.0;
            case 'center'
                x = 0.5;
            case 'right'
                x = 1;
        end
        % Create text object.
        text_obj = text('Parent',ax,...
            'Position',[x,0.5],...
            'String',s.String,...
            'Interpreter',interp_value,...
            'HorizontalAlignment',s.HorizontalAlignment,...
            'VerticalAlignment','middle',...
            'FontName',s.FontName,...
            'FontSize',s.FontSize,...
            'FontAngle',s.FontAngle,...
            'FontWeight',s.FontWeight,...
            'Color',s.ForegroundColor);

        % If we are creating something that looks like a text uicontrol then we're
        % all done and we return the text object and axes handles rather than a
        % uicontrol handle.
        if strcmp(s.Style,'text')
            delete(h)
            if nargout
                hout = text_obj;
                ax_out = ax;
            end
            return
        end

        % Capture image of axes and then delete the axes.
        frame = getframe(ax);
        delete(ax)

        % Build RGB image, set background pixels to NaN and put it in 'CData' for
        % the uicontrol.
        if isempty(frame.colormap)
            rgb = frame.cdata;
        else
            rgb = reshape(frame.colormap(frame.cdata,:),[pos([4,3]),3]);
        end
        size_rgb = size(rgb);
        rgb = double(rgb)/255;
        back = repmat(permute(s.BackgroundColor,[1 3 2]),size_rgb(1:2));
        isback = all(rgb == back,3);
        rgb(repmat(isback,[1 1 3])) = NaN;
        set(h,'CData',rgb,'String','','Visible',s.Visible)

        % Assign output argument if necessary.
        if nargout
            hout = h;
        end

    end
end
