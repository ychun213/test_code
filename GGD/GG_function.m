clc;clear;close all;

x = (-20:0.01:20); 
a = 0.28;
b = -0.11;

y = (a./(2 .* b .* gamma(1./a))) .* exp((abs(x ./ b)) .^ a);
%y = (a./(2.*sqrt(b.*(gamma(1./a)./gamma(3./a))).*gamma(1./a))).*exp(-(abs(x)./(sqrt(b.*(gamma(1./a)./gamma(3./a))))).^a);
plot(x,y);

clc;clear;close all;
xdata = [-15,-13,-10,-9,-7,-5,-3,0,2,4.5,6.5,8,10,12.5,15];
ydata = [-16,-14,-12,-10,-8,-6,-3.7,-1.8,-3.7,-6,-8,-10,-12,-14,-16];
myfunc=inline('(beta(1)./(2 .* beta(2) .* gamma(1./beta(1)))) .* exp((abs(x ./ beta(2))) .^ beta(1))','beta','x');
beta=nlinfit(xdata,ydata,myfunc,[0.5 -1]);
a = beta(1);
b = beta(2);
xx = (min(xdata):0.1:max(xdata));
yy = (a./(2 .* b .* gamma(1./a))) .* exp((abs(xx ./ b)) .^ a);
plot(xdata,ydata,'r.');
hold on
plot(xx,yy);