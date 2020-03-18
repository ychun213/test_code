function[]=lineline(rmax,a,b)
%% ***********给雷达图添加辅助线（距离圈和方位线）*********%%
%%      rmax:半径
%%      a:圆心横坐标
%%      b:圆形纵坐标
WhiteColor=[0.6 0.6 0.6];
th=(1:6)*2*pi/12;
cst=cos(th);snt=sin(th);
cs=[-cst;cst];
cs=cs+a/rmax;
sn=[-snt;snt];
sn=sn+b/rmax;
hold on
line(rmax*cs,rmax*sn,'color',WhiteColor);
axis square;
n=5;%同心圆个数
t=linspace(-pi,pi); 
x=sin(t)'*linspace(0,rmax,n+1)+a;
y=cos(t)'*linspace(0,rmax,n+1)+b;
hold on
plot(x,y,'color',WhiteColor)
hold off
end