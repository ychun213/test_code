clc;clear;close all;
filename='E:\test\cape\Z_RADR_I_Z9250_20160501165900_O_DOR_SA_CAP.bin';
cut_SA=SAread(filename);
data1_SA=cut_SA(1).RefData;%第一层仰角的数据
R=1:1:cut_SA(1).GateNumber;
X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
ind=isnan(data1_SA);
data1_SA(ind)=0;

%[CA,CH,CV,CD]=dwt2(data1_SA,'Haar');%提取一层分解的小波系数
[CA,CH,CV,CD]=swt2(data1_SA,1,'Haar');%swt为多孔算法的非抽取小波变换，dwt为常规Mallat算法（每次分解后长度减小一半)

%figure;DrawPicture(X,Y,data1_SA);title('原始图像');
%figure;DrawPicture(X,Y,CA);title('平均值图像');
%figure;DrawPicture(X,Y,CH);title('水平向小波系数');
%figure;DrawPicture(X,Y,CV);title('垂直向小波系数');
%figure;DrawPicture(X,Y,CD);title('对角向小波系数');

%YA=idwt2(CA,[],[],[],'Haar');
%YH=idwt2([],CH,[],[],'Haar');
%YV=idwt2([],[],CV,[],'Haar');
%YD=idwt2([],[],[],CD,'Haar');


%计算高频小波系数的概率分布
%说明高频小波系数分布的重尾性
%需要多个个例来说明高频小波系数的概率
ind0=find(CA<=0);
CH(ind0)=[];%只利用CA大于等于0的数,去除背景零点应该CH(ind0)=[]
%CHZ=CH;
CHZ=zscore(CH);%标准偏差归一化
CHZ0=reshape(CHZ,1,size(CHZ,1)*size(CHZ,2));
t=min(CHZ0):0.5:max(CHZ0);
[nCH,CHout]=hist(CHZ0,t);
CH_pdf =(nCH-min(nCH))./(max(nCH(:))-min(nCH(:)));%(nCH./sum(nCH(:))./(max(nCH(:))-min(nCH(:))));
%CH_pdf=nCH/max(nCH);
CHpdf_log=log(CH_pdf);

CHpdf_log(45) = -9;
CHpdf_log=CHpdf_log+10;

figure;
plot(CHout,CHpdf_log);
xi = CHout;  
yi = CHpdf_log;

gg=fittype(@(s, p ,x) 1 / ( 2*gamma(1+1/p)*( s^2*gamma(1/p)/gamma(3/p) )^0.5 )* exp(-abs( x ./ (( s^2*gamma(1/p)/gamma(3/p) )^0.5) ).^p),'independent','x');

opt=fitoptions(gg);
opt.StartPoint=[1 2];
%[laplacefit,gof3]=fit(xi',yi',laplace,opt);
ggfit=fit(xi',yi',gg,opt);

figure; plot(ggfit,xi, yi, 'b.');  % 绘制数据点

%% 输出laplace拟合得到的参数
A_Laplace = laplacefit.a; % 幅值
%mu_Laplace = laplacefit.b; % 期望
sigma_Laplace = laplacefit.b; % 标准差