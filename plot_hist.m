%画概率分布曲线图
function [xout,nx]=plot_hist(X)
% ii=find(X>0.1);
% x=X(ii);
x=reshape(X,1,size(X,1)*size(X,2));
t=min(x):1:max(x);
[nx,xout]=hist(x,t);
%figure;plot(xout,nx,'r-')   