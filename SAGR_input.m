%��������ѡ��ΪԭʼSA�״�����

clc;clear;close all
filename='D:\test\cape\Z_RADR_I_Z9250_20160606003100_O_DOR_SA_CAP.bin';
cut_SA=SAread(filename);
data1_SA=cut_SA(1).RefData;%��һ�����ǵ�����
R=1:1:cut_SA(1).GateNumber;
X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
ind=isnan(data1_SA);
data1_SA(ind)=0;
[m1,n1]=size(data1_SA);
data1_SA=[data1_SA zeros(m1,1) zeros(m1,1)];%��366����չ��368�У�����С�������ֽ�
% data2_SA=[data1_SA;zeros(1,n1);zeros(1,n1);zeros(1,n1);zeros(1,n1)];%��460����չ��464�У�����С�������ֽ�
[m1,n1]=size(data1_SA);
data2_SA=[data1_SA;zeros(1,n1);zeros(1,n1);zeros(1,n1);zeros(1,n1)];%��460����չ��464�У�����С�������ֽ�

GR0=data2_SA;
[m,n]=size(GR0);
scale=4;%������2��
    %ͨ����ƽ�����н�����
for k1=1:scale:m-scale+1
    for k2=1:scale:n-scale+1
        GRr(k1,k2)=sum(sum(GR0(k1:k1+scale-1,k2:k2+scale-1)))/scale^2;
    end
end
GR1=GRr(1:scale:m-scale+1,1:scale:n-scale+1);
mycolor=[0,172,164;192,192,254;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,100;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255;
figure;pcolor(GR1);
colormap(mycolor);
caxis([-5,70]);
shading flat;
colorbar;
xlabel('grids,grid spacing 4km');
ylabel('grids,grid spacing 4km');
title('downscaled GR')

figure;pcolor(X,Y,GR0);
colormap(mycolor);
caxis([-5,70]);
shading flat;
colorbar;
xlabel('grids,grid spacing 1km');
ylabel('grids,grid spacing 1km');
title('original GR')

%��������ͼ����ж�ά���Բ�ֵ
GR2=interp2(X,Y,GR1,X0,Y0,'cubic');
figure;pcolor(GR2);
colormap(mycolor);
caxis([-5,70]);
shading flat;
colorbar;
xlabel('grids,grid spacing 1km');
ylabel('grids,grid spacing 1km');
title('Interploted GR based on downsampled GR')

save GR_downsampled.mat