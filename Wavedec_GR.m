%小波分解，2017/7/25

clc;clear;close all
filename1='E:\wavelet_processing\interpolation\data\1km1km_NANJ_080527_150km.001';

%读取GR第三层CAPPI数据
fid=fopen(filename1,'r');
large_width=fread(fid,1,'float');
z=1;
while(~feof(fid))    
   DBZ=fread(fid,[large_width,large_width],'float');
   if(size(DBZ) < 1)
       break;
   end
   
   DBZ3D(:,:,z)=reshape(DBZ,large_width,large_width,1);
    z=z+1;
end
fclose(fid);
ind=find(DBZ3D<0);
DBZ3D(ind)=0;
ind1=find(DBZ3D>0);
DBZ3D(ind1)=DBZ3D(ind1)+0; %进行一致性定标偏差校正
DBZ1=reshape(DBZ3D(:,:,3),large_width,large_width);%显示的最低高度是1km，总共显示20层，即1km到20km
GR00=DBZ1(end:-1:1,:);
[m1,n1]=size(GR00);
%为使得GR可以3次或者4次分解，对图像进行了镜像填充
%行列前后分别扩充2，即行比原来+4，列亦是
GR0_n=zeros(m1,n1+4);
GR0_n(:,1:2)=zeros(m1,2);%GR00(:,3:-1:2);
GR0_n(:,3:n1+2)=GR00(:,1:n1);
GR0_n(:,n1+3:n1+4)=zeros(m1,2);%GR00(:,n1-1:-1:n1-2);
GR0_nm=zeros(m1+4,n1+4);
GR0_nm(1:2,:)=zeros(2,n1+4);%GR0_n(3:-1:2,:);
GR0_nm(3:m1+2,:)=GR0_n(1:m1,:);
GR0_nm(m1+3:m1+4,:)=zeros(2,n1+4);%GR0_n(m1-1:-1:m1-2,:);
GR0=GR0_nm;
[m,n]=size(GR0);

