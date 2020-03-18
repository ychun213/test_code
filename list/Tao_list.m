% 建立GSM模型，进行高分辨率重建

clc;clear;close all

file=dir('D:\test\list\SA_list\*.bin');

taoH = [];


for i=1:length(file)
    
    file_folder = {'file(i).folder'};
    file_name = {'file(i).name'};
    filename = strcat(file(i).folder,92,file(i).name);
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
    ind2=find(CA2<=0);
    ind3=find(CA3<=0);
    ind4=find(CA4<=0);

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
    a1=mean(abs(CH1));
    a2=mean(abs(CH2));
    a3=mean(abs(CH3));
    a4=mean(abs(CH4));
    a=[a1 a2 a3 a4];
    y=log(a);
    x=[1 2 3 4];
    p=polyfit(x,y,1);
    taoH1=p(1)./log(2);
    
    
    taoH = [taoH taoH1]
    
       
    
%temp=SAread(['D:\test\',file(n).name],' ',0,1);
%eval([file(n).name(1:end-4),'=temp;'])

end

save D:\test\list\taoH.mat taoH   %%保存指定变量



% filename='D:\test\list\Z_RADR_I_Z9250_20160819144200_O_DOR_SA_CAP.bin';
% cut_SA=SAread(filename);
% data1_SA=cut_SA(1).RefData;%第一层仰角的数据
% R=1:1:cut_SA(1).GateNumber;
% X=R'*cosd(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
% Y=R'*sind(cut_SA(1).Theta)*cosd(cut_SA(1).ElevationAngle);
% ind=isnan(data1_SA);
% data1_SA(ind)=0;
% [m,n]=size(data1_SA);
% data1_SA=[data1_SA zeros(m,1) zeros(m,1)];%将366列扩展成368列，便于小波二级分解
% [m,n]=size(data1_SA);
% data2_SA=[data1_SA;zeros(1,n);zeros(1,n);zeros(1,n);zeros(1,n)];%将460行扩展成464行，便于小波三级分解
% [CA,CH,CV,CD]=swt2(data2_SA,4,'haar');%提取一层分解的小波系数
% CA1=CA(:,:,1);
% CA2=CA(:,:,2);
% CA3=CA(:,:,3);
% CA4=CA(:,:,4);
% ind1=find(CA1<=0);
% ind2=find(CA2<=0);
% ind3=find(CA3<=0);
% ind4=find(CA4<=0);
% 
% CH1=CH(:,:,1);
% CH2=CH(:,:,2);
% CH3=CH(:,:,3);
% CH4=CH(:,:,4);
% CH1(ind1)=[];%只利用CA大于等于0的数,去除背景零点
% CH2(ind2)=[];
% CH3(ind3)=[];
% CH4(ind4)=[];
% 
% [mm1,nn1]=size(CH1);
% [mm2,nn2]=size(CH2);
% [mm3,nn3]=size(CH3);
% [mm4,nn4]=size(CH4);
% CH1=reshape(CH1,1,mm1*nn1);
% CH2=reshape(CH2,1,mm2*nn2);
% CH3=reshape(CH3,1,mm3*nn3);
% CH4=reshape(CH4,1,mm4*nn4);
% a1=mean(abs(CH1));
% a2=mean(abs(CH2));
% a3=mean(abs(CH3));
% a4=mean(abs(CH4));
% a=[a1 a2 a3 a4];
% y=log(a);
% x=[1 2 3 4];
% p=polyfit(x,y,1);
% taoH1=p(1)./log(2);

