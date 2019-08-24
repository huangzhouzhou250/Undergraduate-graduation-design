% TWIST
classdef TWIST
% %     定义相关的特性，v,w
    properties (SetAccess = protected)
        v
        w
    end
    
    methods
        function tw = TWIST(T, varargin)
%             通过输入建立旋量
           if ischar(T)
%                若输入第一个为char型
               switch upper(T)
                   case 'R'  %若输入的为旋转关节，
                       w = varargin{1};
                       p = varargin{2};
                       v = -cross(w,p);
                   case 'T'   %若输入的为移动关节
                       w=[0 0 0]';
                       v=varargin{1};
               end
               tw.v = v;
               tw.w = w;
             elseif isvector(T)
%                  若输入的为一个向量
                 switch length(T)
                     case 6
%                  若输入长度为6则将该向量直接赋值给旋量
                  tw.v = T(1:3)'; tw.w = T(4:6)';
                     otherwise
                      error('RTB:Twist:badarg', ' 6 element vector expected');
                 end
           end
        end 
        
        function x = double(tw)
%             将旋量转换为六位矢量
         x = [tw.v; tw.w]';
        end
        
        function x=T(tw,theta)
%             指定角度时变换矩阵的求解
            if norm(tw.w)==0
%                 如果是移动关节
                r=eye(3);
                p=tw.v*theta;
            else
%                 如果是旋转关节    
            r=eye(3)+SKW(tw.w)*sin(theta)+SKW(tw.w)*SKW(tw.w)*...
                (1-cos(theta));
            p=(eye(3)-r)*cross(tw.w,tw.v);
            end
            x=[r p;
                0 0 0 1];
        end
        function p = pole(tw)
%             求解旋量关节轴线上的某个特殊点
            p = cross(tw.w, tw.v) / tw.theta();
        end
    end
end