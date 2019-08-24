x1=[0 0 0 0 0 0];
Q1=[0 0 0];
Q2=Q1;
Q3=Q2;
for m=(0:1:10)*pi/180
    for n=(0:1:10)*pi/180
         for k=(0:1:10)*pi/180
             T=FKINEdelta([m n k],x1);
             [q1,q2,q3]=IFKINEdelta(T,Q1,Q2,Q3);
             x1=[q1(2:3),q2(2:3),q3(2:3)];
             Q1=q1(1:3);
             Q2=q2(1:3);
             Q3=q2(1:3);
             x=T(1);
             y=T(2);
             z=T(3);
             plot3(x,y,z,'b.');
             hold on;
             grid on;
         end
    end
end
title('delta¹¤×÷¿Õ¼ä');