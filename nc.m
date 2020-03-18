
clc;clear;close all;

InPath = 'D:\test\list\cape_list\';
data_cape = strcat(InPath,'20160501_02.nc');
ncdisp(data_cape); %获取所读取nc文件的基本信息

lon = ncread(data_cape,'longitude');
lat = ncread(data_cape,'latitude');
cape_time = ncread(data_cape,'time');
cape_single = ncread(data_cape,'cape');


%%%%%%%南京站经纬度：(lon：118.69，lat：32.1908)
[Lat,Lon] = meshgrid(lat,lon);
cape_sum=0.0;
tas1 = cape_single(:,:,1);
[x1,y1]=find(Lon==117.0 & Lat==33.75);
[x2,y2]=find(Lon==120.25 & Lat==30.5);
[x0,y0]=find(Lon==118.75 & Lat==32.25);

%x11=[469:0.25:482];


for x11=x1:1:x2
    for y11=y1:1:y2
        k_all=tas1(x11,y11);
        cape_sum=cape_sum+k_all;
    end
end

cape_av = cape_sum./196;

cape_near=tas1(x0,y0);





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
%temp=temp-273;

[C,h] = contour(x,y,cape_single,'LevelStep',5);
%v=[30];
clabel(C,h);
%clabel(C,h,'FontSize',15,'Color','r','FontName','Courier');
text(x0,y0,'*','color','r');
axis([116 120 30 34]);
%axis([70 140 10 70]);

%fnshp_L='E:\test\bou2_4l.shp';%ShapeType: 'PolyLine'

%infoL = shapeinfo(fnshp_L);

%readL=shaperead(fnshp_L);

%mapshow(readL);title('PolyLine of China');


%a=rand(2,3,4);
%b=permute(a,[2,1,3]);


