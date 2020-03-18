      
function V_cut_CDP=CDPread(filename)
      fid=fopen(filename);                        %文件打开
        %% C波段双偏振多普勒天气雷达基数据格式中对数据类型的定义 %%%%%%%%%%%%%
        %    int     4 bytes integer
        %    short   2 bytes integer
        %    char*N     N bytes characters
        %    float      4 bytes float value
        %    long       8 bytes integer
        fseek(fid,160,'cof');%跳过128字节的无用数据
        %% *Task Configuration (256bytes)* read %%%%%%
        Task_name=fread(fid,32,'char');  %Name of the Task Configuration  %char*32
        Task_description=fread(fid,128,'char');%Description of Task  %char*128
        Polarization=fread(fid,1,'int32'); %Polarization Type   %INT
        Scan_type=fread(fid,1,'int32'); %Volume Scan Type   %INT
        Pulse_width=fread(fid,1,'int32');%Pulse Width    %INT
        Volume_start_time=fread(fid,1,'int32');%Start time of volume scan    %int
        Cut_number=fread(fid,1,'int32');  %cut number   %int
        Hori_noise=fread(fid,1,'single');%Horizontal noise %folat
        Vert_noise=fread(fid,1,'single');%Vertical noise %folat
        Hori_calibration=fread(fid,1,'single');%Horizontal Calibration   %folat
        Vert_calibration=fread(fid,1,'single');%Vertical Calibration     %folat
        Hori_noise_temp=fread(fid,1,'single');% Horizontal Noise Temperature  %folat
        Vert_noise_temp=fread(fid,1,'single'); %Vertical Noise Temperature  %folat
        Zdr_calibration=fread(fid,1,'single'); %Zdr Calibration     %folat
        Phase_calibration=fread(fid,1,'single');%Phase Calibration   %folat
        LDR_calibration=fread(fid,1,'single'); %LDR Calibration     %folat
        fseek(fid,40,'cof');   %reserved 40字节保留
        %% CUT CONFIGURATION(256bytes) read %%%%%%%
        for ii=1:Cut_number
            cut(ii).Process_mode=fread(fid,1,'int32'); %Process Mode 1.PPP 2.FFT     %INT
            cut(ii).Wave_form=fread(fid,1,'int32'); %Wave Form   %INT
            cut(ii).PRF1=fread(fid,1,'int32'); %Pulse Repetition Frequency #1    %INT
            cut(ii).PRF2=fread(fid,1,'int32'); %Pulse Repetition Frequency #2    %INT
            cut(ii).Unfold_mode=fread(fid,1,'int32'); %Dual PRF mode            %INT
            %1 – Single PRF
            %2 – 3:2 mode
            %3 – 4:3 mode
            %4 – 5:4 mode
            cut(ii).Azimuth=fread(fid,1,'single'); %Azimuth degree for RHI scan mode     %float
            cut(ii).Elevation=fread(fid,1,'single');  %Elevation degree for PPI scan mode   %float
            cut(ii).Start_angle=fread(fid,1,'single'); %Start azimuth angle for PPI Sector mode.
            %Start (High) Elevation for RHI mode. %float
            cut(ii).End_angle=fread(fid,1,'single'); %Stop azimuth angle for PPI Sector mode.
            %Stop (Low) Elevation for RHI mode. %float
            cut(ii).Angle_resolution=fread(fid,1,'single'); %Azimuth resolution for PPI scan, Elevation resolution for RHI mode.    %float
            cut(ii).Scan_speed=fread(fid,1,'single'); %Azimuth scan speed for PPI scan, Elevation scan speed for RHI mode.  %float
            cut(ii).Log_resolution=fread(fid,1,'int32'); %Range bin resolution for surveillance data, reflectivity and ZDR, etc.     %INT
            cut(ii).Doppler_resolution=fread(fid,1,'int32'); %Range bin resolution for Doppler data, velocity and spectrum, etc.     %INT
            cut(ii).Max_range=fread(fid,1,'int32');  %Maximum range of scan     %INT
            cut(ii).Max_range2=fread(fid,1,'int32'); %Maximum range of scan      %INT
            cut(ii).Start_range=fread(fid,1,'int32'); %Start range of scan   %INT
            cut(ii).Sample1=fread(fid,1,'int32'); %Pulse sampling number #1.     %INT
            %For wave form Batch and Dual PRF mode, it’s for high PRF,
            %for other modes it’s for only PRF
            cut(ii).Sample2=fread(fid,1,'int32'); %Pulse sampling number #2.     %INT
            %For wave form Batch and Dual PRF mode, it’s for low PRF,
            %for other modes it’s not used.
            cut(ii).Phase_mode=fread(fid,1,'int32'); %Phase modulation mode.     %INT
            % 1 – Fixed Phase
            % 2 – Random Phase
            % 3 – SZ Phase
            cut(ii).Atmos_loss=fread(fid,1,'single'); %two-way atmospheric attenuation factor    %float
            
            cut(ii).Nyquist_speed=fread(fid,1,'single');%Nyquist Speed   %float
            cut(ii).Moments_mask=fread(fid,1,'int64'); %Bit mask indicates which moments are involved in the scan.   %Long
            cut(ii).Moments_size_mask=fread(fid,1,'int64'); %Bit mask indicates range length for moment data in Table 2-7. 0 for 1 byte, 1 for 2 bytes   %long
            cut(ii).SQI_thd=fread(fid,1,'single');%SQI Threshold for the scan     %float
            cut(ii).SIG_thd=fread(fid,1,'single'); %SIG Threshold for the scan   %float
            cut(ii).CSR_thd=fread(fid,1,'single'); %CSR Threshold for the scan   %float
            cut(ii).LOG_thd=fread(fid,1,'single');  %LOG Threshold for the scan     %float
            cut(ii).CPA_thd=fread(fid,1,'single'); %CPA Threshold for the scan   %float
            cut(ii).PMI_thd=fread(fid,1,'single'); %PMI Threshold for the scan   %float
            fseek(fid,8,'cof');   %Thresholds reserved 8字节保留
            cut(ii).dBT_mask=fread(fid,1,'int32'); %Thresholds used for total reflectivity data. Bits mask start from “SQI Threshold”, take is as LSB.   %INT
            cut(ii).dBZ_mask=fread(fid,1,'int32'); %Thresholds used for reflectivity data. Bits mask start from “SQI Threshold”, take is as LSB.     %INT
            cut(ii).Velocity_mask=fread(fid,1,'int32');%Thresholds used for velocity data. Bits mask start from “SQI Threshold”, take is as LSB       %INT
            cut(ii).Spectrum_width_mask=fread(fid,1,'int32');%Thresholds used for reflectivity data. Bits mask start from “SQI Threshold”, take is as LSB.    %INT
            cut(ii).ZDR_mask=fread(fid,1,'int32');%Thresholds used for ZDR data. Bits mask start from “SQI Threshold”, take is as LSB.    %INT
            fseek(fid,12,'cof');   %Mask reserved 12字节保留
            cut(ii).Scan_sync=fread(fid,1,'int32'); %Reserved %INT
            cut(ii).Direction=fread(fid,1,'int32'); %Antenna rotate direction, 1= clockwise, 2=counter clockwise     %INT
            cut(ii).Ground_clutter_type=fread(fid,1,'int16'); %Ground Clutter Classifier Type    %short
            cut(ii).Ground_clutter_filter=fread(fid,1,'int16'); %Ground Clutter Filter Type      %short
            cut(ii).Ground_clutter_filter_notch=fread(fid,1,'int16'); %Ground Clutter Filter Notch Width     %short
            cut(ii).Ground_clutter_filter_window=fread(fid,1,'int16');%Ground Clutter Filter Window    %short
            fseek(fid,72,'cof');  %72bytes spare 72字节多余
            fseek(fid,4,'cof'); %多余位不止72字节，补充4字节
        end
        %% *radial header(64bytes)  read* %%
        ii=1;
        while(1)  %%层循环
            jj=1;
            while(1) %%径向循环
                cut(ii).Radial(jj).Radial_state=fread(fid,1,'int32');%redial state   0= Cut Start  %INT
                % 1=Intermediate Data
                % 2=Cut End
                % 3=Volume Start
                % 4=Volume End
                cut(ii).Radial(jj).Spot_blank=fread(fid,1,'int32');%0=Normal   %INT
                %1=Spot Blank
                cut(ii).Radial(jj).Sequence_number=fread(fid,1,'int32');%sequence number %INT
                cut(ii).Radial(jj).Radial_number=fread(fid,1,'int32');  %Radial Number for each cut    %INT
                cut(ii).Radial(jj).Elevation_number=fread(fid,1,'int32'); %Elevation Number    %INT
                cut(ii).Radial(jj).Azimuth=fread(fid,1,'single'); %Azimuth Angle       %float
                cut(ii).Radial(jj).Elevation=fread(fid,1,'single'); %Elevation Angle   %float
                cut(ii).Radial(jj).Seconds=fread(fid,1,'int32'); %Radial data time in seconds %INT
                cut(ii).Radial(jj).Microseconds=fread(fid,1,'int32'); %Radial data time in microseconds (expect seconds)   %INT
                cut(ii).Radial(jj).Radial_Length=fread(fid,1,'int32'); %Length of data in this radial (this header in excluded)   %INT
                cut(ii).Radial(jj).Moments_number=fread(fid,1,'int32'); %Moments available in this radial  %INT
                fseek(fid,20,'cof'); %Reserved 20 bytes
                %% *moment header(32 bytes) read*  %%
                for kk=1:cut(ii).Radial(jj).Moments_number %%menments 循环
                    cut(ii).Radial(jj).moment(kk).Data_type=fread(fid,1,'int32'); %moment data type   %INT
                    cut(ii).Radial(jj).moment(kk).Scale=fread(fid,1,'int32'); %Data Coding Scale %INT
                    cut(ii).Radial(jj).moment(kk).Offset=fread(fid,1,'int32'); %Data Coding Offset %INT
                    cut(ii).Radial(jj).moment(kk).Bin_length=fread(fid,1,'int16'); %Bytes to save each bin of data %SHORT
                    cut(ii).Radial(jj).moment(kk).Flags=fread(fid,1,'int16'); %Bit of mask flags for data  %SHORT
                    cut(ii).Radial(jj).moment(kk).Moment_Length=fread(fid,1,'int32'); %Length of data of current moment, this header is excluded
                    fseek(fid,12,'cof'); %Reserved 12 bytes
                    % %****moment data read*   %%
                    if(cut(ii).Radial(jj).moment(kk).Data_type==2||cut(ii).Radial(jj).moment(kk).Data_type==7)
                        if(cut(ii).Radial(jj).moment(kk).Bin_length==1)
                            cut(ii).Radial(jj).moment(kk).momentdata=fread(fid,cut(ii).Radial(jj).moment(kk).Moment_Length,'int8'); %read data
                            for mm=1:cut(ii).Radial(jj).moment(kk).Moment_Length
                                if(cut(ii).Radial(jj).moment(kk).momentdata(mm)==0)
                                    cut(ii).Radial(jj).moment(kk).momentdata(mm)=NaN;
                                end
                            end
                        else
                            cut(ii).Radial(jj).moment(kk).momentdata=fread(fid,cut(ii).Radial(jj).moment(kk).Moment_Length/2,'int16'); %read data
                            for mm=1:cut(ii).Radial(jj).moment(kk).Moment_Length/2
                                if(cut(ii).Radial(jj).moment(kk).momentdata(mm)==0)
                                    cut(ii).Radial(jj).moment(kk).momentdata(mm)=NaN;
                                end
                            end
                        end
                        cut(ii).Radial(jj).moment(kk).momentdata=(cut(ii).Radial(jj).moment(kk).momentdata-cut(ii).Radial(jj).moment(kk).Offset)/cut(ii).Radial(jj).moment(kk).Scale; %%数据的换算
                        if(cut(ii).Radial(jj).moment(kk).Data_type==7)
                            cut(ii).Radial(jj).moment(kk).momentdata=medfilt1(cut(ii).Radial(jj).moment(kk).momentdata,20);%中值滤波
                        end
                    else
                        fseek(fid,cut(ii).Radial(jj).moment(kk).Moment_Length,'cof'); %跳过momentdata
                    end
                end
                flag=0;
                if(cut(ii).Radial(jj).Radial_state==4)
                    flag=1; %%体扫结束标志
                    break;
                end
                if(cut(ii).Radial(jj).Radial_state==2)
                    ii=ii+1;
                    break;
                end
                jj=jj+1;
            end  %%径向循环
            if(flag==1)
                break;
            end
        end
        V_cut_CDP=cut;