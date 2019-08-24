for theta1=(-180:45:180)*pi/180
    for theta2=(-90 :45:90)*pi/180
        for theta3=(-180 :60:180)*pi/180
            for theta4=(-180 :45:180)*pi/180
                for theta5=(-180 :60:180)*pi/180
                    for theta6=(-180 :60:180)*pi/180
                        theta=[theta1 theta2 theta3 theta4 theta5 theta6];
                        T=Fkine_hedong(theta);
                        [x,y,z]=transl(T);
                        plot3(x,y,z,'b.');
                        hold on;
                        grid on;
                    end
                end
            end
        end
    end
end