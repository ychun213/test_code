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

%CHpdf_log=CHpdf_log+9;
figure;
plot(CHout,CHpdf_log);
xi = CHout;  
yi = CHpdf_log;

plot(xi,yi,'r.')

gg=fittype(@(a,b,x) (a./(2 .* b .* gamma(1./a))) .* exp((abs(x ./ b)) .^ a),'independent','x');    %a*exp(-abs(x)./b)

opt=fitoptions(gg);
opt.StartPoint=[1 2];
%[laplacefit,gof3]=fit(xi',yi',laplace,opt);
ggfit=fit(xi',yi',gg,opt);


figure; plot(ggfit,xi, yi, 'b.');  % �������ݵ�

%% ���laplace��ϵõ��Ĳ���
A_gg = ggfit.a; % ��ֵ
%mu_Laplace = laplacefit.b; % ����
sigma_gg = ggfit.b; % ��׼��

