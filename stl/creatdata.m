% [x1,y1,z1,p1]=stlread('DELTA1 - dimian1-1.STL');
% % h1=patch(x1,y1,z1,[0.5 0 0]);
% h1=patch(x1,z1,y1,[0.5 0 0]);
% set(h1,'EdgeColor',[0.5 0 0]);
% hold on
% F1=get(h1,'Faces');
% V1=get(h1,'Vertices');
% [m,n]=size(V1);
% L=zeros(m,n+1);
% for i=1:1:m
%     L(i,:)=[V1(i,:) 1];
% end

% V1=(roty(pi/3)*V1')';
% L1 = patch('faces', F1, 'vertices' ,V1);
% set(L1,'EdgeColor',[0.5 0 0]);
% set(L1,'FaceColor',[0.5 0 0]);
% hold on
% 
% [x2,y2,z2,p2]=stlread('DELTA1 - dingmian-1.STL');
% % h2=patch(x2,y2,z2,[0 0 0]);
% h2=patch(x2,z2,y2,[0 0 0]);
% set(h2,'EdgeColor',[0 0 0]);
% x2=get(h2,'XData');
% y2=get(h2,'YData');
% z2=get(h2,'ZData');

[x1,y1,z1,p1]=stlread('DELTA1 - dimian1-1.STL');
% h1=patch(x1,y1,z1,[0.5 0 0]);
h1=patch(x1,y1,z1,[0.5 0 0]);
hold on
set(h1,'EdgeColor',[0.5 0 0]);
F1=get(h1,'Faces');
V1=get(h1,'Vertices');
[m,n]=size(V1);
L1=zeros(m,n+1);
for i=1:1:m
    L1(i,:)=[V1(i,:) 1];
end

[x2,y2,z2,p2]=stlread('DELTA1 - dingmian-1.STL');
% h2=patch(x2,y2,z2,[0 0 0]);
h2=patch(x2,y2,z2,[0 0 0]);
hold on
set(h2,'EdgeColor',[0 0 0]);
F2=get(h2,'Faces');
V2=get(h2,'Vertices');
[m,n]=size(V2);
L2=zeros(m,n+1);
for i=1:1:m
    L2(i,:)=[V2(i,:) 1];
end

[x31,y31,z31,p31]=stlread('DELTA1 - shangliang1-1.STL');
p3=[0 0 0.5];
% h31=patch(x31,y31,z31,p3);
h31=patch(x31,y31,z31,p3);
hold on
set(h31,'EdgeColor',p3);
F31=get(h31,'Faces');
V31=get(h31,'Vertices');
[m,n]=size(V31);
L31=zeros(m,n+1);
for i=1:1:m
    L31(i,:)=[V31(i,:) 1];
end

[x32,y32,z32,p32]=stlread('DELTA1 - shangliang1-2.STL');
% h32=patch(x32,y32,z32,p3);
h32=patch(x32,y32,z32,p3);
hold on
set(h32,'EdgeColor',p3);
F32=get(h32,'Faces');
V32=get(h32,'Vertices');
[m,n]=size(V32);
L32=zeros(m,n+1);
for i=1:1:m
    L32(i,:)=[V32(i,:) 1];
end

[x33,y33,z33,p33]=stlread('DELTA1 - shangliang1-3.STL');
% h33=patch(x33,y33,z33,p3);
h33=patch(x33,y33,z33,p3);
hold on
set(h33,'EdgeColor',p3);
F33=get(h33,'Faces');
V33=get(h33,'Vertices');
[m,n]=size(V33);
L33=zeros(m,n+1);
for i=1:1:m
    L33(i,:)=[V33(i,:) 1];
end

[x41,y41,z41,p41]=stlread('DELTA1 - xialiang1-2.STL');
p4=[0 0.8 0.8];
% h41=patch(x41,y41,z41,p4);
h41=patch(x41,y41,z41,p4);
hold on
set(h41,'EdgeColor',p4);
F41=get(h41,'Faces');
V41=get(h41,'Vertices');
[m,n]=size(V41);
L41=zeros(m,n+1);
for i=1:1:m
    L41(i,:)=[V41(i,:) 1];
end

[x42,y42,z42,p42]=stlread('DELTA1 - xialiang1-3.STL');
% h42=patch(x42,y42,z42,p4);
h42=patch(x42,y42,z42,p4);
hold on
set(h42,'EdgeColor',p4);
F42=get(h42,'Faces');
V42=get(h42,'Vertices');
[m,n]=size(V42);
L42=zeros(m,n+1);
for i=1:1:m
    L42(i,:)=[V42(i,:) 1];
end

[x43,y43,z43,p43]=stlread('DELTA1 - xialiang1-4.STL');
% h43=patch(x43,y43,z43,p4);
h43=patch(x43,y43,z43,p4);
hold on
set(h43,'EdgeColor',p4);
F43=get(h43,'Faces');
V43=get(h43,'Vertices');
[m,n]=size(V43);
L43=zeros(m,n+1);
for i=1:1:m
    L43(i,:)=[V43(i,:) 1];
end


[x44,y44,z44,p44]=stlread('DELTA1 - xialiang1-5.STL');
% h44=patch(x44,y44,z44,p4);
h44=patch(x44,y44,z44,p4);
hold on
set(h44,'EdgeColor',p4);
F44=get(h44,'Faces');
V44=get(h44,'Vertices');
[m,n]=size(V44);
L44=zeros(m,n+1);
for i=1:1:m
    L44(i,:)=[V44(i,:) 1];
end

[x45,y45,z45,p45]=stlread('DELTA1 - xialiang1-6.STL');
% h45=patch(x45,y45,z45,p4);
h45=patch(x45,y45,z45,p4);
hold on
set(h45,'EdgeColor',p4);
F45=get(h45,'Faces');
V45=get(h45,'Vertices');
[m,n]=size(V45);
L45=zeros(m,n+1);
for i=1:1:m
    L45(i,:)=[V45(i,:) 1];
end

[x46,y46,z46,p46]=stlread('DELTA1 - xialiang1-7.STL');
h46=patch(x46,y46,z46,p4);
% h46=patch(x46,z46,y46,p4);
hold on
set(h46,'EdgeColor',p4);
F46=get(h46,'Faces');
V46=get(h46,'Vertices');
[m,n]=size(V46);
L46=zeros(m,n+1);
for i=1:1:m
    L46(i,:)=[V46(i,:) 1];
end
C=[0.5 0 0;
    0 0 0;
    0 0 0.5;
    0 0.8 0.8];
Linkdata=struct('F1',F1,'L1',L1,'F2',F2,'L2',L2,'F31',F31,'L31',L31,...
    'F32',F32,'L32',L32,'F33',F33,'L33',L33,'F41',F41,'L41',L41,...
    'F42',F42,'L42',L42,'F43',F43,'L43',L43,'F44',F44,'L44',L44,...
    'F45',F45,'L45',L45,'F46',F46,'L46',L46,'Color',C);
save('Linkdata.mat','-struct','Linkdata');

plot3(240,480,0,'y.')

