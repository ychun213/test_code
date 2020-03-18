%С���ֽ⣬2017/7/25

clc;clear;close all
filename='D:\test\cape\Z_RADR_I_Z9250_20160606003100_O_DOR_SA_CAP.bin';
cut_SA=SAread(filename);
data1_SA=cut_SA(1).RefData;%��һ�����ǵ�����
R=1:1:cut_SA(1).GateNumber;
X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
ind=isnan(data1_SA);
data1_SA(ind)=0;
% [CA,CH,CV,CD]=dwt2(data1_SA,'db1');%��ȡһ��ֽ��С��ϵ��
% YA=idwt2(CA,[],[],[],'db1');
[CA,CH,CV,CD]=swt2(data1_SA,1,'haar');%swtΪ����㷨�ķǳ�ȡС���任��dwtΪ����Mallat�㷨��ÿ�ηֽ�󳤶ȼ�Сһ��)
mzeros=zeros(size(CH));
YA=iswt2(CA,mzeros,mzeros,mzeros,'haar');
figure;Draw_P(X,Y,data1_SA)

figure;Draw_P(X,Y,CH)

figure;Draw_P(X,Y,YA);
difference1=data1_SA-YA;
mycolor=[0,172,164;192,192,254;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,100;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255; %��ʦ������ɫ��ͼ
figure;pcolor(X,Y,difference1);colormap(mycolor);
caxis([-30 30]);
%caxis([min(min(difference1)) max(max(difference1))]);
shading flat;axis square;
ind1=find(data1_SA==0);
ind2=find(CA==0);
ind_difference=setdiff(ind1,ind2);
[m,n]=size(data1_SA);
D=zeros(m,n);
D(ind_difference)=YA(ind_difference); %At each level of the wavelet decomposition, as a result of the convolution of the field with the wavelet scaling function,
%a set of zero values next to the edges of the wetted areas becomes nonzero and subsequently the areas of nonzero pixels progressively grow from fine�\to�\coarse scales.
figure;pcolor(X,Y,D);colormap(mycolor);


%figure;Draw_P(X,Y,D);
caxis([min(min(D)) max(max(D))]);
shading flat;axis square;

YH=iswt2(mzeros,CH,mzeros,mzeros,'db1');%ˮƽ���Ƶϵ���ع�
figure;Draw_P(X,Y,YH) 

% YA(ind_difference)=0;
% difference2=data1_SA-YA;
% figure;pcolor(X,Y,difference2);colormap(mycolor);
% caxis([-30 30]);
% %caxis([min(min(difference2)) max(max(difference2))]);
% shading flat;axis square;

%�鿴��ƵС��ϵ���ĸ��ʷֲ�
ind0=find(CA<=0);
CA(ind0)=[];%ֻ����CA���ڵ���0����,ȥ���������
%CAZ=zscore(CA);
CAZ0=reshape(CA,1,size(CA,1)*size(CA,2));
t=min(CAZ0):0.3:max(CAZ0);
[nCA,CAout]=hist(CAZ0,t);
figure;plot(CAout,log(nCA))



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
figure;plot(CHout,CHpdf_log)

% %�ֲ�������ʷֲ�
CH5=CH(250:259,50:59);
one_CH5=reshape(CH5,1,100);
[nn,hout]=hist(one_CH5);
figure;plot(hout,nn)
% CH5=zeros(5,5);
% count=0;
% for k1=3:m-2
%     for k2=3:n-2
%         CH5=CH5+CH(k1-2:k1+2,k2-2:k2+2);
%         count=count+1;
%        end
% end
% CH5=CH5/count;
% CH5_new=reshape(CH5,1,25);
% CH5_new=zecores(CH5_new);
% t=min(CH5_new):0.3:max(CH5_new);
% [nCH,CHout]=hist(CH5_new,t);
% CH_pdf =(nCH-min(nCH))./(max(nCH(:))-min(nCH(:)));%(nCH./sum(nCH(:))./(max(nCH(:))-min(nCH(:))));
% CHpdf_log=log(CH_pdf);
% figure;plot(CHout,CHpdf_log)



% mu=mean(CHZ0);
% sigma=std(CHZ0);
% CH_norm=normpdf(CHout,mu,sigma);
% figure;plot(CHout,log(CH_norm/max(CH_norm)));

%�����ƵС��ϵ���߶��������
CH5=CH(100:104,100:104);
CH5_new=reshape(CH5,25,1);
CCH=CH5_new*CH5_new';
CCV=cov(CV);
CCD=cov(CD);
figure;pcolor(CCH);colormap(gray)
shading flat;axis square;

%��������Statistics of precipitation reflectivity images and cascadeof Gaussian�\scale mixtures in the wavelet domain:
%��14ҳ�����5*5�����Э�������
%˵��intrascale dependence
cov_CH=zeros(25,25);%5*5�����Э�������
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

cov_CV=zeros(25,25);%5*5�����Э�������
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

save E:\test\wavedec_SA.mat x1 x2

%˵��scale-to-scale dependence