
%%%%%画95%的置信区间
%%%%%参考https://www.mathworks.com/help/curvefit/confidence-and-prediction-bounds.html

clc;clear;close all;

x = (0:0.2:5)';
y = 2*exp(-0.2*x) + 0.5*randn(size(x));

figure;
plot(x,y);

fitresult = fit(x,y,'exp1');

%%%Compute 95% observation and functional prediction intervals, both simultaneous and nonsimultaneous.
p11 = predint(fitresult,x,0.95,'observation','off');
p12 = predint(fitresult,x,0.95,'observation','on');
p21 = predint(fitresult,x,0.95,'functional','off');
p22 = predint(fitresult,x,0.95,'functional','on');

%%%Plot the data, fit, and prediction intervals. Note that the observation bounds are wider than the functional bounds.
figure;
subplot(2,2,1)
plot(fitresult,x,y), hold on, plot(x,p11,'m--'), xlim([0 5]), ylim([-1 5])
title('Nonsimultaneous Observation Bounds','FontSize',9)
legend off
   
subplot(2,2,2)
plot(fitresult,x,y), hold on, plot(x,p12,'m--'), xlim([0 5]), ylim([-1 5])
title('Simultaneous Observation Bounds','FontSize',9)
legend off

subplot(2,2,3)
plot(fitresult,x,y), hold on, plot(x,p21,'m--'), xlim([0 5]), ylim([-1 5])
title('Nonsimultaneous Functional Bounds','FontSize',9)
legend off

subplot(2,2,4)
plot(fitresult,x,y), hold on, plot(x,p22,'m--'), xlim([0 5]), ylim([-1 5])
title('Simultaneous Functional Bounds','FontSize',9)
legend({'Data','Fitted curve', 'Prediction intervals'},...
       'FontSize',8,'Location','northeast')
   
  