%建立GSM模型，进行高分辨率重建

clc;clear;close all
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
[CA,CH,CV,CD]=swt2(data2_SA,4,'haar');%提取一层分解的小波系数
CA1=CA(:,:,1);
CA2=CA(:,:,2);
CA3=CA(:,:,3);
CA4=CA(:,:,4);
ind1=find(CA1<=0);
ind2=find(CA(:,:,2)<=0);
ind3=find(CA(:,:,3)<=0);
ind4=find(CA(:,:,4)<=0);

CH1=CH(:,:,1);
CH2=CH(:,:,2);
CH3=CH(:,:,3);
CH4=CH(:,:,4);
CH1(ind1)=[];%只利用CA大于等于0的数,去除背景零点
CH2(ind2)=[];
CH3(ind3)=[];
CH4(ind4)=[];

[mm1,nn1]=size(CH1);
[mm2,nn2]=size(CH2);
[mm3,nn3]=size(CH3);
[mm4,nn4]=size(CH4);
CH1=reshape(CH1,1,mm1*nn1);
CH2=reshape(CH2,1,mm2*nn2);
CH3=reshape(CH3,1,mm3*nn3);
CH4=reshape(CH4,1,mm4*nn4);
a1=mean(abs(CH1));b1=var(CH1);
a2=mean(abs(CH2));b2=var(CH2);
a3=mean(abs(CH3));b3=var(CH3);
a4=mean(abs(CH4));b4=var(CH4);
a=[a1 a2 a3 a4];
y=log(a);
x=[1 2 3 4];
figure;semilogy(log(a),'r*')
p=polyfit(x,y,1);
taoH1=p(1)./log(2);
figure;plot(a,'r*');

hold on
plot(2.^(x*taoH1)*exp(p(2))) %把对数换成指数形式
hold off


b=[b1 b2 b3 b4];
figure;semilogy(log(b),'r*')
pb=polyfit(x,log(b),1);
taoH2=pb(1)./log(2);
figure;plot(b,'r*');
hold on
plot(2.^(x*taoH2)*exp(pb(2))) %把对数换成指数形式
hold off

% 
% %V向小波系数间的统计关系
% CV1=CV(:,:,1);
% CV2=CV(:,:,2);
% CV3=CV(:,:,3);
% CV4=CV(:,:,4);
% CV1(ind1)=[];%只利用CA大于等于0的数,去除背景零点
% CV2(ind1)=[];
% CV3(ind1)=[];
% CV4(ind1)=[];
% [mm1,nn1]=size(CV1);
% [mm2,nn2]=size(CV2);
% [mm3,nn3]=size(CV3);
% [mm4,nn4]=size(CV4);
% CV1=reshape(CV1,1,mm1*nn1);
% CV2=reshape(CV2,1,mm2*nn2);
% CV3=reshape(CV3,1,mm3*nn3);
% CV4=reshape(CV4,1,mm4*nn4);
% c1=mean(abs(CV1));d1=var(CV1);
% c2=mean(abs(CV2));d2=var(CV2);
% c3=mean(abs(CV3));d3=var(CV3);
% c4=mean(abs(CV4));d4=var(CV4);
% c=[c1 c2 c3 c4];
% %figure;plot(a,'r*')
% y=log(c);
% x=[1 2 3 4];
% figure;semilogy(log(c),'r*')
% pv1=polyfit(x,y,1);
% taoV1=pv1(1)./log(2);
% figure;plot(c,'r*');
% hold on
% plot(2.^(x*taoV1)*exp(pv1(2))) %把对数换成指数形式
% hold off
% d=[d1 d2 d3 d4];
% figure;semilogy(log(d),'r*')
% pv2=polyfit(x,log(d),1);
% taoV2=pv2(1)./log(2);
% figure;plot(d,'r*');
% hold on
% plot(2.^(x*taoV2)*exp(pv2(2))) %把对数换成指数形式
% hold off
% 
% %D向小波系数间的统计关系
% CD1=CD(:,:,1);
% CD2=CD(:,:,2);
% CD3=CD(:,:,3);
% CD4=CD(:,:,4);
% CD1(ind1)=[];%只利用CA大于等于0的数,去除背景零点
% CD2(ind1)=[];
% CD3(ind1)=[];
% CD4(ind1)=[];
% [mm1,nn1]=size(CD1);
% [mm2,nn2]=size(CD2);
% [mm3,nn3]=size(CD3);
% [mm4,nn4]=size(CD4);
% CD1=reshape(CD1,1,mm1*nn1);
% CD2=reshape(CD2,1,mm2*nn2);
% CD3=reshape(CD3,1,mm3*nn3);
% CD4=reshape(CD4,1,mm4*nn4);
% e1=mean(abs(CD1));f1=var(CD1);
% e2=mean(abs(CD2));f2=var(CD2);
% e3=mean(abs(CD3));f3=var(CD3);
% e4=mean(abs(CD4));f4=var(CD4);
% e=[e1 e2 e3 e4];
% %figure;plot(a,'r*')
% y=log(e);
% x=[1 2 3 4];
% figure;semilogy(log(e),'r*')
% pd1=polyfit(x,y,1);
% taoD1=pd1(1)./log(2);
% figure;plot(e,'r*');
% hold on
% plot(2.^(x*taoD1)*exp(pd1(2))) %把对数换成指数形式
% hold off
% f=[f1 f2 f3 f4];
% figure;semilogy(log(f),'r*')
% pd2=polyfit(x,log(f),1);
% taoD2=pd2(1)./log(2);
% figure;plot(f,'r*');
% hold on
% plot(2.^(x*taoD2)*exp(pd2(2))) %把对数换成指数形式
% hold off
% 
% save E:\test\simalarity_tao.mat
