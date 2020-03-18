  %计算以经纬度为坐标的两点的距离 
function dab=distance_a_b(along, alat, blong, blat)

r=6.3712e3;    %earth radius (km)   
      theta1=pi/2.-alat*pi/180.;
      phi1=along*pi/180.;
      theta2=pi/2.-blat*pi/180.;
      phi2=blong*pi/180.;
      cc1=sin(theta2)*cos(phi2)-sin(theta1)*cos(phi1);
      cc2=sin(theta2)*sin(phi2)-sin(theta1)*sin(phi1);
      cc3=cos(theta2)-cos(theta1);
      dab=r*sqrt(cc1^2+cc2^2+cc3^2);   %(km)
end