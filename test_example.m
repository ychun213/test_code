
clc;clear;close all;
a=[1.2 2 5 14];
%a=[1.2 2 5 14];
y=log(a);
x=[1 2 3 4];
figure;semilogy(log(a),'r*')
p=polyfit(x,y,1);
taoH1=p(1)./log(2);
figure;plot(a,'r*');
hold on
plot(2.^(x*taoH1)*exp(p(2))) %把对数换成指数形式



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
t=min(CHZ0):0.3:max(CHZ0);
[nCH,CHout]=hist(CHZ0,t);

CH_pdf =(nCH-min(nCH))./(max(nCH(:))-min(nCH(:)));

CH_pdf0 = find(CH_pdf==0);
CH_pdf0_size = size(CH_pdf0);
for i = 1:1:max(CH_pdf0_size)
    CH_pdf(CH_pdf0) = ((CH_pdf(CH_pdf0-1)+CH_pdf(CH_pdf0+1))./2);
end



%CH_pdf(CH_pdf0) = (CH_pdf(CH_pdf0-1)+CH_pdf(CH_pdf0+1)./2);



% CH_pdf(74)=0.000176149374669720;
% CH_pdf(75)=0.000176149374669720;
% CH_pdf(76)=0.000176149374669720;
%plot(CHout,CH_pdf)

%CH_pdf = (nCH./sum(nCH(:))./(max(nCH(:))-min(nCH(:))));
%CH_pdf = nCH/max(nCH);
CHpdf_log=log(CH_pdf);

%CHpdf_log(45) = -9;

CHpdf_log=CHpdf_log+10;
figure;
plot(CHout,CHpdf_log);
xi = CHout;  
yi = CHpdf_log;

laplace=fittype(@(a,x) (0.5./a)*exp(-abs(x)./a),'independent','x');    %a*exp(-abs(x)./b)

opt=fitoptions(laplace);
opt.StartPoint=[20];
%[laplacefit,gof3]=fit(xi',yi',laplace,opt);
laplacefit=fit(xi',yi',laplace,opt);

figure; plot(laplacefit,xi, yi, 'b.');  % 绘制数据点

% %% 输出laplace拟合得到的参数
% A_Laplace = laplacefit.a; % 幅值
% %mu_Laplace = laplacefit.b; % 期望
% %sigma_Laplace = laplacefit.b; % 标准差


%%
clc;clear;close all;
x=[2,4,5,6,6.8,7.5,9,12,13.3,15];
y=[-10,-6.9,-4.2,-2,0,2.1,3,5.2,6.4,4.5];
[~,k]=size(x);
for n=1:9
    X0=zeros(n+1,k);
    for k0=1:k           %构造矩阵X0
        for n0=1:n+1
            X0(n0,k0)=x(k0)^(n+1-n0);
        end
    end
    X=X0';
    ANSS=(X'*X)\X'*y';
    for i=1:n+1          %answer矩阵存储每次求得的方程系数，按列存储
       answer(i,n)=ANSS(i);
   end
    x0=0:0.01:17;
    y0=ANSS(1)*x0.^n    ;%根据求得的系数初始化并构造多项式方程
    for num=2:1:n+1     
        y0=y0+ANSS(num)*x0.^(n+1-num);
    end
    subplot(3,3,n)
    plot(x,y,'*')
    hold on
    plot(x0,y0)
end
suptitle('不同次数方程曲线拟合结果，从1到9阶')
