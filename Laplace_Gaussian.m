

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
x1=CHZ0;
x2=CHout;
%CHpdf_log=log(nCH)/log(max(nCH));
figure;
plot(CHout,CHpdf_log);title('水平向小波系数概率分布');


CHpdf_log(45)=-9.5

% %%CHpdf_log有inf值，需处理
x1=CHout;
y=CHpdf_log;
y1=y+12;
% yy1=isinf(y1);
% y_1=find(yy1==1);
% y1(y_1)=((y1(y_1+1)+y1(y_1-1))./2);


%% 拉普拉斯拟合
laplace=fittype('a*exp(-abs(x)./c)');   %@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
% 其中a是振幅，b是期望，c是标准差，d是直流分量
total_x1=numel(x1);
%sP_idx = [round(0.2*total_x1), round(0.4*total_x1),round(0.6*total_x1), round(0.8*total_x1)]; % 选取X轴上等间距的四个点
sP_idx = [15,30];
startPoints = x1(sP_idx); % 将上述4个点设置为'Start'参数
[laplacefit,gof3]=fit(x1(:),y1(:),laplace,'Start',startPoints); % laplace拟合
yy1 = laplacefit.a*exp( -abs(x1)./laplacefit.c ); %得到拟合后的laplace曲线
yy=yy1-12;
y1=y1-12;

%laplace=fittype(@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
%[laplacefit,gof3]=fit(x1',y1',laplace);
%yy=laplacefit(x1);

%% Laplace绘图
figure; plot(x1, y1, 'b.');  % 绘制数据点
hold on; plot(x1 ,yy, 'r');title('laplace拟合');  % 绘制拟合的laplace曲线
legend('原始数据', '拟合数据')

%% 输出laplace拟合得到的参数
A_Laplace = laplacefit.a; % 幅值
%mu_Laplace = laplacefit.b; % 期望
sigma_Laplace = laplacefit.c; % 标准差




%% 高斯拟合
%fun = fittype('a*exp(-((x-b)/c)^2)+d'); % 确定高斯函数的表达形式
% 其中a是振幅，b是期望，c是标准差，d是直流分量
%sP_idx = [round(0.2*numel(x1)), round(0.4*numel(x1)),round(0.6*numel(x1)), round(0.8*numel(x1))]; % 选取X轴上等间距的四个点
%startPoints = x1(sP_idx); % 将上述4个点设置为'Start'参数
%[cf,gof] = fit(x1(:),y1(:),fun,'Start',startPoints); % 高斯拟合
%yy = cf.a*exp( -((x1-cf.b)/cf.c).^2 )+cf.d; %得到拟合后的高斯曲线
 
%% Gaussian绘图
%figure; plot(x1, y1, 'b.');  % 绘制数据点
%hold on; plot(x1 ,yy, 'r');title('高斯拟合');  % 绘制拟合的高斯曲线
%legend('原始数据', '拟合数据')

%% 输出高斯拟合得到的参数
%A_Gaussian = cf.a; % 幅值
%mu_Gaussian = cf.b; % 期望
%sigma_Gaussian = cf.c; % 标准差
