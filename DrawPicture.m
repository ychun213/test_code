%%%%%%���������
%       ii:�������
%       X:��ͼ������
%       Y:��ͼ������
%       C:αɫͼ����ɫ
%%%%%%�����һ��ͼƬ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function picture=DrawPicture(X,Y,C)
%set(figure,'color', [0 0 0]); %���ñ���ɫ�������⣩
%%%��ͬ��Բ%%%%
%WhiteColor=[0.6 0.6 0.6];
%rr=150;
%n=5;
%tt=linspace(-pi,pi);
%x=sin(tt)'*linspace(0,rr,n+1);
%y=cos(tt)'*linspace(0,rr,n+1);
%hold on;
%plot(x,y,'color',WhiteColor);
% %��������%%%%%%%
%Yy=[0 0];
%Xx=[-500 500];

%plot(Xx,Yy,'color',WhiteColor);
% 
%Yy=[0 0];
%Xx=[-1000 1000];
% 
%plot(Yy,Xx,'color',WhiteColor);
% 
%K=[tand(30) tand(60) 0 -tand(30) -tand(60) ];
%for ii=1:5
%Xx=[-500 500];
%Yy=K(ii)*Xx;
%plot(Xx,Yy,'color',WhiteColor);
%end
%���ز�ǿ��%%%%%%%%%
mycolor=[0,172,164;192,192,254;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,100;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255; %��ʦ������ɫ��ͼ
colormap(mycolor);
pcolor(X,Y,C);
%lineline(150,0,0)
shading flat;
backColor = [1 1 1];
set(gca, 'color', backColor); %���ñ���ɫ
caxis([-40 40]); %��ɫ��ʾ��Χ
%colorbar('YTickLabel',{'0dBZ','10','20','30','40','50','60','70dBZ'}); %��עɫ��
%%%%%������Ƽ�������Ϣ��ʾ%%%
% axis ([-150 150 -150 150])
% set(gca,'XTickLabel',{'150','100','50','0','50','100','150'});
% set(gca,'YTickLabel',{'150','100','50','0','50','100','150'})
axis square
xlabel('Km','FontName','Times New Roman','FontSize',14)
ylabel('Km','FontName','Times New Roman','FontSize',14)
% text(-20,-100,'100','color',WhiteColor)
% text(-20,-200,'200','color',WhiteColor)
% text(-20,-300,'300','color',WhiteColor)
% text(-20,-400,'400','color',WhiteColor)
% text(-20,100,'100','color',WhiteColor)
% text(-20,200,'200','color',WhiteColor)
% text(-20,300,'300','color',WhiteColor)
% text(-20,400,'400','color',WhiteColor)
% title('�״�ز�ͼ');
% global Year
% global Month
% global Day
% global hour
% global minute
% global seconds
% strdate(1:4)=int2str(Year);
% strdate(5)='-';
% if Month>9
%     strdate(6:7)=int2str(Month);
%     if Day>9
%         strdate(8)='-';
%         strdate(9:10)=num2str(Day);
%     else
%         strdate(8)='-';
%         strdate(9)=num2str(Day);
%     end
% else
%     strdate(6)=int2str(Month);
%         if Day>9
%         strdate(7)='-';
%         strdate(8:9)=num2str(Day);
%     else
%         strdate(7)='-';
%         strdate(8)=num2str(Day);
%         end        
% end
% if hour<10
%     strtime(1)='0';
%     strtime(2)=num2str(hour);
% else
%     strtime(1:2)=num2str(hour);
% end
% strtime(3)=':';
% if minute<10
%     strtime(4)='0';
%     strtime(5)=num2str(minute);
% else
%     strtime(4:5)=num2str(minute);
% end
% strtime(6)=':';
% if seconds<10
%     strtime(7)='0';
%     strtime(8)=num2str(seconds);
% else
%     strtime(7:8)=num2str(seconds);
% end
global VCP
% strVCP(1:2)=num2str(VCP);
% text(300,200,'����������dBZ','FontSize',20,'FontName','����','Color',[0 0 1],'FontWeight','bold');
% text(300,150,'վ��������ɽ','FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,100,['�۲�ģʽ��VCP',strVCP],'FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,050,['�۲�����:',strdate],'FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,000,['�۲�ʱ��:',strtime,'BJT'],'FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,-50,'�ֱ��ʣ�1000m','FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,-100,['�۲ⷶΧ:',num2str(gate),'km'],'FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,-150,['��ʾ��Χ:200km'],'FontSize',16,'FontName','����','Color',[0 0 1]);
% text(300,-200,'��ͼ����Ӧ��','FontSize',10,'FontName','����','Color',[0 0 1]);
end

