

close all, clear all, clc
pro=shaperead('china_province.shp');
bond=shaperead('china.shp');
coast=shaperead('COAST.shp');
southsea=shaperead('southsea.shp');
clc


for i=1:length(pro)
    plot(pro(i).X,pro(i).Y,'k','linewidth',0.75)
    hold on
end


for i=1:length(bond)
    plot(bond(i).X,bond(i).Y,'k','linewidth',1)
    hold on
end
axis([70 140 15 55])
plot(coast.X,coast.Y,'k','linewidth',1)  %九段�?
%xlim([70 140])
%ylim([15 55])


for i=1:length(southsea)
    southsea(i).X=southsea(i).X*0.75+33.2182;
    southsea(i).Y=southsea(i).Y/2+11.6026;
end

plot(southsea(1).X,southsea(1).Y,'k','linewidth',0.75)%land
hold on
plot(southsea(2).X,southsea(2).Y,'k','linewidth',0.75) %southsea
hold on
plot(southsea(3).X,southsea(3).Y,'k','linewidth',1)%box
hold on
set(gca,'xtick',[75 90 105 120 135],'xticklabel',{'75E' '90E' '105E' '120E' '135E'})
set(gca,'ytick',[20 30 40 50],'yticklabel',{'20N' '30N' '40N' '50N'})
%set(gca,'xminortick','on');set(gca,'yminortick','on');
set(gca,'linewidth',1);
clear bond coast i pro southsea;
%saveas(figure(1),'chinamap.pdf')

