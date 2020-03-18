%查看第一级和第二级协方差矩阵之间的关系

clc;clear all;close all;
load('D:\test\cape\simalarity_tao.mat','taoH2');
% load('E:\wavelet_processing\interpolation\GR_downsampled.mat','GR0'); %输入数据为降采样的3km CAPPI GR数据

%data1_SA=GR0;
filename='D:\test\cape\Z_RADR_I_Z9250_20160606003100_O_DOR_SA_CAP.bin';
cut_SA=SAread(filename);
data1_SA=cut_SA(1).RefData;%第一层仰角的数据
R=1:1:cut_SA(1).GateNumber;
X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
ind=isnan(data1_SA);
data1_SA(ind)=0;
[m,n]=size(data1_SA);
data1_SA=[data1_SA zeros(m,1) zeros(m,1)];%将366列扩展成368列，便于小波二级分解
[m,n]=size(data1_SA);
data2_SA=[data1_SA;zeros(1,n);zeros(1,n);zeros(1,n);zeros(1,n)];%将460行扩展成464行，便于小波三级分解
[CA,CH,CV,CD]=swt2(data2_SA,2,'haar');%提取一层分解的小波系数

%[CA,CH,CV,CD]=swt2(data1_SA,2,'haar');
CH1=CH(:,:,1);CH2=CH(:,:,2);
CV1=CV(:,:,1);CV2=CV(:,:,2);
CD1=CD(:,:,1);CD2=CD(:,:,2);
% ind0=find(CA(:,:,1)<=0);
% CH1(ind0)=0;
% CH2(ind0)=0;
[m,n]=size(CH1);

%边界的地方进行镜像对称扩充
% %因为选择5*5的领域，行列前后分别扩充2，即行比原来+4，列亦是
% CHh=zeros(m,n+4);
% CHh(:,1:2)=CH(:,2:-1:1);
% CHh(:,3:n+2)=CH(:,1:n);
% CHh(:,n+3:n+4)=CH(:,n:-1:n-1);
% CHhv=zeros(m+4,n+4);
% CHhv(1:2,:)=CHh(2:-1:1,:);
% CHhv(3:m+2,:)=CHh(1:m,:);
% CHhv(m+3:m+4,:)=CHh(m:-1:m-1,:);
%改成3*3的邻域，行列前后分别扩充1，即行比原来+2，列亦是
CHh1=zeros(m,n+2);
CHh1(:,1)=CH1(:,2);
CHh1(:,2:n+1)=CH1(:,1:n);
CHh1(:,n+2)=CH1(:,n-1);
CHhv1=zeros(m+2,n+2);
CHhv1(1,:)=CHh1(2,:);
CHhv1(2:m+1,:)=CHh1(1:m,:);
CHhv1(m+2,:)=CHh1(m-1,:);

cov_CH1=zeros(9,9);%5*5邻域的协方差矩阵
count=0;
[mnew,nnew]=size(CHhv1);
M=m*n;
%COV_CH=cell(1,M);
y=cell(1,M);
for k1=2:nnew-1
    for k2=2:mnew-1
        CH31=CHhv1(k2-1:k2+1,k1-1:k1+1);
        CH31_new=reshape(CH31,9,1);
        CCH1=CH31_new*CH31_new';
        count=count+1;
        %COV_CH{1,count}=CCH;
        y{1,count}=CH31_new;  %要好好考虑一下矩阵的排序和最后矩阵复原问题
        cov_CH1=cov_CH1+CCH1;
    end
end
 cov_CH1=cov_CH1/count;
 figure;pcolor(cov_CH1);colormap(gray)
 shading flat;axis square;
 
CHh2=zeros(m,n+2);
CHh2(:,1)=CH2(:,2);
CHh2(:,2:n+1)=CH2(:,1:n);
CHh2(:,n+2)=CH2(:,n-1);
CHhv2=zeros(m+2,n+2);
CHhv2(1,:)=CHh2(2,:);
CHhv2(2:m+1,:)=CHh2(1:m,:);
CHhv2(m+2,:)=CHh2(m-1,:);
cov_CH2=zeros(9,9);%3*3邻域的协方差矩阵
count=0;
[mnew,nnew]=size(CHhv2);
M=m*n;
%COV_CH=cell(1,M);
y=cell(1,M);
for k1=2:nnew-1
    for k2=2:mnew-1
        CH32=CHhv2(k2-1:k2+1,k1-1:k1+1);
        CH32_new=reshape(CH32,9,1);
        CCH2=CH32_new*CH32_new';
        count=count+1;
        %COV_CH{1,count}=CCH;
        y{1,count}=CH32_new;  %要好好考虑一下矩阵的排序和最后矩阵复原问题
        cov_CH2=cov_CH2+CCH2;
    end
end
 cov_CH2=cov_CH2/count;
 figure;pcolor(cov_CH2);colormap(gray)
 shading flat;axis square;
 
 CH1_new=reshape(CH1,1,m*n);
 CH2_new=reshape(CH2,1,m*n);
 X1=cov_CH1;
 X2=cov_CH2;
 X21=X2./2^taoH2;
 X1_norm=X1/max(max(X1));
 X21_norm=X21/max(max(X21));
%  X1_norm = X1./repmat(sqrt(sum(X1.^2,1)),size(X1,1),1);
%  X2_norm = X21./repmat(sqrt(sum(X21.^2,1)),size(X21,1),1);

 
 
 