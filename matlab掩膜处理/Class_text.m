clc;clear all;close all;

%%%%%%�׻���ͼ��

% z = peaks(1000);
% lon = [60 150];
% lat = [10 60];
% [LON,LAT] = meshgrid(linspace(lon(1),lon(2),1000), linspace(lat(1), lat(2),1000));
% c = contourf(LON,LAT,z,'linestyle', 'none');
% mapshow('C:\Users\ychun\Desktop\��\����ͳ����ҵ\��ҵ_���\chinamap\bou2_4p.shp','displaytype','polygon', 'facecolor','w')

z = peaks(1000);
lon = [60 135];
lat = [10 60];
[LON,LAT] = meshgrid(linspace(lon(1),lon(2),1000), linspace(lat(1), lat(2),1000));
c = contourf(LON,LAT,z,'linestyle', 'none');
maskMap('C:\Users\ychun\Desktop\��\����ͳ����ҵ\��ҵ_���\chinamap\bou2_4p.shp',true,'lon',lon,'lat',lat,'linewidth',0.5, 'edgecolor','b')
