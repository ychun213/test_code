function[FG]=CAPPI_SA(height,resolution,cut)
% CAPPI程序：在径向上采用最邻法，然后在方位和仰角上进行线性插值[适用于SA雷达]
% 作者：李应超
% 时间：2016年1月～3月,2016年10月修改为适用于SA雷达的计算
%输入参数：
%           mm:需要输出的参量类型，如1：表示反射率因子 3：V 5：ZDR 6：KDP 7：faiDP 8:CC 10:Zc
%           height：高度，单位m
%           resolution：分辨率，单位m，resolution=100，则分辨率为100m*100m
%           cut：雷达体扫数据
%输出参数：  FG为一个矩阵，矩阵存储cappi数据
%% 测试参数
% height=1000;
% resolution=500;
% mm=1; %%参量标识符，1表示反射率因子Z
%% 得到resolution×resolution的网格，扫描半径固定为150km
x2=0:resolution:150000;
x1=-150000:resolution:-resolution;
x=[x1,x2];
clear x1 x2
y=x;
% x=x+1785; %格点平移，使其和CDP的格点一一对应
% y=y+1914;
%% 求笛卡尔坐标中每一点（X，Y，Z）对应到雷达球坐标（Phi,Theta)
z=height;  %高度
FG=zeros(length(x),length(x)); %%初始化FG（预分配内存），FG为cappi矩阵
for jj=1:length(y) %jj代表y(行）的个数
    for ii=1:length(x)%ii代表x（列）的个数
        phi=atand(z/sqrt(x(ii)^2+y(jj)^2));%目标点的仰角
        if(x(ii)>0)
            theta=90-atand(y(jj)/x(ii)); %目标点的方位角
        elseif(x(ii)<0)
            theta=270-atand(y(jj)/x(ii));
        elseif(x(ii)==0&&y(jj)>0)
            theta=0;
        elseif (x(ii)==0&&y(jj)<0)
            theta=180;
        elseif(y(jj)==0&&x(ii)<0)
            theta=270;
        elseif(y(jj)==0&&x(ii)>0)
            theta=90;
        elseif(x(ii)==0&&y(jj)==0)
            FG(jj,ii)=NaN;
            continue;
        else
            error('x,y,z坐标参数错误\n')
        end
        
        %% 找与phi角相邻层号
        start_cut=0;
        EL=[cut.ElevationAngle];
        for kk=1:8 %雷达体扫层数，共9层
            if(phi>=EL(kk) && phi<=EL(kk+1))
                start_cut=kk;
                break
            end
        end
        if(start_cut==0)
            FG(jj,ii)=NaN;
            continue;
        end
        %% 求第一层上的相邻方位角
        AZ=abs([cut(start_cut).AzimuthAngle]-theta);
        [~,start_AZ1]=min(AZ);
        AZ(start_AZ1)=max(AZ);
        [~,end_AZ1]=min(AZ);
        %% 求第二层角上的相邻方位角
        AZ=abs([cut(start_cut+1).AzimuthAngle]-theta);
        [~,start_AZ2]=min(AZ);
        AZ(start_AZ2)=max(AZ);
        [~,end_AZ2]=min(AZ);
        
        %% 在第一层径向上插值
        s = sqrt(x(ii)^2+y(jj)^2)/cosd(cut(start_cut).ElevationAngle); %插值点径向上离雷达中心的距离
        if(s>(cut(start_cut).GateNumber*1000) || s > 150000)
            FG(jj,ii)=NaN;
            continue;
        end
        FA1 = cut(start_cut).RefData(floor(s/1000),start_AZ1)+(cut(start_cut).RefData(ceil(s/1000),start_AZ1)-cut(start_cut).RefData(floor(s/1000),start_AZ1))*(mod(s,1000)/1000);       
        FB1 = cut(start_cut).RefData(floor(s/1000),end_AZ1)+(cut(start_cut).RefData(ceil(s/1000),end_AZ1)-cut(start_cut).RefData(floor(s/1000),end_AZ1))*(mod(s,1000)/1000);  
        %% 在第二层径向上插值
        s = sqrt(x(ii)^2+y(jj)^2)/cosd(cut(start_cut+1).ElevationAngle); %插值点径向上离雷达中心的距离
        if(s>(cut(start_cut+1).GateNumber*1000) || s > 150000)
            FG(jj,ii)=NaN;
            continue;
        end
        FA2 = cut(start_cut+1).RefData(floor(s/1000),start_AZ2)+(cut(start_cut+1).RefData(ceil(s/1000),start_AZ2)-cut(start_cut+1).RefData(floor(s/1000),start_AZ2))*(mod(s,1000)/1000);        
        FB2 = cut(start_cut+1).RefData(floor(s/1000),end_AZ2)+(cut(start_cut+1).RefData(ceil(s/1000),end_AZ2)-cut(start_cut+1).RefData(floor(s/1000),end_AZ2))*(mod(s,1000)/1000);     
        %% 对第一层方位上进行插值
        theta1_theta2=abs(cut(start_cut).AzimuthAngle(start_AZ1)-cut(start_cut).AzimuthAngle(end_AZ1));
        if(theta1_theta2>180)
            theta1_theta2=360-theta1_theta2;
        end
        theta_theta2=abs(theta-cut(start_cut).AzimuthAngle(end_AZ1));
        if(theta_theta2>180)
            theta_theta2=360-theta_theta2;
        end
        FG1 = FB1+(FA1-FB1)*(theta_theta2/theta1_theta2);
        %% 对第二层方位上进行插值
        theta1_theta2=abs(cut(start_cut+1).AzimuthAngle(start_AZ2)-cut(start_cut+1).AzimuthAngle(end_AZ2));
        if(theta1_theta2>180)
            theta1_theta2=360-theta1_theta2;
        end
        theta_theta2=abs(theta-cut(start_cut+1).AzimuthAngle(end_AZ2));
        if(theta_theta2>180)
            theta_theta2=360-theta_theta2;
        end
        FG2 = FB2+(FA2-FB2)*(theta_theta2/theta1_theta2);
        % 在仰角上(垂直）进行插值
        phi1_phi2=cut(start_cut+1).ElevationAngle-cut(start_cut).ElevationAngle;
        phi_phi2=phi-cut(start_cut).ElevationAngle;
        FG(jj,ii)=((FG2-FG1)/phi1_phi2)*phi_phi2+FG1;
        %FG(jj,ii)=10*log10(FG(jj,ii)); %把Z转成dBZ，与SAread(filename)函数中第101行对应起来
    end %列循环ii
end %行循环jj
%FG=medfilt2(FG,[3,3]); %加了中值滤波器
% h1=fspecial('average',[3,3]);
% FG=imfilter(FG,h1); %加了3*3的均值滤波器
end