 a=0;
    for b=(-225:5:45)*pi/180
        for c=(-45:5:225)*pi/180
            T=Fkine([a b c 0 0 0]);
            [x,y,z]=transl(T);
            plot3(x,y,z,'b.');
            hold on;
            grid on;
        end
    end

title('PUMA560工作空间切面');