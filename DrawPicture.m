%%%%%%输入参数：
%       ii:距离库数
%       X:画图横坐标
%       Y:画图纵坐标
%       C:伪色图的颜色
%%%%%%输出：一副图片
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function picture=DrawPicture(X,Y,C)
%set(figure,'color', [0 0 0]); %设置背景色（坐标外）
%%%画同心圆%%%%
%WhiteColor=[0.6 0.6 0.6];
%rr=150;
%n=5;
%tt=linspace(-pi,pi);
%x=sin(tt)'*linspace(0,rr,n+1);
%y=cos(tt)'*linspace(0,rr,n+1);
%hold on;
%plot(x,y,'color',WhiteColor);
% %画放射线%%%%%%%
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
%画回波强度%%%%%%%%%
mycolor=[0,172,164;192,192,254;122,114,238;30,38,208;166,252,168;0,234,0;16,146,26;252,244,100;...
    200,200,2;140,140,0;254,172,172;254,100,92;238,2,48;212,142,254;170, 36,250]/255; %老师给的颜色地图
colormap(mycolor);
pcolor(X,Y,C);
%lineline(150,0,0)
shading flat;
backColor = [1 1 1];
set(gca, 'color', backColor); %设置背景色
caxis([-40 40]); %颜色显示范围
%colorbar('YTickLabel',{'0dBZ','10','20','30','40','50','60','70dBZ'}); %加注色标
%%%%%坐标控制及附加信息显示%%%
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
% title('雷达回波图');
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
% text(300,200,'基本反射率dBZ','FontSize',20,'FontName','隶书','Color',[0 0 1],'FontWeight','bold');
% text(300,150,'站名：龙王山','FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,100,['观测模式：VCP',strVCP],'FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,050,['观测日期:',strdate],'FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,000,['观测时间:',strtime,'BJT'],'FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,-50,'分辨率：1000m','FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,-100,['观测范围:',num2str(gate),'km'],'FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,-150,['显示范围:200km'],'FontSize',16,'FontName','宋体','Color',[0 0 1]);
% text(300,-200,'绘图：李应超','FontSize',10,'FontName','楷书','Color',[0 0 1]);
end

