%****************************************
%       nc_plot_wudy07.m
%ѧϰʹ��������ȡnc�ļ�����������ֵ��ͼ
%                             by wudy
%                         May.02 2017 
%***************************************
clc;         %����
clear all;   %���
%%
%nc������ȡ��������
datadir1='F:\����\��ͼ\���ݶԱ�\AOD\MODIS\avg_seasons\';                     %ָ�������������ڵ��ļ���
filelist1=dir([datadir1,'AOD555_spr*.nc']);                                  %ָ���������ݵ�����
a=filelist1(1).name;                                                        %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
b=filelist1(2).name;                                                        %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(2).name��window��Ϊ�ڶ����������
k1=length(filelist1);                                                        %������ȡ���ļ���
ncdisp F:\����\��ͼ\���ݶԱ�\AOD\MODIS\avg_seasons\AOD555_spr_2007.nc        %���nc�ļ��еı���
%nc������ȡ�ļ�����
datadir2='F:\����\��ͼ\���ݶԱ�\AOD\MODIS\avg_seasons\';                     %ָ�������������ڵ��ļ���
filelist2=dir([datadir1,'AOD555_sum*.nc']);                                 %ָ���������ݵ�����
a=filelist2(1).name;                                                        %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
b=filelist2(2).name;                                                        %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(2).name��window��Ϊ�ڶ����������
k2=length(filelist2);                                                       %������ȡ���ļ���
ncdisp F:\����\��ͼ\���ݶԱ�\AOD\MODIS\avg_seasons\AOD555_sum_2007.nc        %���nc�ļ��еı���
%%
%��ȡ��������
AOD_01=zeros(k1,360,180);                                                 
for s=1:k1
  filename=[datadir1,filelist1(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');                                 %��nc�ļ�         
  
  AOD_01(s,:,:)= ncread(filename,'AOD555');                                %�������AOD555
  LatData=ncread(filename,'lat');                                          %�������lat
  LonData=ncread(filename,'lon');                                          %�������lon
  
  netcdf.close(ncid);                                                      %�ر�nc�ļ�
end;
AOD_spr(:,:)=mean(AOD_01,1);                                                %��ָ����ά������ƽ��
%��ȡ�ļ�����
AOD_02=zeros(k2,360,180);                                                 
for s=1:k2
  filename=[datadir2,filelist2(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');                                 %��nc�ļ�         
  
  AOD_02(s,:,:)= ncread(filename,'AOD555');                                 %�������AOD555
  LatData=ncread(filename,'lat');                                          %�������lat
  LonData=ncread(filename,'lon');                                          %�������lon
  
  netcdf.close(ncid);                                                      %�ر�nc�ļ�
end;
AOD_sum(:,:)=mean(AOD_02,1);                                               %��ָ����ά������ƽ��
%%
%���л�ͼ����
[X, Y] = meshgrid(LatData,LonData);
figure
%title('AOD')

%���е�һ�Ż�ͼ
subplot(1,2,1)                                                             %����ֵ��ͼ
space=[0:0.1:1.5];
contourf(Y,X,AOD_spr,space);                                                    
shading flat;                                                              %ȥ����ֵ��
shading interp                                                             %ȥ����ֵ��
%colorbar('SouthOutside','Position',[0.142,0.03,0.75,0.04]);               %�����ɫ�� [����,����,������]
colorbar('v');                                                             %����colorbar��λ��
caxis([0 1.5]);                                                            %colorbar�ķ�Χ����
colormap('hsv')                                                            %colormap
load coast                                                                 %����ȫ�򺣰��ߣ����ǲ���ʾ����
geoshow(lat,long);                                                         %��ʾ�������ߣ�lat��long��coast������
hold on;
%set(gca,'LineWidth',1,'FontSize',10,'Ylim',[-90,90],'Xlim',[-180,180],'Position',[0.142,0.09,0.75,0.84]...
%   ,'XTick',[-180:60:180],'XTicklabel',{'-180^oW','-120^oW','-60W','0','60^oE','120^oE','180^oE'}...
%   ,'YTick',[-90:30:90],'YTicklabel',{'-90^oS','-60^oS','-30^oS','0','30^oN','60^oN','90^oN'}); %��Ӿ�γ����Ϣ
set(gca,'LineWidth',1,'FontSize',10,'Ylim',[10,50],'Xlim',[75,135]); %��Ӿ�γ����Ϣ
str_x=get(gca,'xticklabel'); 
strtxt=strcat(str_x,'��E'); 
set(gca,'xticklabel',strtxt);       %���þ�γ������
str_y=get(gca,'YtickLabel');        %��Ӿ�γ�ȵ�λ
strtxt=strcat(str_y,'��N'); 
set(gca,'yticklabel',strtxt);
title('spring','FontName','����' ,'FontSize',25) %�ӱ���
xlabel('longitude','FontSize',15)                %���������ı�ǩ
ylabel('latitude','FontSize',15)

%���еڶ��Ż�ͼ
subplot(1,2,2)
space=[0:0.1:1.5];
contourf(Y,X,AOD_sum,space);                                               %����ֵ��ͼ
shading flat;                                                              %ȥ����ֵ��
shading interp                                                             %ȥ����ֵ��
%colorbar('SouthOutside','Position',[0.142,0.03,0.75,0.04]);               %�����ɫ�� [����,����,������]
colorbar('v');                                                             %����colorbar��λ��
caxis([0 1.5]);                                                            %colorbar�ķ�Χ����
colormap('hsv')                                                            %colormap
load coast                                                                 %����ȫ�򺣰��ߣ����ǲ���ʾ����
geoshow(lat,long);                                                         %��ʾ�������ߣ�lat��long��coast������
hold on;
%set(gca,'LineWidth',1,'FontSize',10,'Ylim',[-90,90],'Xlim',[-180,180],'Position',[0.142,0.09,0.75,0.84]...
%   ,'XTick',[-180:60:180],'XTicklabel',{'-180^oW','-120^oW','-60W','0','60^oE','120^oE','180^oE'}...
%   ,'YTick',[-90:30:90],'YTicklabel',{'-90^oS','-60^oS','-30^oS','0','30^oN','60^oN','90^oN'}); %��Ӿ�γ����Ϣ
set(gca,'LineWidth',1,'FontSize',10,'Ylim',[10,50],'Xlim',[75,135]); %��Ӿ�γ����Ϣ
str_x=get(gca,'xticklabel'); 
strtxt=strcat(str_x,'��E'); 
set(gca,'xticklabel',strtxt);       %���þ�γ������
str_y=get(gca,'YtickLabel');        %��Ӿ�γ�ȵ�λ
strtxt=strcat(str_y,'��N'); 
set(gca,'yticklabel',strtxt);
title('summer','FontName','����' ,'FontSize',25)  %�ӱ���
xlabel('longitude','FontSize',15)                %���������ı�ǩ
ylabel('latitude','FontSize',15)
hold off;
%%
%---------------------------------------------
