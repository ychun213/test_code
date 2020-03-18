

clc;clear;close all;
filename='E:\test\cape\Z_RADR_I_Z9250_20160501165900_O_DOR_SA_CAP.bin';
cut_SA=SAread(filename);
data1_SA=cut_SA(1).RefData;%��һ�����ǵ�����
R=1:1:cut_SA(1).GateNumber;
X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
ind=isnan(data1_SA);
data1_SA(ind)=0;

%[CA,CH,CV,CD]=dwt2(data1_SA,'Haar');%��ȡһ��ֽ��С��ϵ��
[CA,CH,CV,CD]=swt2(data1_SA,1,'Haar');%swtΪ����㷨�ķǳ�ȡС���任��dwtΪ����Mallat�㷨��ÿ�ηֽ�󳤶ȼ�Сһ��)

%figure;DrawPicture(X,Y,data1_SA);title('ԭʼͼ��');
%figure;DrawPicture(X,Y,CA);title('ƽ��ֵͼ��');
%figure;DrawPicture(X,Y,CH);title('ˮƽ��С��ϵ��');
%figure;DrawPicture(X,Y,CV);title('��ֱ��С��ϵ��');
%figure;DrawPicture(X,Y,CD);title('�Խ���С��ϵ��');

%YA=idwt2(CA,[],[],[],'Haar');
%YH=idwt2([],CH,[],[],'Haar');
%YV=idwt2([],[],CV,[],'Haar');
%YD=idwt2([],[],[],CD,'Haar');




%�����ƵС��ϵ���ĸ��ʷֲ�
%˵����ƵС��ϵ���ֲ�����β��
%��Ҫ���������˵����ƵС��ϵ���ĸ���
ind0=find(CA<=0);
CH(ind0)=[];%ֻ����CA���ڵ���0����,ȥ���������Ӧ��CH(ind0)=[]
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


CHpdf_log(45)=-9.5

% %%CHpdf_log��infֵ���账��
x1=CHout;
y=CHpdf_log;
y1=y+12;
% yy1=isinf(y1);
% y_1=find(yy1==1);
% y1(y_1)=((y1(y_1+1)+y1(y_1-1))./2);


%% ������˹���
laplace=fittype('a*exp(-abs(x)./c)');   %@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
% ����a�������b��������c�Ǳ�׼�d��ֱ������
total_x1=numel(x1);
%sP_idx = [round(0.2*total_x1), round(0.4*total_x1),round(0.6*total_x1), round(0.8*total_x1)]; % ѡȡX���ϵȼ����ĸ���
sP_idx = [15,30];
startPoints = x1(sP_idx); % ������4��������Ϊ'Start'����
[laplacefit,gof3]=fit(x1(:),y1(:),laplace,'Start',startPoints); % laplace���
yy1 = laplacefit.a*exp( -abs(x1)./laplacefit.c ); %�õ���Ϻ��laplace����
yy=yy1-12;
y1=y1-12;

%laplace=fittype(@(a,b,x) 1./(2*b)*exp(-abs(x-a)./b));
%[laplacefit,gof3]=fit(x1',y1',laplace);
%yy=laplacefit(x1);

%% Laplace��ͼ
figure; plot(x1, y1, 'b.');  % �������ݵ�
hold on; plot(x1 ,yy, 'r');title('laplace���');  % ������ϵ�laplace����
legend('ԭʼ����', '�������')

%% ���laplace��ϵõ��Ĳ���
A_Laplace = laplacefit.a; % ��ֵ
%mu_Laplace = laplacefit.b; % ����
sigma_Laplace = laplacefit.c; % ��׼��




%% ��˹���
%fun = fittype('a*exp(-((x-b)/c)^2)+d'); % ȷ����˹�����ı����ʽ
% ����a�������b��������c�Ǳ�׼�d��ֱ������
%sP_idx = [round(0.2*numel(x1)), round(0.4*numel(x1)),round(0.6*numel(x1)), round(0.8*numel(x1))]; % ѡȡX���ϵȼ����ĸ���
%startPoints = x1(sP_idx); % ������4��������Ϊ'Start'����
%[cf,gof] = fit(x1(:),y1(:),fun,'Start',startPoints); % ��˹���
%yy = cf.a*exp( -((x1-cf.b)/cf.c).^2 )+cf.d; %�õ���Ϻ�ĸ�˹����
 
%% Gaussian��ͼ
%figure; plot(x1, y1, 'b.');  % �������ݵ�
%hold on; plot(x1 ,yy, 'r');title('��˹���');  % ������ϵĸ�˹����
%legend('ԭʼ����', '�������')

%% �����˹��ϵõ��Ĳ���
%A_Gaussian = cf.a; % ��ֵ
%mu_Gaussian = cf.b; % ����
%sigma_Gaussian = cf.c; % ��׼��
