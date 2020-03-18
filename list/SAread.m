function V_cut_SA=SAread(filename)

fid=fopen(filename);                        %文件打开
        fseek(fid,0,'eof');
        filelength=ftell(fid);
        fseek(fid,0,'bof');
        N=filelength/2432;
        for ii=1:N
            %%%%%备注释义：  &开始字节-结束字节【数据类型】文字注释（数据类型未注明默认为单字节)&&&&
            %雷达信息头（28字节）
            Data(ii).Unused1=fread(fid,14,'int8');  %1-14保留
            Data(ii).MessageType=fread(fid,1,'uint16');  %15-16【双字节】记录数据类型，1：雷达数据
            Data(ii).Unused2=fread(fid,6,'int16');%[9-14]保留
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Data(ii).RadialCollectionTime=fread(fid,1,'uint32');%29-32【4字节】径向数据收集时间，单位：毫秒
            Data(ii).RadialCollectionDate=fread(fid,1,'int16');%33-34【双字节】径向数据采集时间，儒略日表示：自1970年1月1日开始
            Data(ii).UnambiguousRange=fread(fid,1,'uint16');%35-36【双字节】不模糊距离：X千米=数值/10
            Data(ii).AzimuthAngle=fread(fid,1,'uint16');%37-38【双字节】方位角，编码方式：[数值/8.]*[180./4096.]=度
            Data(ii).DataNumber=fread(fid,1,'uint16');%39-40【双字节】当前仰角径向数据序号 %可用来判别当前扫描层数
            Data(ii).DataStatus=fread(fid,1,'uint16');%41-42【双字节】径向数据状态：    %0：该仰角的第一条径向数据
            %1：该仰角中间的径向数据
            %2：该仰角的最后一条径向数据
            %%可用来判别当前扫描层序
            %3：体扫开始的第一条径向数据
            %4：体扫结束的最后一条径向数据
            Data(ii).ElevationAngle=fread(fid,1,'int16');%43-44【双字节】仰角，编码方式：[数值/8.]*[180./4096.]=度
            Data(ii).ElevationNumber=fread(fid,1,'int16');%45-46【双字节】体扫内的仰角数（编号） %可用来判断当前扫描层数
            Data(ii).FirstGateRangeOfRef=fread(fid,1,'int16');%47-48【双字节】反射率数据的第一个距离库的实际距离(单位:米)/强度库距离
            Data(ii).FirstGateRangeOfDoppler=fread(fid,1,'int16');%49-50【双字节】多普勒数据的第一个距离库的实际距离(单位:米)/速度库距离
            Data(ii).ReflectivityGateSize=fread(fid,1,'int16');%51-52【双字节】反射率数据的距离库长（单位：米）/强度库长
            Data(ii).DopplerGateSize=fread(fid,1,'int16');%53-54【双字节】多普勒数据的距离库长（单位：米）/速度/谱宽库长(米)
            Data(ii).ReflectivityGates=fread(fid,1,'int16');%55-56【双字节】反射率的距离库数/强度库数
            Data(ii).DopplerGates=fread(fid,1,'int16');%57-58【双字节】多普勒的距离库数/速度/谱宽库数
            Data(ii).Shanquhao=fread(fid,1,'int16');%59-60【双字节】扇区号
            Data(ii).Xitongdingzhengchangshu=fread(fid,1,'int32');%61-64【4字节】系统订正常数
            Data(ii).RefPointer=fread(fid,1,'uint16');%65-66【双字节】反射率数据指针（偏离雷达数据信息头的字节数）:表示第一个反射率数据的位置
            Data(ii).VelPointer=fread(fid,1,'uint16');%67-68【双字节】速度数据指针（偏离雷达数据信息头的字节数）:表示第一个速度数据的位置
            Data(ii).SWPointer=fread(fid,1,'uint16');%69-70【双字节】谱宽数据指针（偏离雷达数据信息头的字节数）:表示第一个谱宽数据的位置
            Data(ii).VelResolution=fread(fid,1,'int16');%71-72【双字节】多普勒速度分辨率。2：表示0.5米/秒
            %                                                    4：表示1.0米/秒
            Data(ii).VCP=fread(fid,1,'uint16');%73-74【双字节】体扫（VCP）模式               11：降水模式，16层仰角
            %                                                                                21：降水模式，14层仰角
            %                                                                                31：晴空模式，8层仰角
            %                                                                                32：晴空模式，7层仰角
            Data(ii).Unused3=fread(fid,4,'int16');%75-82【无】保留
            Data(ii).PlayRefPointer=fread(fid,1,'uint16');%83-84【双字节】用于回放的反射率数据指针
            Data(ii).PlayVelPointer=fread(fid,1,'uint16');%85-86【双字节】用于回放的速度数据指针
            Data(ii).PlaySWPointer=fread(fid,1,'uint16');%87-88【双字节】用于回放的谱宽数据指针
            Data(ii).NyquistVelocity=fread(fid,1,'int16');%89-90【双字节】Nyquist速度（表示：数值/100. = 米/秒）
            Data(ii).Unused4=fread(fid,19,'int16');%91-128【无】保留
            Data(ii).RefData=fread(fid,460,'uint8');%129-588【单】反射率
            %                             距离库数：0-460
            %                             编码方式：（数值-2）/2.-32 = DBZ
            %                             当数值为0时，表示无回波数据（低于信噪比阀值）
            %                             当数值为1时，表示距离模糊
            Data(ii).VelData=fread(fid,920,'uint8');%589-1508【单字节】速度
            %                             距离库数：0-920
            %                             编码方式：
            %                             分辨率为0.5米/秒时
            %                            （数值-2）/2.-63.5 = 米/秒
            %                             分辨率为1.0米/秒时
            %                            （数值-2）-127 = 米/秒
            %                             当数值为0时，表示无回波数据（低于信噪比阀值）
            %                             当数值为1时，表示距离模糊
            Data(ii).SwData=fread(fid,920,'uint8');%1509-2428【单字节】谱宽
            %                             距离库数：0-920
            %                             编码方式：
            %                            （数值-2）/2.-63.5 = 米/秒
            %                             当数值为0时，表示无回波数据（低于信噪比阀值）
            %                             当数值为1时，表示距离模糊
            Data(ii).Unused5=fread(fid,2,'int16');%2429-2432【无】保留
        end %ii 基数据读取
        %%基数据处理
        for ii=1:N
            Data(ii).TransAzimuthAngle=(Data(ii).AzimuthAngle/8)*180/4096;         %方位角转换
            Data(ii).TransElevationAngle=(Data(ii).ElevationAngle/8)*180/4096;          %仰角转换
            %Data(ii).TransRel=(Data(ii).RefData-2)/2-32;                                %反射率dBz换算
            ElevationNumber(ii)=Data(ii).ElevationNumber;                               %提取仰角编号信息
        end
        Cutnumer=max(ElevationNumber);      %计算仰角个数/扫描层数(即仰角编号最大值)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        jj=1;
        for nn=1:Cutnumer
            DataNumber=1;
            cut(nn).ElevationAngle=0;
            cut(nn).GateNumber=Data(jj).ReflectivityGates;%当层距离库数
            cut(nn).RadialNumber=DataNumber-1; %当层仰角经向数据个数
            while DataNumber==Data(jj).DataNumber
                cut(nn).AzimuthAngle(DataNumber)=Data(jj).TransAzimuthAngle;    %当层方位角
                cut(nn).Theta(DataNumber)=90-cut(nn).AzimuthAngle(DataNumber);%用来作图的theta角
                cut(nn).ElevationAngle= cut(nn).ElevationAngle+Data(jj).TransElevationAngle; %当层仰角
                for kk=1:460
                    if(Data(jj).RefData(kk)==0)
                        Data(jj).CorrectRel(kk)=NaN;
                    else
                        Data(jj).CorrectRel(kk)=(Data(jj).RefData(kk)-2)/2-32;  %反射数据处理：去除无回波信号和进行反射率数值转换
                    end
                end
                cut(nn).RefData(:,DataNumber)=Data(jj).CorrectRel(1:cut(nn).GateNumber);%TransRel; %【反射率数据库数*径向个数】反射率dBz
                DataNumber=DataNumber+1;
                if jj==N
                    break;      %当处理到最后一个数据时，退出循环
                end
                jj=jj+1;
            end
            %%%%%%%%%%以下为对仰角误差进行纠正%%%%%%%%%%%%%%%%%%%%%%%%%%%
            cut(nn).ElevationAngle=cut(nn).ElevationAngle/(DataNumber-1);
            if cut(nn).ElevationAngle>0&&cut(nn).ElevationAngle<1.0
                cut(nn).ElevationAngle=0.5;
                
            elseif cut(nn).ElevationAngle>1.0&&cut(nn).ElevationAngle<1.9
                cut(nn).ElevationAngle=1.5;
                
            elseif cut(nn).ElevationAngle>1.9&&cut(nn).ElevationAngle<2.9
                cut(nn).ElevationAngle=2.4;
                
            elseif cut(nn).ElevationAngle>2.9&&cut(nn).ElevationAngle<3.9
                cut(nn).ElevationAngle=3.4;
            elseif cut(nn).ElevationAngle>3.8&&cut(nn).ElevationAngle<4.8
                cut(nn).ElevationAngle=4.3;
                
            elseif cut(nn).ElevationAngle>4.8&&cut(nn).ElevationAngle<5.8
                cut(nn).ElevationAngle=5.3;
                
            elseif cut(nn).ElevationAngle>5.8&&cut(nn).ElevationAngle<6.7
                cut(nn).ElevationAngle=6.2;
                
            elseif cut(nn).ElevationAngle>7.0&&cut(nn).ElevationAngle<8.0
                cut(nn).ElevationAngle=7.5;
                
            elseif cut(nn).ElevationAngle>8.2&&cut(nn).ElevationAngle<9.2
                cut(nn).ElevationAngle=8.7;
                
            elseif cut(nn).ElevationAngle>9.5&&cut(nn).ElevationAngle<10.5
                cut(nn).ElevationAngle=10;
                
            elseif cut(nn).ElevationAngle>11.5&&cut(nn).ElevationAngle<12.5
                cut(nn).ElevationAngle=12;
                
            elseif cut(nn).ElevationAngle>13.5&&cut(nn).ElevationAngle<15
                cut(nn).ElevationAngle=14;
                
            elseif cut(nn).ElevationAngle>15.7&&cut(nn).ElevationAngle<17.2
                cut(nn).ElevationAngle=16.7;
                
            elseif cut(nn).ElevationAngle>19.0&&cut(nn).ElevationAngle<20.0
                cut(nn).ElevationAngle=19.5;
                
            else
                error('无预置仰角信息匹配');
            end
            %%%%%%%%%%%%%仰角误差纠正完%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end %nn
        cut(2)=[];
        cut(3)=[];%删除两层数据，因为这两层没有反射率数据
V_cut_SA=cut;