p1=getdatasamples(x,1:x.length);
p2=getdatasamples(y,1:y.length);
p3=getdatasamples(z,1:z.length);
p2=p2-0.025;
p3=p3-mean(p3);
plot3(p1,p2,p3);

axis([-0.5 0.5 0 1 -0.5 0.5 ]);
title('puma560·ÂÕæ¹ì¼£')