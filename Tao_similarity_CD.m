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
CD1=CD(:,:,1);
CD2=CD(:,:,2);
CD3=CD(:,:,3);
CD4=CD(:,:,4);
CD1(ind1)=[];%只利用CA大于等于0的数,去除背景零点
 CD2(ind2)=[];
 CD3(ind3)=[];
 CD4(ind4)=[];
[mm1,nn1]=size(CD1);
[mm2,nn2]=size(CD2);
[mm3,nn3]=size(CD3);
[mm4,nn4]=size(CD4);
CD1=reshape(CD1,1,mm1*nn1);
CD2=reshape(CD2,1,mm2*nn2);
CD3=reshape(CD3,1,mm3*nn3);
CD4=reshape(CD4,1,mm4*nn4);
a1=mean(abs(CD1));b1=var(CD1);
a2=mean(abs(CD2));b2=var(CD2);
a3=mean(abs(CD3));b3=var(CD3);
a4=mean(abs(CD4));b4=var(CD4);
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