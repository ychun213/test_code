clc;clear;close all;

InPath = 'E:\test\cape\';
%ncdisp(strcat(InPath,'20160601t8_cape.nc')) %获取所读取nc文件的基本信息
source1 = strcat(InPath,'20160505T012_cape.nc');

lon = ncread(source1,'longitude');
lat = ncread(source1,'latitude');
cape_single = ncread(source1,'cape');

cape0 = cape_single(:,:,1);
cape1 = cape_single(:,:,2);
cape2 = cape_single(:,:,3);
cape3 = cape_single(:,:,4);