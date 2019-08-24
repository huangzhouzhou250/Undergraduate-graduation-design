
%puma560奇异性的求解
%只考虑前三个关节，后三个关节为初始角度
for a=(-160:20:160)*pi/180
    for b=(-225:15:45)*pi/180
        for c=(-45:15:225)*pi/180
            T=Fkine([a b c 0 0 0]');
            [x,y,z]=transl(T);
            J=JACO([a b c 0 0 0]');
            m=det(J);
            if abs(m)<=0.015
                H1=plot3(x,y,z,'r.');
                hold on;
                grid on;
            else
                H2=plot3(x,y,z,'b.');
                hold on;
                grid on;
            end
        end
    end
end
title('PUMA560奇异性分析');
legend([H1,H2],'奇异点','非奇异点');
                        
                 
              
         
      
