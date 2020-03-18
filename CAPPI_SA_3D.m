
function SA_3D_grid=CAPPI_SA_3D(resolution,dz,cut)
% clc;clear all;close all
% resolution=1000;
% dz=1000;
% Filename_SA='E:\DPR_compare\Z_RADR_I_Z9250_20080527045900_O_DOR_SA_CAP.bin';
% cut=SAread(Filename_SA);
%% �õ�resolution��resolution������ɨ��뾶�̶�Ϊ150km
x2=0:resolution:150000;
x1=-150000:resolution:-resolution;
x=[x1,x2];
clear x1 x2
y=x;
height=1000:dz:20000;
% x=x+1785; %���ƽ�ƣ�ʹ���CDP�ĸ��һһ��Ӧ
% y=y+1914;
%% ��ѿ���������ÿһ�㣨X��Y��Z����Ӧ���״������꣨Phi,Theta)
SA_3D_grid=zeros(length(x),length(y),length(height));
for k=1:length(height)
    k
    z=1000+(k-1)*dz;
for jj=1:length(y) %jj����y(�У��ĸ���
for ii=1:length(x)%ii����x���У��ĸ���
        phi=atand(z/sqrt(x(ii)^2+y(jj)^2));%Ŀ��������
        if(x(ii)>0)
            theta=90-atand(y(jj)/x(ii)); %Ŀ���ķ�λ��
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
            SA_3D_grid(jj,ii,k)=NaN;
            continue;
        else
            error('x,y,z�����������\n')
        end
        
        %% ����phi�����ڲ��
        start_cut=0;
        EL=[cut.ElevationAngle];
        for kk=1:8 %�״���ɨ��������9��
            if(phi>=EL(kk) && phi<=EL(kk+1))
                start_cut=kk;
                break
            end
        end
        if(start_cut==0)
            SA_3D_grid(jj,ii,k)=NaN;
            continue;
        end
        %% ���һ���ϵ����ڷ�λ��
        AZ=abs([cut(start_cut).AzimuthAngle]-theta);
        [~,start_AZ1]=min(AZ);
        AZ(start_AZ1)=max(AZ);
        [~,end_AZ1]=min(AZ);
        %% ��ڶ�����ϵ����ڷ�λ��
        AZ=abs([cut(start_cut+1).AzimuthAngle]-theta);
        [~,start_AZ2]=min(AZ);
        AZ(start_AZ2)=max(AZ);
        [~,end_AZ2]=min(AZ);
        
        %% �ڵ�һ�㾶���ϲ�ֵ
        s = sqrt(x(ii)^2+y(jj)^2)/cosd(cut(start_cut).ElevationAngle); %��ֵ�㾶�������״����ĵľ���
%         if(s>(cut(start_cut).GateNumber*1000) || s > 150000) %��һ��ifѭ����ѡȡ���ݶ��ھ���Ȧ150km����
        if(s>(cut(start_cut).GateNumber*1000) )
                 SA_3D_grid(jj,ii,k)=NaN;
            continue;
        end
        FA1 = cut(start_cut).RefData(floor(s/1000),start_AZ1)+(cut(start_cut).RefData(ceil(s/1000),start_AZ1)-cut(start_cut).RefData(floor(s/1000),start_AZ1))*(mod(s,1000)/1000);       
        FB1 = cut(start_cut).RefData(floor(s/1000),end_AZ1)+(cut(start_cut).RefData(ceil(s/1000),end_AZ1)-cut(start_cut).RefData(floor(s/1000),end_AZ1))*(mod(s,1000)/1000);  
        %% �ڵڶ��㾶���ϲ�ֵ
        s = sqrt(x(ii)^2+y(jj)^2)/cosd(cut(start_cut+1).ElevationAngle); %��ֵ�㾶�������״����ĵľ���
%         if(s>(cut(start_cut+1).GateNumber*1000) || s > 150000) %��һ��ifѭ����ѡȡ���ݶ��ھ���Ȧ150km����
        if(s > (cut(start_cut+1).GateNumber*1000) )
            SA_3D_grid(jj,ii,k)=NaN;
            continue;
        end
        FA2 = cut(start_cut+1).RefData(floor(s/1000),start_AZ2)+(cut(start_cut+1).RefData(ceil(s/1000),start_AZ2)-cut(start_cut+1).RefData(floor(s/1000),start_AZ2))*(mod(s,1000)/1000);        
        FB2 = cut(start_cut+1).RefData(floor(s/1000),end_AZ2)+(cut(start_cut+1).RefData(ceil(s/1000),end_AZ2)-cut(start_cut+1).RefData(floor(s/1000),end_AZ2))*(mod(s,1000)/1000);     
        %% �Ե�һ�㷽λ�Ͻ��в�ֵ
        theta1_theta2=abs(cut(start_cut).AzimuthAngle(start_AZ1)-cut(start_cut).AzimuthAngle(end_AZ1));
        if(theta1_theta2>180)
            theta1_theta2=360-theta1_theta2;
        end
        theta_theta2=abs(theta-cut(start_cut).AzimuthAngle(end_AZ1));
        if(theta_theta2>180)
            theta_theta2=360-theta_theta2;
        end
        FG1 = FB1+(FA1-FB1)*(theta_theta2/theta1_theta2);
        %% �Եڶ��㷽λ�Ͻ��в�ֵ
        theta1_theta2=abs(cut(start_cut+1).AzimuthAngle(start_AZ2)-cut(start_cut+1).AzimuthAngle(end_AZ2));
        if(theta1_theta2>180)
            theta1_theta2=360-theta1_theta2;
        end
        theta_theta2=abs(theta-cut(start_cut+1).AzimuthAngle(end_AZ2));
        if(theta_theta2>180)
            theta_theta2=360-theta_theta2;
        end
        FG2 = FB2+(FA2-FB2)*(theta_theta2/theta1_theta2);
        % ��������(��ֱ�����в�ֵ
        phi1_phi2=cut(start_cut+1).ElevationAngle-cut(start_cut).ElevationAngle;
        phi_phi2=phi-cut(start_cut).ElevationAngle;
        SA_3D_grid(jj,ii,k)=((FG2-FG1)/phi1_phi2)*phi_phi2+FG1;
end %��ѭ��ii
end %��ѭ��jj
SA_3D_grid(:,:,k)=medfilt2(SA_3D_grid(:,:,k),[3,3]); %������ֵ�˲���
end
end