%GR进行小波分解
[CA,CH,CV,CD]=swt2(GR00,1,'haar');%swt为多孔算法的非抽取小波变换，dwt为常规Mallat算法（每次分解后长度减小一半)
mzeros=zeros(size(CH));
YA=iswt2(CA,mzeros,mzeros,mzeros,'haar');
X=linspace(-150,150,300);
Y=linspace(-150,150,300);
mycolor=[0,172,164;192,192,254;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,100;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255; 
figure;pcolor(X,Y,GR00);
colormap(mycolor);
caxis([-5,70]);
shading flat;
colorbar;


mycolor1=[0,172,164;192,192,254;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,200;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255; 
axes('Position',[0.05,0.1,0.25,0.8]);
pcolor(X,Y,CH);
colormap(mycolor1);
caxis([-40,40]);
shading flat;
axes('Position',[0.35,0.1,0.25,0.8]);pcolor(X,Y,CV);
colormap(mycolor1);
caxis([-40,40]);
shading flat;
axes('Position',[0.65,0.1,0.25,0.8]);pcolor(X,Y,CD);
colormap(mycolor1);
caxis([-40,40]);
shading flat;
%axes('Position',[0.93,0.1,0.05,0.8]);colorbar


difference1=GR00-YA;
figure;pcolor(X,Y,difference1);colormap(mycolor);
%caxis([-30 30]);
caxis([min(min(difference1)) max(max(difference1))]);
shading flat;axis square;
ind1=find(GR00==0);
ind2=find(CA==0);
ind_difference=setdiff(ind1,ind2);
[m,n]=size(GR00);
D=zeros(m,n);
D(ind_difference)=YA(ind_difference); %At each level of the wavelet decomposition, as a result of the convolution of the field with the wavelet scaling function,
%a set of zero values next to the edges of the wetted areas becomes nonzero and subsequently the areas of nonzero pixels progressively grow from fine‐to‐coarse scales.
mycolor2=[0,172,164;245,245,245;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,200;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255; 
figure;pcolor(X,Y,D);colormap(mycolor2);
caxis([-1.5 max(max(D))]);
shading flat;axis square;

YH=iswt2(mzeros,CH,mzeros,mzeros,'haar');%水平向高频系数重构
figure;DrawPicture(X,Y,YH) 

% YA(ind_difference)=0;
% difference2=data1_SA-YA;
% figure;pcolor(X,Y,difference2);colormap(mycolor);
% caxis([-30 30]);
% %caxis([min(min(difference2)) max(max(difference2))]);
% shading flat;axis square;

% %查看低频小波系数的概率分布
% ind0=find(CA<=0);
% CA(ind0)=[];%只利用CA大于等于0的数,去除背景零点
% %CAZ=zscore(CA);
% CAZ0=reshape(CA,1,size(CA,1)*size(CA,2));
% t=min(CAZ0):0.3:max(CAZ0);
% [nCA,CAout]=hist(CAZ0,t);
% figure;plot(CAout,log(nCA))



%计算高频小波系数的概率分布
%说明高频小波系数分布的重尾性
%需要多个个例来说明高频小波系数的概率
ind0=find(CA<=0);
CH0=CH;
CH0(ind0)=[];%只利用CA大于等于0的数,去除背景零点应该CH(ind0)=[]
%CHZ=CH;
CHZ=zscore(CH0);%标准偏差归一化
CHZ0=reshape(CHZ,1,size(CHZ,1)*size(CHZ,2));
t=min(CHZ0):0.5:max(CHZ0);
[nCH,CHout]=hist(CHZ0,t);
CH_pdf =(nCH-min(nCH))./(max(nCH(:))-min(nCH(:)));%(nCH./sum(nCH(:))./(max(nCH(:))-min(nCH(:))));
%CH_pdf=nCH/max(nCH);
CHpdf_log=log(CH_pdf);
%CHpdf_log=log(nCH)/log(max(nCH));
figure;plot(CHout,CHpdf_log)

CV0=CV;
CV0(ind0)=[];%只利用CA大于等于0的数,去除背景零点应该CH(ind0)=[]
%CHZ=CH;
CVZ=zscore(CV0);%标准偏差归一化
CVZ0=reshape(CVZ,1,size(CVZ,1)*size(CVZ,2));
t=min(CVZ0):0.5:max(CVZ0);
[nCV,CVout]=hist(CVZ0,t);
CV_pdf =(nCV-min(nCV))./(max(nCV(:))-min(nCV(:)));%(nCH./sum(nCH(:))./(max(nCH(:))-min(nCH(:))));
%CH_pdf=nCH/max(nCH);
CVpdf_log=log(CV_pdf);
%CHpdf_log=log(nCH)/log(max(nCH));
figure;plot(CVout,CVpdf_log)

CD0=CD;
CD0(ind0)=[];%只利用CA大于等于0的数,去除背景零点应该CH(ind0)=[]
%CHZ=CH;
CDZ=zscore(CD0);%标准偏差归一化
CDZ0=reshape(CDZ,1,size(CDZ,1)*size(CDZ,2));
t=min(CDZ0):0.5:max(CDZ0);
[nCD,CDout]=hist(CDZ0,t);
CD_pdf =(nCD-min(nCD))./(max(nCD(:))-min(nCD(:)));%(nCH./sum(nCH(:))./(max(nCH(:))-min(nCH(:))));
%CH_pdf=nCH/max(nCH);
CDpdf_log=log(CD_pdf);
%CHpdf_log=log(nCH)/log(max(nCH));
figure;plot(CDout,CDpdf_log)
close;

axes('Position',[0.06,0.1,0.25,0.8]);
plot(CHout,CHpdf_log)
axes('Position',[0.37,0.1,0.25,0.8]);
plot(CVout,CVpdf_log)
axes('Position',[0.68,0.1,0.25,0.8]);
plot(CDout,CDpdf_log)

% %局部邻域概率分布
CH5=CH(250:259,50:59);
one_CH5=reshape(CH5,1,100);
[nn,hout]=hist(one_CH5);
figure;plot(hout,nn)


% mu=mean(CHZ0);
% sigma=std(CHZ0);
% CH_norm=normpdf(CHout,mu,sigma);
% figure;plot(CHout,log(CH_norm/max(CH_norm)));

%计算高频小波系数尺度内相关性
CH5=CH(100:104,100:104);
CH5_new=reshape(CH5,25,1);
CCH=CH5_new*CH5_new';
CCV=cov(CV);
CCD=cov(CD);
figure;pcolor(CCH);colormap(gray)
shading flat;axis square;

%根据文献Statistics of precipitation reflectivity images and cascadeof Gaussian‐scale mixtures in the wavelet domain:
%第14页计算的5*5邻域的协方差矩阵
%说明intrascale dependence
cov_CH=zeros(25,25);%5*5邻域的协方差矩阵
count=0;
for k1=3:m-2
    for k2=3:n-2
        CH5=CH(k1-2:k1+2,k2-2:k2+2);
        CH5_new=reshape(CH5,25,1);
        CCH=CH5_new*CH5_new';
        count=count+1;
        cov_CH=cov_CH+CCH;
    end
end
cov_CH=cov_CH/count;
figure;pcolor(cov_CH);colormap(gray)
shading flat;axis square;

cov_CV=zeros(25,25);%5*5邻域的协方差矩阵
count=0;
for k1=3:m-2
    for k2=3:n-2
        CV5=CV(k1-2:k1+2,k2-2:k2+2);
        CV5_new=reshape(CV5,25,1);
        CCV=CV5_new*CV5_new';
        count=count+1;
        cov_CV=cov_CV+CCV;
    end
end
cov_CV=cov_CV/count;
figure;pcolor(cov_CV);colormap(gray)
shading flat;axis square;

cov_CD=zeros(25,25);%5*5邻域的协方差矩阵
count=0;
for k1=3:m-2
    for k2=3:n-2
        CD5=CD(k1-2:k1+2,k2-2:k2+2);
        CD5_new=reshape(CD5,25,1);
        CCD=CD5_new*CD5_new';
        count=count+1;
        cov_CD=cov_CD+CCD;
    end
end
cov_CD=cov_CD/count;
figure;pcolor(cov_CD);colormap(gray)
shading flat;axis square;
close;

axes('Position',[0.05,0.1,0.25,0.8]);
pcolor(cov_CH);colormap(gray)
shading flat;axis square;
axes('Position',[0.36,0.1,0.25,0.8]);pcolor(cov_CV);colormap(gray)
shading flat;axis square;
axes('Position',[0.67,0.1,0.25,0.8]);pcolor(cov_CD);colormap(gray)
shading flat;axis square;

%save wavedec_SA.mat x1 x2

%说明scale-to-scale dependence