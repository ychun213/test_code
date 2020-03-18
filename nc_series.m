clc;clear;close all;

InPath = 'D:\test\list\cape_list\';
data_cape = strcat(InPath,'20160501_00_01_02.nc');
ncdisp(data_cape); %获取所读取nc文件的基本信息

lon = ncread(data_cape,'longitude');
lat = ncread(data_cape,'latitude');
cape_single = ncread(data_cape,'cape');
time_total = ncread(data_cape,'time');

[Lat,Lon] = meshgrid(lat,lon);
cape0 = cape_single(:,:,1);
cape1 = cape_single(:,:,2);
cape2 = cape_single(:,:,3);
cape3 = cape_single(:,:,4);
cape4 = cape_single(:,:,5);
cape5 = cape_single(:,:,6);
cape6 = cape_single(:,:,7);
cape7 = cape_single(:,:,8);
cape8 = cape_single(:,:,9);
cape9 = cape_single(:,:,10);
cape10 = cape_single(:,:,11);
cape11 = cape_single(:,:,12);
cape12 = cape_single(:,:,13);
cape13 = cape_single(:,:,14);
cape14 = cape_single(:,:,15);
cape15 = cape_single(:,:,16);
cape16 = cape_single(:,:,17);
cape17 = cape_single(:,:,18);
cape18 = cape_single(:,:,19);
cape19 = cape_single(:,:,20);
cape20 = cape_single(:,:,21);
cape21 = cape_single(:,:,22);
cape22 = cape_single(:,:,23);
cape23 = cape_single(:,:,24);

[x1,y1]=find(Lon==117.0 & Lat==33.75);
[x2,y2]=find(Lon==120.25 & Lat==30.5);
[x0,y0]=find(Lon==118.75 & Lat==32.25);


%% 0-23小时

cape0_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape0_all=cape0(x11,y11);
        cape0_sum=cape0_sum+cape0_all;
    end
end
cape0_av = cape0_sum./196;
cape0_near=cape0(x0,y0);

cape1_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape1_all=cape1(x11,y11);
        cape1_sum=cape1_sum+cape1_all;
    end
end
cape1_av = cape1_sum./196;
cape1_near=cape1(x0,y0);

cape2_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape2_all=cape2(x11,y11);
        cape2_sum=cape2_sum+cape2_all;
    end
end
cape2_av = cape2_sum./196;
cape2_near=cape2(x0,y0);

cape3_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape3_all=cape3(x11,y11);
        cape3_sum=cape3_sum+cape3_all;
    end
end
cape3_av = cape3_sum./196;
cape3_near=cape3(x0,y0);

cape4_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape4_all=cape4(x11,y11);
        cape4_sum=cape4_sum+cape4_all;
    end
end
cape4_av = cape4_sum./196;
cape4_near=cape4(x0,y0);

cape5_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape5_all=cape5(x11,y11);
        cape5_sum=cape5_sum+cape5_all;
    end
end
cape5_av = cape5_sum./196;
cape5_near=cape5(x0,y0);

cape6_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape6_all=cape6(x11,y11);
        cape6_sum=cape6_sum+cape6_all;
    end
end
cape6_av = cape6_sum./196;
cape6_near=cape6(x0,y0);

cape7_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape7_all=cape7(x11,y11);
        cape7_sum=cape7_sum+cape7_all;
    end
end
cape7_av = cape7_sum./196;
cape7_near=cape7(x0,y0);

cape8_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape8_all=cape8(x11,y11);
        cape8_sum=cape8_sum+cape8_all;
    end
end
cape8_av = cape8_sum./196;
cape8_near=cape8(x0,y0);

cape9_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape9_all=cape9(x11,y11);
        cape9_sum=cape9_sum+cape9_all;
    end
end
cape9_av = cape9_sum./196;
cape9_near=cape9(x0,y0);

cape10_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape10_all=cape10(x11,y11);
        cape10_sum=cape10_sum+cape10_all;
    end
end
cape10_av = cape10_sum./196;
cape10_near=cape10(x0,y0);

cape11_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape11_all=cape11(x11,y11);
        cape11_sum=cape11_sum+cape11_all;
    end
end
cape11_av = cape11_sum./196;
cape11_near=cape11(x0,y0);

cape12_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape12_all=cape12(x11,y11);
        cape12_sum=cape12_sum+cape12_all;
    end
