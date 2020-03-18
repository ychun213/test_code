%С���ֽ⣬2017/7/25

clc;clear;close all;
filename='D:\test\cape\Z_RADR_I_Z9250_20160606003100_O_DOR_SA_CAP.bin';
cut_SA=SAread(filename);
data1_SA=cut_SA(1).RefData;%��һ�����ǵ�����
R=1:1:cut_SA(1).GateNumber;
X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
ind=isnan(data1_SA);
data1_SA(ind)=0;

%[CA,CH,CV,CD]=dwt2(data1_SA,'Haar');%��ȡһ��ֽ��С��ϵ��
[CA,CH,CV,CD]=swt2(data1_SA,1,'Haar');%swtΪ����㷨�ķǳ�ȡС���任��dwtΪ����Mallat�㷨��ÿ�ηֽ�󳤶ȼ�Сһ��)

figure;DrawPicture(X,Y,data1_SA);title('ԭʼͼ��');
figure;DrawPicture(X,Y,CA);title('ƽ��ֵͼ��');
figure;DrawPicture(X,Y,CH);title('ˮƽ��С��ϵ��');
figure;DrawPicture(X,Y,CV);title('��ֱ��С��ϵ��');
figure;DrawPicture(X,Y,CD);title('�Խ���С��ϵ��');

%YA=idwt2(CA,[],[],[],'Haar');
%YH=idwt2([],CH,[],[],'Haar');
%YV=idwt2([],[],CV,[],'Haar');
%YD=idwt2([],[],[],CD,'Haar');




%�����ƵС��ϵ���ĸ��ʷֲ�
%˵����ƵС��ϵ���ֲ�����β��
%��Ҫ���������˵����ƵС��ϵ���ĸ���
ind0=find(CA<=0);
CH(ind0)=0;%ֻ����CA���ڵ���0����,ȥ���������Ӧ��CH(ind0)=[]
%CHZ=CH;
CHZ=zscore(CH);%��׼ƫ���һ��
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
plot(CHout,CHpdf_log);title('ˮƽ��С��ϵ�����ʷֲ�');

%�����ƵС��ϵ���ĸ��ʷֲ�
%˵����ƵС��ϵ���ֲ�����β��
%��Ҫ���������˵����ƵС��ϵ���ĸ���
ind0=find(CA<=0);
CV(ind0)=0;%ֻ����CA���ڵ���0����,ȥ���������Ӧ��CV(ind0)=[]
%CVZ=CV;
CVZ=zscore(CV);%��׼ƫ���һ��
CVZ0=reshape(CVZ,1,size(CVZ,1)*size(CVZ,2));
t=min(CVZ0):0.5:max(CVZ0);
[nCV,CVout]=hist(CVZ0,t);
CV_pdf =(nCV-min(nCV))./(max(nCV(:))-min(nCV(:)));%(nCV./sum(nCV(:))./(max(nCV(:))-min(nCV(:))));
%CV_pdf=nCV/max(nCV);
CVpdf_log=log(CV_pdf);
x1=CVZ0;
x2=CVout;
%CVpdf_log=log(nCV)/log(max(nCV));
figure;plot(CVout,CVpdf_log);title('��ֱ��С��ϵ�����ʷֲ�');

%�����ƵС��ϵ���ĸ��ʷֲ�
%˵����ƵС��ϵ���ֲ�����β��
%��Ҫ���������˵����ƵС��ϵ���ĸ���
ind0=find(CA<=0);
CD(ind0)=0;%ֻ����CA���ڵ���0����,ȥ���������Ӧ��CD(ind0)=[]
%CDZ=CD;
CDZ=zscore(CD);%��׼ƫ���һ��
CDZ0=reshape(CDZ,1,size(CDZ,1)*size(CDZ,2));
t=min(CDZ0):0.5:max(CDZ0);
[nCD,CDout]=hist(CDZ0,t);
CD_pdf =(nCD-min(nCD))./(max(nCD(:))-min(nCD(:)));%(nCD./sum(nCD(:))./(max(nCD(:))-min(nCD(:))));
%CD_pdf=nCD/max(nCD);
CDpdf_log=log(CD_pdf);
x1=CDZ0;
x2=CDout;
%CDpdf_log=log(nCD)/log(max(nCD));
figure;plot(CDout,CDpdf_log);title('�Խ���С��ϵ�����ʷֲ�');




%CHpdf_log��infֵ����ȥ��
x1=CHout;
y1=CHpdf_log;
yy1=isinf(y1);
y_1=find(yy1==1);
y1(y_1)=(y1(y_1+1)+y1(y_1-1))./2;

x2=CVout;
y2=CVpdf_log;
yy2=isinf(y2);
y_2=find(yy2==1);
y2(y_2)=(y2(y_2+1)+y2(y_2-1))./2;

x3=CDout;
y3=CDpdf_log;
yy3=isinf(y3);
y_3=find(yy3==1);
y3(y_3)=(y3(y_3+2)+y3(y_3-2))./2;

laplace=fittype(@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
[laplacefit,gof3]=fit(x1',y1',laplace);
figure;
plot( x1,laplacefit(x1), 'y-');

laplace=fittype(@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
[laplacefit,gof3]=fit(x2',y2',laplace);
figure;
plot( x2,laplacefit(x2), 'y-');

laplace=fittype(@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
[laplacefit,gof3]=fit(x3',y3',laplace);
figure;
plot( x3,laplacefit(x3), 'y-');
