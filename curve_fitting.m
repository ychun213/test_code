clc;clear all;close all;
%generate the orignal data
mu = 3;
b = 2;
A = 4;
x=-10:.1:10;
y=A/2/b*exp(-abs(x-mu)/b)+0.05*randn(1,length(x));
subplot 211
scatter(x,y,'.');grid on;
  
%%curve fitting
%2-Laplace distribution
f = fittype('a*exp(-(abs(x-b)/c))');
[cfun,gof] = fit(x(:),y(:),f);
yo = cfun.a*exp(-(abs(x-cfun.b)/cfun.c));
%plot
subplot 212
scatter(x,y,'k');hold on;
grid on;
plot(x,yo,'g--','linewidth',2);