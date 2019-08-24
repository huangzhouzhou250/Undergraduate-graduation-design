% TWIST
classdef TWIST
% %     ������ص����ԣ�v,w
    properties (SetAccess = protected)
        v
        w
    end
    
    methods
        function tw = TWIST(T, varargin)
%             ͨ�����뽨������
           if ischar(T)
%                �������һ��Ϊchar��
               switch upper(T)
                   case 'R'  %�������Ϊ��ת�ؽڣ�
                       w = varargin{1};
                       p = varargin{2};
                       v = -cross(w,p);
                   case 'T'   %�������Ϊ�ƶ��ؽ�
                       w=[0 0 0]';
                       v=varargin{1};
               end
               tw.v = v;
               tw.w = w;
             elseif isvector(T)
%                  �������Ϊһ������
                 switch length(T)
                     case 6
%                  �����볤��Ϊ6�򽫸�����ֱ�Ӹ�ֵ������
                  tw.v = T(1:3)'; tw.w = T(4:6)';
                     otherwise
                      error('RTB:Twist:badarg', ' 6 element vector expected');
                 end
           end
        end 
        
        function x = double(tw)
%             ������ת��Ϊ��λʸ��
         x = [tw.v; tw.w]';
        end
        
        function x=T(tw,theta)
%             ָ���Ƕ�ʱ�任��������
            if norm(tw.w)==0
%                 ������ƶ��ؽ�
                r=eye(3);
                p=tw.v*theta;
            else
%                 �������ת�ؽ�    
            r=eye(3)+SKW(tw.w)*sin(theta)+SKW(tw.w)*SKW(tw.w)*...
                (1-cos(theta));
            p=(eye(3)-r)*cross(tw.w,tw.v);
            end
            x=[r p;
                0 0 0 1];
        end
        function p = pole(tw)
%             ��������ؽ������ϵ�ĳ�������
            p = cross(tw.w, tw.v) / tw.theta();
        end
    end
end