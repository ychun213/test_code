function[]=lineline(rmax,a,b)
%% ***********���״�ͼ��Ӹ����ߣ�����Ȧ�ͷ�λ�ߣ�*********%%
%%      rmax:�뾶
%%      a:Բ�ĺ�����
%%      b:Բ��������
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
n=5;%ͬ��Բ����
t=linspace(-pi,pi); 
x=sin(t)'*linspace(0,rmax,n+1)+a;
y=cos(t)'*linspace(0,rmax,n+1)+b;
hold on
plot(x,y,'color',WhiteColor)
hold off
end