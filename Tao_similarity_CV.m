%建立GSM模型，进行高分辨率重建

clc;clear;close all
filename='D:\test\cape\Z_RADR_I_Z9250_20160706111400_O_DOR_SA_CAP.bin';
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
CV1=CV(:,:,1);
CV2=CV(:,:,2);
CV3=CV(:,:,3);
CV4=CV(:,:,4);
CV1(ind1)=[];%只利用CA大于等于0的数,去除背景零点
 CV2(ind2)=[];
 CV3(ind3)=[];
 CV4(ind4)=[];
[mm1,nn1]=size(CV1);
[mm2,nn2]=size(CV2);
[mm3,nn3]=size(CV3);
[mm4,nn4]=size(CV4);
CV1=reshape(CV1,1,mm1*nn1);
CV2=reshape(CV2,1,mm2*nn2);
CV3=reshape(CV3,1,mm3*nn3);
CV4=reshape(CV4,1,mm4*nn4);
a1=mean(abs(CV1));b1=var(CV1);
a2=mean(abs(CV2));b2=var(CV2);
a3=mean(abs(CV3));b3=var(CV3);
a4=mean(abs(CV4));b4=var(CV4);
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