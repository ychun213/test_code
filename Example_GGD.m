
clc;clear;close all;
%%
x = -6:0.01:6;
rho = [1 1.5 2 4 10];
p = [];
for k = 1:length(rho)
    p = [p exp(-abs(x').^rho(k)) / (2*gamma(1+1/rho(k)))];
end
figure, hold on; set(gca,'fontsize',14);
plot(x,p,'linewidth',2);
str = num2str(rho');
clear str2;
for k = 1:length(rho)
    str2(k,:) = ['\it\rho =' str(k,:)];
end
legend(str2); xlabel('\itx'); ylabel('\itGG(x\rm;\it\rho)'); xlim([-6 6])


%%
x = -10:0.01:10;
mu=[-3 -1 2];
beta= [1 5 2]; sbeta = sqrt(beta);
rho=[1 2 10];
clear p2;
for k = 1:length(mu)
    p2(:,k) = exp(-abs(sbeta(k)*(x-mu(k))').^rho(k)) * sbeta(k) / (2*gamma(1+1/rho(k)));
end
figure, hold on; set(gca,'fontsize',14);
plot(x,p2,'linewidth',2);
rstr = num2str(rho'); mstr = num2str(mu'); bstr = num2str(beta');
clear str2;
for k = 1:length(rho)
    str2(k,:) = ['\it\mu = ' mstr(k,:) ', \it\beta = ' bstr(k,:) ', \it\rho = ' rstr(k,:) ];
end
legend(str2,'Location','NE'); xlabel('\itx'); ylabel('\itGG(x\rm;\it\mu,\it\beta,\it\rho)');
set(gca,'XTick',-10:10);xlim([-8 8]);



x = 1:1:50;
y = normrnd(0,3,50,1);
plot(x,y)




rng(1)
x = normrnd(8,3,1000,1);
[mu, s] = normfit(x);

ggdpdf = @(x, mu, s, p) 1 / ( 2*gamma(1+1/p)*( s^2*gamma(1/p)/gamma(3/p) )^0.5 ) ...
                   * exp(-abs( (x-mu) ./ (( s^2*gamma(1/p)/gamma(3/p) )^0.5) ).^p);