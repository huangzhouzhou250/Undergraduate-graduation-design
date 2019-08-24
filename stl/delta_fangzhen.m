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
    'callback',@t11_slider_button_press,...
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
    'callback',@t11_edit_button_press,...
    'Position',[LD-75 BT 30 HT]); % L, B, W, H

BT = 126;   % Bottom
t21_slider = uicontrol(K_p,'style','slider',...
    'Max',120,'Min',0,'Value',0,...        % Mech. stop limits !
    'SliderStep',[0.05 0.2],...
    'callback',@t21_slider_button_press,...
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
    'callback',@t21_edit_button_press,...
    'Position',[LD-75 BT 30 HT]); % L, B, W, H
%
BT = 96;   % Bottom
t31_slider = uicontrol(K_p,'style','slider',...
    'Max',120,'Min',0,'Value',0,...
    'SliderStep',[0.05 0.2],...
    'callback',@t31_slider_button_press,...
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
    'callback',@t31_edit_button_press,...
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
    'String',-1,...
    'callback',@t12_edit_button_press,...
    'Position',[LD-75 36 30 HT]); % L, B, W, H
t13_text = uibutton(K_p,'style','text',...
    'String','\theta_13',...
    'Position',[LD-100 6 20 HT]); % L, B, W, H
t13_edit = uicontrol(K_p,'style','edit',...
    'String',-1,...
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
    'String',-1,...
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
    'String',0.5,...
    'callback',@ip11_edit_button_press,...
    'Position',[LD-5 80 30 HT]); % L, B, W, H
ip12_text = uibutton(IK_p,'style','text',...
    'String','\theta_12',...
    'Position',[LD-30 60 30 HT]); % L, B, W, H
ip12_edit = uicontrol(IK_p,'style','edit',...
    'String',-1,...
    'callback',@ip12_edit_button_press,...
    'Position',[LD-5 60 30 HT]); % L, B, W, H
ip13_text = uibutton(IK_p,'style','text',...
    'String','\theta_13',...
    'Position',[LD-30 40 30 HT]); % L, B, W, H
ip13_edit = uicontrol(IK_p,'style','edit',...
    'String',-1,...
    'callback',@ip13_edit_button_press,...
    'Position',[LD-5 40 30 HT]); % L, B, W, H
ip21_text = uibutton(IK_p,'style','text',...
    'String','\theta_21',...
    'Position',[LD+30 80 30 HT]); % L, B, W, H
ip21_edit = uicontrol(IK_p,'style','edit',...
    'String',0.5,...
    'callback',@ip21_edit_button_press,...
    'Position',[LD+55 80 30 HT]); % L, B, W, H
ip22_text = uibutton(IK_p,'style','text',...
    'String','\theta_22',...
    'Position',[LD+30 60 30 HT]); % L, B, W, H
ip22_edit = uicontrol(IK_p,'style','edit',...
    'String',-1,...
    'callback',@ip22_edit_button_press,...
    'Position',[LD+55 60 30 HT]); % L, B, W, H
ip23_text = uibutton(IK_p,'style','text',...
    'String','\theta_23',...
    'Position',[LD+30 40 30 HT]); % L, B, W, H
ip23_edit = uicontrol(IK_p,'style','edit',...
    'String',-1,...
    'callback',@ip23_edit_button_press,...
    'Position',[LD+55 40 30 HT]); % L, B, W, H
ip31_text = uibutton(IK_p,'style','text',...
    'String','\theta_31',...
    'Position',[LD+90 80 30 HT]); % L, B, W, H
ip31_edit = uicontrol(IK_p,'style','edit',...
    'String',0.5,...
    'callback',@ip31_edit_button_press,...
    'Position',[LD+115 80 30 HT]); % L, B, W, H
ip32_text = uibutton(IK_p,'style','text',...
    'String','\theta_32',...
    'Position',[LD+90 60 30 HT]); % L, B, W, H
ip32_edit = uicontrol(IK_p,'style','edit',...
    'String',-1,...
    'callback',@ip32_edit_button_press,...
    'Position',[LD+115 60 30 HT]); % L, B, W, H
