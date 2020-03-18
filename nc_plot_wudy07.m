%****************************************
%       nc_plot_wudy07.m
%学习使用批量读取nc文件，并画出等值线图
%                             by wudy
%                         May.02 2017 
%***************************************
clc;         %清屏
clear all;   %清空
%%
%nc批量读取春季数据
datadir1='F:\国创\画图\数据对比\AOD\MODIS\avg_seasons\';                     %指定批量数据所在的文件夹
filelist1=dir([datadir1,'AOD555_spr*.nc']);                                  %指定批量数据的类型
a=filelist1(1).name;                                                        %查看你要读取的文件的编号。filelist(1).name在window下为第一个标号数据
b=filelist1(2).name;                                                        %查看你要读取的文件的编号。filelist(2).name在window下为第二个标号数据
k1=length(filelist1);                                                        %批量读取的文件数
ncdisp F:\国创\画图\数据对比\AOD\MODIS\avg_seasons\AOD555_spr_2007.nc        %输出nc文件中的变量
%nc批量读取夏季数据
datadir2='F:\国创\画图\数据对比\AOD\MODIS\avg_seasons\';                     %指定批量数据所在的文件夹
filelist2=dir([datadir1,'AOD555_sum*.nc']);                                 %指定批量数据的类型
a=filelist2(1).name;                                                        %查看你要读取的文件的编号。filelist(1).name在window下为第一个标号数据
b=filelist2(2).name;                                                        %查看你要读取的文件的编号。filelist(2).name在window下为第二个标号数据
k2=length(filelist2);                                                       %批量读取的文件数
ncdisp F:\国创\画图\数据对比\AOD\MODIS\avg_seasons\AOD555_sum_2007.nc        %输出nc文件中的变量
%%
%读取春季数据
AOD_01=zeros(k1,360,180);                                                 
for s=1:k1
  filename=[datadir1,filelist1(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');                                 %打开nc文件         
  
  AOD_01(s,:,:)= ncread(filename,'AOD555');                                %读入变量AOD555
  LatData=ncread(filename,'lat');                                          %读入变量lat
  LonData=ncread(filename,'lon');                                          %读入变量lon
  
  netcdf.close(ncid);                                                      %关闭nc文件
end;
AOD_spr(:,:)=mean(AOD_01,1);                                                %对指定的维数进行平均
%读取夏季数据
AOD_02=zeros(k2,360,180);                                                 
for s=1:k2
  filename=[datadir2,filelist2(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');                                 %打开nc文件         
  
  AOD_02(s,:,:)= ncread(filename,'AOD555');                                 %读入变量AOD555
  LatData=ncread(filename,'lat');                                          %读入变量lat
  LonData=ncread(filename,'lon');                                          %读入变量lon
  
  netcdf.close(ncid);                                                      %关闭nc文件
end;
AOD_sum(:,:)=mean(AOD_02,1);                                               %对指定的维数进行平均
%%
%进行绘图处理
[X, Y] = meshgrid(LatData,LonData);
figure
%title('AOD')

%进行第一张绘图
subplot(1,2,1)                                                             %画等值面图
space=[0:0.1:1.5];
contourf(Y,X,AOD_spr,space);                                                    
shading flat;                                                              %去掉等值线
shading interp                                                             %去掉等值线
%colorbar('SouthOutside','Position',[0.142,0.03,0.75,0.04]);               %添加颜色条 [左右,上下,长，宽]
colorbar('v');                                                             %设置colorbar的位置
caxis([0 1.5]);                                                            %colorbar的范围设置
colormap('hsv')                                                            %colormap
load coast                                                                 %加载全球海岸线，但是不显示出来
geoshow(lat,long);                                                         %显示出海岸线，lat和long是coast的属性
hold on;
%set(gca,'LineWidth',1,'FontSize',10,'Ylim',[-90,90],'Xlim',[-180,180],'Position',[0.142,0.09,0.75,0.84]...
%   ,'XTick',[-180:60:180],'XTicklabel',{'-180^oW','-120^oW','-60W','0','60^oE','120^oE','180^oE'}...
%   ,'YTick',[-90:30:90],'YTicklabel',{'-90^oS','-60^oS','-30^oS','0','30^oN','60^oN','90^oN'}); %添加经纬度信息
set(gca,'LineWidth',1,'FontSize',10,'Ylim',[10,50],'Xlim',[75,135]); %添加经纬度信息
str_x=get(gca,'xticklabel'); 
strtxt=strcat(str_x,'°E'); 
set(gca,'xticklabel',strtxt);       %设置经纬度坐标
str_y=get(gca,'YtickLabel');        %添加经纬度单位
strtxt=strcat(str_y,'°N'); 
set(gca,'yticklabel',strtxt);
title('spring','FontName','隶书' ,'FontSize',25) %加标题
xlabel('longitude','FontSize',15)                %添加坐标轴的标签
ylabel('latitude','FontSize',15)

%进行第二张绘图
subplot(1,2,2)
space=[0:0.1:1.5];
contourf(Y,X,AOD_sum,space);                                               %画等值面图
shading flat;                                                              %去掉等值线
shading interp                                                             %去掉等值线
%colorbar('SouthOutside','Position',[0.142,0.03,0.75,0.04]);               %添加颜色条 [左右,上下,长，宽]
colorbar('v');                                                             %设置colorbar的位置
caxis([0 1.5]);                                                            %colorbar的范围设置
colormap('hsv')                                                            %colormap
load coast                                                                 %加载全球海岸线，但是不显示出来
geoshow(lat,long);                                                         %显示出海岸线，lat和long是coast的属性
hold on;
%set(gca,'LineWidth',1,'FontSize',10,'Ylim',[-90,90],'Xlim',[-180,180],'Position',[0.142,0.09,0.75,0.84]...
%   ,'XTick',[-180:60:180],'XTicklabel',{'-180^oW','-120^oW','-60W','0','60^oE','120^oE','180^oE'}...
%   ,'YTick',[-90:30:90],'YTicklabel',{'-90^oS','-60^oS','-30^oS','0','30^oN','60^oN','90^oN'}); %添加经纬度信息
set(gca,'LineWidth',1,'FontSize',10,'Ylim',[10,50],'Xlim',[75,135]); %添加经纬度信息
str_x=get(gca,'xticklabel'); 
strtxt=strcat(str_x,'°E'); 
set(gca,'xticklabel',strtxt);       %设置经纬度坐标
str_y=get(gca,'YtickLabel');        %添加经纬度单位
strtxt=strcat(str_y,'°N'); 
set(gca,'yticklabel',strtxt);
title('summer','FontName','隶书' ,'FontSize',25)  %加标题
xlabel('longitude','FontSize',15)                %添加坐标轴的标签
ylabel('latitude','FontSize',15)
hold off;
%%
%---------------------------------------------
