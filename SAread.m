function V_cut_SA=SAread(filename)

fid=fopen(filename);                        %�ļ���
        fseek(fid,0,'eof');
        filelength=ftell(fid);
        fseek(fid,0,'bof');
        N=filelength/2432;
        for ii=1:N
            %%%%%��ע���壺  &��ʼ�ֽ�-�����ֽڡ��������͡�����ע�ͣ���������δע��Ĭ��Ϊ���ֽ�)&&&&
            %�״���Ϣͷ��28�ֽڣ�
            Data(ii).Unused1=fread(fid,14,'int8');  %1-14����
            Data(ii).MessageType=fread(fid,1,'uint16');  %15-16��˫�ֽڡ���¼�������ͣ�1���״�����
            Data(ii).Unused2=fread(fid,6,'int16');%[9-14]����
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Data(ii).RadialCollectionTime=fread(fid,1,'uint32');%29-32��4�ֽڡ����������ռ�ʱ�䣬��λ������
            Data(ii).RadialCollectionDate=fread(fid,1,'int16');%33-34��˫�ֽڡ��������ݲɼ�ʱ�䣬�����ձ�ʾ����1970��1��1�տ�ʼ
            Data(ii).UnambiguousRange=fread(fid,1,'uint16');%35-36��˫�ֽڡ���ģ�����룺Xǧ��=��ֵ/10
            Data(ii).AzimuthAngle=fread(fid,1,'uint16');%37-38��˫�ֽڡ���λ�ǣ����뷽ʽ��[��ֵ/8.]*[180./4096.]=��
            Data(ii).DataNumber=fread(fid,1,'uint16');%39-40��˫�ֽڡ���ǰ���Ǿ���������� %�������б�ǰɨ�����
            Data(ii).DataStatus=fread(fid,1,'uint16');%41-42��˫�ֽڡ���������״̬��    %0�������ǵĵ�һ����������
            %1���������м�ľ�������
            %2�������ǵ����һ����������
            %%�������б�ǰɨ�����
            %3����ɨ��ʼ�ĵ�һ����������
            %4����ɨ���������һ����������
            Data(ii).ElevationAngle=fread(fid,1,'int16');%43-44��˫�ֽڡ����ǣ����뷽ʽ��[��ֵ/8.]*[180./4096.]=��
            Data(ii).ElevationNumber=fread(fid,1,'int16');%45-46��˫�ֽڡ���ɨ�ڵ�����������ţ� %�������жϵ�ǰɨ�����
            Data(ii).FirstGateRangeOfRef=fread(fid,1,'int16');%47-48��˫�ֽڡ����������ݵĵ�һ��������ʵ�ʾ���(��λ:��)/ǿ�ȿ����
            Data(ii).FirstGateRangeOfDoppler=fread(fid,1,'int16');%49-50��˫�ֽڡ����������ݵĵ�һ��������ʵ�ʾ���(��λ:��)/�ٶȿ����
            Data(ii).ReflectivityGateSize=fread(fid,1,'int16');%51-52��˫�ֽڡ����������ݵľ���ⳤ����λ���ף�/ǿ�ȿⳤ
            Data(ii).DopplerGateSize=fread(fid,1,'int16');%53-54��˫�ֽڡ����������ݵľ���ⳤ����λ���ף�/�ٶ�/�׿�ⳤ(��)
            Data(ii).ReflectivityGates=fread(fid,1,'int16');%55-56��˫�ֽڡ������ʵľ������/ǿ�ȿ���
            Data(ii).DopplerGates=fread(fid,1,'int16');%57-58��˫�ֽڡ������յľ������/�ٶ�/�׿����
            Data(ii).Shanquhao=fread(fid,1,'int16');%59-60��˫�ֽڡ�������
            Data(ii).Xitongdingzhengchangshu=fread(fid,1,'int32');%61-64��4�ֽڡ�ϵͳ��������
            Data(ii).RefPointer=fread(fid,1,'uint16');%65-66��˫�ֽڡ�����������ָ�루ƫ���״�������Ϣͷ���ֽ�����:��ʾ��һ�����������ݵ�λ��
            Data(ii).VelPointer=fread(fid,1,'uint16');%67-68��˫�ֽڡ��ٶ�����ָ�루ƫ���״�������Ϣͷ���ֽ�����:��ʾ��һ���ٶ����ݵ�λ��
            Data(ii).SWPointer=fread(fid,1,'uint16');%69-70��˫�ֽڡ��׿�����ָ�루ƫ���״�������Ϣͷ���ֽ�����:��ʾ��һ���׿����ݵ�λ��
            Data(ii).VelResolution=fread(fid,1,'int16');%71-72��˫�ֽڡ��������ٶȷֱ��ʡ�2����ʾ0.5��/��
            %                                                    4����ʾ1.0��/��
            Data(ii).VCP=fread(fid,1,'uint16');%73-74��˫�ֽڡ���ɨ��VCP��ģʽ               11����ˮģʽ��16������
            %                                                                                21����ˮģʽ��14������
            %                                                                                31�����ģʽ��8������
            %                                                                                32�����ģʽ��7������
            Data(ii).Unused3=fread(fid,4,'int16');%75-82���ޡ�����
            Data(ii).PlayRefPointer=fread(fid,1,'uint16');%83-84��˫�ֽڡ����ڻطŵķ���������ָ��
            Data(ii).PlayVelPointer=fread(fid,1,'uint16');%85-86��˫�ֽڡ����ڻطŵ��ٶ�����ָ��
            Data(ii).PlaySWPointer=fread(fid,1,'uint16');%87-88��˫�ֽڡ����ڻطŵ��׿�����ָ��
            Data(ii).NyquistVelocity=fread(fid,1,'int16');%89-90��˫�ֽڡ�Nyquist�ٶȣ���ʾ����ֵ/100. = ��/�룩
            Data(ii).Unused4=fread(fid,19,'int16');%91-128���ޡ�����
            Data(ii).RefData=fread(fid,460,'uint8');%129-588������������
            %                             ���������0-460
            %                             ���뷽ʽ������ֵ-2��/2.-32 = DBZ
            %                             ����ֵΪ0ʱ����ʾ�޻ز����ݣ���������ȷ�ֵ��
            %                             ����ֵΪ1ʱ����ʾ����ģ��
            Data(ii).VelData=fread(fid,920,'uint8');%589-1508�����ֽڡ��ٶ�
            %                             ���������0-920
            %                             ���뷽ʽ��
            %                             �ֱ���Ϊ0.5��/��ʱ
            %                            ����ֵ-2��/2.-63.5 = ��/��
            %                             �ֱ���Ϊ1.0��/��ʱ
            %                            ����ֵ-2��-127 = ��/��
            %                             ����ֵΪ0ʱ����ʾ�޻ز����ݣ���������ȷ�ֵ��
            %                             ����ֵΪ1ʱ����ʾ����ģ��
            Data(ii).SwData=fread(fid,920,'uint8');%1509-2428�����ֽڡ��׿�
            %                             ���������0-920
            %                             ���뷽ʽ��
            %                            ����ֵ-2��/2.-63.5 = ��/��
            %                             ����ֵΪ0ʱ����ʾ�޻ز����ݣ���������ȷ�ֵ��
            %                             ����ֵΪ1ʱ����ʾ����ģ��
            Data(ii).Unused5=fread(fid,2,'int16');%2429-2432���ޡ�����
        end %ii �����ݶ�ȡ
        %%�����ݴ���
        for ii=1:N
            Data(ii).TransAzimuthAngle=(Data(ii).AzimuthAngle/8)*180/4096;         %��λ��ת��
            Data(ii).TransElevationAngle=(Data(ii).ElevationAngle/8)*180/4096;          %����ת��
            %Data(ii).TransRel=(Data(ii).RefData-2)/2-32;                                %������dBz����
            ElevationNumber(ii)=Data(ii).ElevationNumber;                               %��ȡ���Ǳ����Ϣ
        end
        Cutnumer=max(ElevationNumber);      %�������Ǹ���/ɨ�����(�����Ǳ�����ֵ)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        jj=1;
        for nn=1:Cutnumer
            DataNumber=1;
            cut(nn).ElevationAngle=0;
            cut(nn).GateNumber=Data(jj).ReflectivityGates;%����������
            cut(nn).RadialNumber=DataNumber-1; %�������Ǿ������ݸ���
            while DataNumber==Data(jj).DataNumber
                cut(nn).AzimuthAngle(DataNumber)=Data(jj).TransAzimuthAngle;    %���㷽λ��
                cut(nn).Theta(DataNumber)=90-cut(nn).AzimuthAngle(DataNumber);%������ͼ��theta��
                cut(nn).ElevationAngle= cut(nn).ElevationAngle+Data(jj).TransElevationAngle; %��������
                for kk=1:460
                    if(Data(jj).RefData(kk)==0)
                        Data(jj).CorrectRel(kk)=NaN;
                    else
                        Data(jj).CorrectRel(kk)=(Data(jj).RefData(kk)-2)/2-32;  %�������ݴ���ȥ���޻ز��źźͽ��з�������ֵת��
                    end
                end
                cut(nn).RefData(:,DataNumber)=Data(jj).CorrectRel(1:cut(nn).GateNumber);%TransRel; %�����������ݿ���*���������������dBz
                DataNumber=DataNumber+1;
                if jj==N
                    break;      %���������һ������ʱ���˳�ѭ��
                end
                jj=jj+1;
            end
            %%%%%%%%%%����Ϊ�����������о���%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                error('��Ԥ��������Ϣƥ��');
            end
            %%%%%%%%%%%%%������������%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end %nn
        cut(2)=[];
        cut(3)=[];%ɾ���������ݣ���Ϊ������û�з���������
V_cut_SA=cut;