ip33_text = uibutton(IK_p,'style','text',...
    'String','\theta_33',...
    'Position',[LD+90 40 30 HT]); % L, B, W, H
ip33_edit = uicontrol(IK_p,'style','edit',...
    'String',-1,...
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
        
        axis([-600 600 -600 600 -100 1100]);
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
        Tr = plot3(0,0,0,'b.');
         setappdata(0,'patch_h',[L1,L2,L31,L32,L33,L41,L42,L43,L44,...
              L45,L46,Tr])
          
        setappdata(0,'xtrail',0); % used for trail tracking.
        setappdata(0,'ytrail',0); % used for trail tracking.
        setappdata(0,'ztrail',0); % used for trail tracking.
        
        setappdata(0,'Thetaold',[0 0 0]);
        setappdata(0,'Theta1',[0 0 0]);
        setappdata(0,'Theta2',[0 0 0]);
        setappdata(0,'Theta3',[0 0 0]);
end
%% 
function setInitial()
        deltaANI(0,0,0,10,'n') % show it animate home
        %PumaPOS(90,-90,-90,0,0,0)  %drive it home, no animate.
        set(t11_edit,'string',0);
        set(t11_slider,'Value',0);  %At the home position, so all
        set(t21_edit,'string',0);   %sliders and input boxes = 0. 
        set(t21_slider,'Value',0);
        set(t31_edit,'string',0);
        set(t31_slider,'Value',0);
        setappdata(0,'Thetaold',[0 0 0]);
        setappdata(0,'Theta1',[0 0 0]);
        setappdata(0,'Theta2',[0 0 0]);
        setappdata(0,'Theta3',[0 0 0]);
    end
%%   关节1
function t11_slider_button_press(h,dummy)
        slider_value = round(get(h,'Value'));
        set(t11_edit,'string',slider_value);
        T_Old = getappdata(0,'Thetaold');
        t2old = T_Old(2); t3old = T_Old(3);
        deltaANI(slider_value,t2old,t3old,10,'n')
    end
%
function t11_edit_button_press(h,dummy)
        user_entry = check_edit(h,0,120,0,t11_edit);
        set(t11_slider,'Value',user_entry);  % slider = text box.
        T_Old = getappdata(0,'Thetaold');   % Current pose    
        %
        t2old = T_Old(2); t3old = T_Old(3); 
        %
        deltaANI(user_entry,t2old,t3old,10,'n')
end
%
%%   关节2
function t21_slider_button_press(h,dummy)
        slider_value = round(get(h,'Value'));
        set(t21_edit,'string',slider_value);
        T_Old = getappdata(0,'Thetaold');
        t1old = T_Old(1); t3old = T_Old(3);
        deltaANI(t1old,slider_value,t3old,10,'n')
    end
%
function t21_edit_button_press(h,dummy)
        user_entry = check_edit(h,0,120,0,t21_edit);
        set(t21_slider,'Value',user_entry);  % slider = text box.
        T_Old = getappdata(0,'Thetaold');   % Current pose    
        %
        t1old = T_Old(1); t3old = T_Old(3); 
        %
        deltaANI(t1old,user_entry,t3old,10,'n')
    end
%
%%   关节3
function t31_slider_button_press(h,dummy)
        slider_value = round(get(h,'Value'));
        set(t31_edit,'string',slider_value);
        T_Old = getappdata(0,'Thetaold');
        t1old = T_Old(1); t2old = T_Old(2);
        deltaANI(t1old,t2old,slider_value,10,'n')
    end
%
function t31_edit_button_press(h,dummy)
        user_entry = check_edit(h,0,120,0,t31_edit);
        set(t31_slider,'Value',user_entry);  % slider = text box.
        T_Old = getappdata(0,'Thetaold');   % Current pose    
        %
        t1old = T_Old(1); t2old = T_Old(2); 
        %
        deltaANI(t1old, t2old ,user_entry,10,'n')
    end
%% 演示
function demo_button_press(h,dummy)
        %
        % disp('pushed demo bottom');
        %         R = 500;
        %         x = 1000;
        n = 5;    % demo ani steps
        num = 10; % home to start, and end to home ani steps
        %         j = 1;
        %         M = 1000;
        for t = 0:.5:10*pi
            Px = 50*cos(t); %Px = 30*t*cos(t);
            Py = 50*sin(t); %Py = 1200-300*t*(t)/(50*pi);    %depth
            Pz = 600 - 20*t/pi; %Pz = 30*t*sin(t);
            %msg = sprintf('x=%f\ny=%f\nz=%f\n', Px, Py, Pz) ;
            %disp(msg);
            [theta1,theta2,theta3] = IFKINEdelta_fangzhen([Px Py Pz]);
            if t==0 %move to start of demo
                deltaANI(theta1(1),theta2(1),theta3(1),num,'n')
            end
            % Theta 4, 5 & 6 are zero due to plotting at wrist origen.
            deltaANI(theta1(1),theta2(1),theta3(1),n,'y')
            set(t11_edit,'string',round(theta1(1))); % Update slider and text.
            set(t11_slider,'Value',round(theta1(1)));
            set(t21_edit,'string',round(theta2(1)));
            set(t21_slider,'Value',round(theta2(1)));
            set(t31_edit,'string',round(theta3(1)));
            set(t31_slider,'Value',round(theta3(1)));
        end
        setInitial
%        pumaANI(90,-90,-90,0,0,0,num,'n')
end
%% 轨迹清除
function clr_trail_button_press(h,dummy)
        %disp('pushed clear trail bottom');
        handles = getappdata(0,'patch_h');           %
        Tr = handles(12);
        %
        setappdata(0,'xtrail',0); % used for trail tracking.
        setappdata(0,'ytrail',0); % used for trail tracking.
        setappdata(0,'ztrail',0); % used for trail tracking.
        %
        set(Tr,'xdata',0,'ydata',0,'zdata',0);
    end
%% 随机运动
function rnd_demo_button_press(h, dummy)
        %disp('pushed random demo bottom')

        theta1 = 20 + 20*rand(1); % offset for home
        theta2 =30 + 30*rand(1); % in the UP pos.
        theta3 =40 + 20*rand(1);
        n = 50;
        deltaANI(theta1,theta2,theta3,n,'y')
        set(t11_edit,'string',round(theta1)); % Update slider and text.
        set(t11_slider,'Value',round(theta1));
        set(t21_edit,'string',round(theta2));
        set(t21_slider,'Value',round(theta2));
        set(t31_edit,'string',round(theta3));
        set(t31_slider,'Value',round(theta3));
end
%%
function home_button_press(h,dummy)
        %disp('pushed home bottom');
        setInitial
    end
%% 运动学求解
function deltaANI(theta11,theta21,theta31,n,trail)
        % This function will animate the Puma robot given joint angles.
        % n is number of steps for the animation
        % trail is 'y' or 'n' (n = anything else) for leaving a trail.
        %
        %disp('in animate');
        R=220;
        r=65;
        l1=340;
        l2=500;
        a=45;
        z0=sqrt((l1+l2)^2-(R-r)^2);
        beta=asin((R-r)/(l1+l2));
        % Err2 = 0;
        %
        Thetaold = getappdata(0,'Thetaold');
        theta11old = Thetaold(1);
        theta21old = Thetaold(2);
        theta31old = Thetaold(3);
        %
        t11 =jtraj(theta11old,theta11,n); 
        t21= jtraj(theta21old,theta21,n); 
        t31 =jtraj(theta31old,theta31,n);
        n = length(t11);
        for j = 2:1:n
            % Forward Kinematics
            %
        Theta1=getappdata(0,'Theta1');
        Theta2=getappdata(0,'Theta2');
        Theta3=getappdata(0,'Theta3');
        %
        theta12old = Theta1(2);
        theta22old = Theta2(2);
        theta32old = Theta3(2);
        theta13old = Theta1(3);
        theta23old = Theta2(3);
        theta33old = Theta3(3);
        theta14old = Theta1(1);
        theta24old = Theta2(1);
        theta34old = Theta3(1);
        x0=[theta12old theta13old theta22old  theta23old...
             theta32old  theta33old];
            q0=[t11(j) t21(j) t31(j)]*pi/180;
            %%
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

            Link2 = V2;
            Link1 = (T1_05*V1')';
            Link31 = (T1_01*V31')';
            Link33 = (T2_01*V33')';
            Link32 = (T3_01*V32')';
            Link41 = (T1_03*V41')';
            Link42 = (T1_06*V42')';
            Link43 = (T2_03*V43')';
            Link44 = (T2_06*V44')';
            Link45 = (T3_03*V45')';
            Link46 = (T3_06*V46')';
            handles = getappdata(0,'patch_h');           %
            L1 = handles(1);
            L2 = handles(2);
            L31 = handles(3);
            L32 = handles(4);
            L33 = handles(5);
            L41 = handles(6);
            L42 = handles(7);
            L43=handles(8);
            L44 = handles(9);
            L45= handles(10);
            L46= handles(11);
            Tr=handles(12);
            %
            set(L1,'vertices',Link1(:,1:3));
            set(L2,'vertices',Link2(:,1:3));
            set(L31,'vertices',Link31(:,1:3));
            set(L32,'vertices',Link32(:,1:3));
            set(L33,'vertices',Link33(:,1:3));
            set(L41,'vertices',Link41(:,1:3));
            set(L42,'vertices',Link42(:,1:3));
            set(L43,'vertices',Link43(:,1:3));
            set(L44,'vertices',Link44(:,1:3));
            set(L45,'vertices',Link45(:,1:3));
            set(L46,'vertices',Link46(:,1:3));
            %
            t0=q0*180/pi;
            set(t11_edit,'string',num2str(t0(1)));
            set(t11_slider,'value',t0(1));
            set(t21_edit,'string',num2str(t0(2)));
            set(t21_slider,'value',t0(2));
            set(t31_edit,'string',num2str(t0(3)));
            set(t31_slider,'value',t0(3));         
            if trail == 'y'
                x_trail = getappdata(0,'xtrail');
                y_trail = getappdata(0,'ytrail');
                z_trail = getappdata(0,'ztrail');
                %
                xdata = [x_trail T1_05(1,4)];
                ydata = [y_trail T1_05(2,4)];
                zdata = [z_trail T1_05(3,4)+z0+20];
                %
                setappdata(0,'xtrail',xdata); % used for trail tracking.
                setappdata(0,'ytrail',ydata); % used for trail tracking.
                setappdata(0,'ztrail',zdata); % used for trail tracking.
                %
                set(Tr,'xdata',xdata,'ydata',ydata,'zdata',zdata);
            end
            drawnow
        end
        setappdata(0,'Thetaold',[theta11,theta21,theta31]);
end
%% 
 function ikine_button_press(h,dummy)
    p1=get(p1_edit,'string');
    p2=get(p2_edit,'string');
    p3=get(p3_edit,'string');
    ip11=get(ip11_edit,'string');
    ip12=get(ip12_edit,'string');
    ip13=get(ip13_edit,'string');
    ip21=get(ip21_edit,'string');
    ip22=get(ip22_edit,'string');
    ip23=get(ip23_edit,'string');
    ip31=get(ip31_edit,'string');
    ip32=get(ip32_edit,'string');
    ip33=get(ip33_edit,'string');
    p1=str2num(p1);
    p2=str2num(p2);
    p3=str2num(p3);
    ip11=str2num(ip11);
    ip12=str2num(ip12);
    ip13=str2num(ip13);
    ip21=str2num(ip21);
    ip22=str2num(ip22);
    ip23=str2num(ip23);
    ip31=str2num(ip31);
    ip32=str2num(ip32);
    ip33=str2num(ip33);
    position=[p1 p2 p3];
    P1=[ip11 ip12 ip13];
    P2=[ip21 ip22 ip23];
    P3=[ip31 ip32 ip33];
    [theta1,theta2,theta3]=IFKINEdelta_fangzhen(position,P1,P2,P3);
    deltaANI(theta1(1),theta2(1),theta3(1),10,'n');
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
        rmappdata(0,'xtrail');
        rmappdata(0,'ytrail');
        rmappdata(0,'ztrail');
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
