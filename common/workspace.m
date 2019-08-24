%puma560工作空间的求解和表达
for a=(-160:10:160)*pi/180
    for b=(-225:10:45)*pi/180
        for c=(-45:10:225)*pi/180
            T=Fkine([a b c 0 0 0]);
            [x,y,z]=transl(T);
            plot3(x,y,z,'b.');
            hold on;
            grid on;
        end
    end
end
title('PUMA560工作空间');