end
cape12_av = cape12_sum./196;
cape12_near=cape12(x0,y0);

cape13_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape13_all=cape13(x11,y11);
        cape13_sum=cape13_sum+cape13_all;
    end
end
cape13_av = cape13_sum./196;
cape13_near=cape13(x0,y0);

cape14_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape14_all=cape14(x11,y11);
        cape14_sum=cape14_sum+cape14_all;
    end
end
cape14_av = cape14_sum./196;
cape14_near=cape14(x0,y0);

cape15_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape15_all=cape15(x11,y11);
        cape15_sum=cape15_sum+cape15_all;
    end
end
cape15_av = cape15_sum./196;
cape15_near=cape15(x0,y0);

cape16_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape16_all=cape16(x11,y11);
        cape16_sum=cape16_sum+cape16_all;
    end
end
cape16_av = cape16_sum./196;
cape16_near=cape16(x0,y0);

cape17_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape17_all=cape17(x11,y11);
        cape17_sum=cape17_sum+cape17_all;
    end
end
cape17_av = cape17_sum./196;
cape17_near=cape17(x0,y0);

cape18_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape18_all=cape18(x11,y11);
        cape18_sum=cape18_sum+cape18_all;
    end
end
cape18_av = cape18_sum./196;
cape18_near=cape18(x0,y0);

cape19_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape19_all=cape19(x11,y11);
        cape19_sum=cape19_sum+cape19_all;
    end
end
cape19_av = cape19_sum./196;
cape19_near=cape19(x0,y0);

cape20_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape20_all=cape20(x11,y11);
        cape20_sum=cape20_sum+cape20_all;
    end
end
cape20_av = cape20_sum./196;
cape20_near=cape20(x0,y0);

cape21_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape21_all=cape21(x11,y11);
        cape21_sum=cape21_sum+cape21_all;
    end
end
cape21_av = cape21_sum./196;
cape21_near=cape21(x0,y0);

cape22_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape22_all=cape22(x11,y11);
        cape22_sum=cape22_sum+cape22_all;
    end
end
cape22_av = cape22_sum./196;
cape22_near=cape22(x0,y0);

cape23_sum=0.0;
for x11=x1:1:x2
    for y11=y1:1:y2
        cape23_all=cape23(x11,y11);
        cape23_sum=cape23_sum+cape23_all;
    end
end
cape23_av = cape23_sum./196;
cape23_near=cape23(x0,y0);


%%24小时
x=0:1:23
cape_av_t24 = [cape0_av cape1_av cape2_av cape3_av cape4_av cape5_av cape6_av cape7_av cape8_av cape9_av cape10_av cape11_av cape12_av cape13_av cape14_av cape15_av cape16_av cape17_av cape18_av cape19_av cape20_av cape21_av cape22_av cape23_av];
cape_near_t24 = [cape0_near cape1_near cape2_near cape3_near cape4_near cape5_near cape6_near cape7_near cape8_near cape9_near cape10_near cape11_near cape12_near cape13_near cape14_near cape15_near cape16_near cape17_near cape18_near cape19_near cape20_near cape21_near cape22_near cape23_near];

figure;
plot(x,cape_av_t24)
figure;
plot(x,cape_near_t24)


%%

%[m n]=size(cape);
%Lon=zeros(m,n);
%for i=1:n
%    Lon(:,i)=lon;
%end

%Lat=zeros(m,n);
%for i=1:m
%    Lat(i,:)=lat;
%end

x=Lon;
y=Lat;

figure;
[C,h] = contour(x,y,cape1,'LevelStep',100);
axis([116 120 30 34]);
figure;
[C,h] = contour(x,y,cape2,'LevelStep',100);
clabel(C,h);
text(x0,y0,'*','color','r');
axis([116 120 30 34]);
%axis([70 140 10 70]);

hold off
[C,h] = contour(x,y,cape2,'LevelStep',300);
clabel(C,h);
text(x0,y0,'*','color','r');
axis([116 120 30 34]);



%fnshp_L='E:\test\bou2_4l.shp';%ShapeType: 'PolyLine'

%infoL = shapeinfo(fnshp_L);

%readL=shaperead(fnshp_L);

%mapshow(readL);title('PolyLine of China');


%a=rand(2,3,4);
%b=permute(a,[2,1,3]);


