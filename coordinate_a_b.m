%经纬度距离转成直接距离
      
function [XX,YY]=coordinate_a_b(siteLong, siteLat, obsLong, obsLat)

      r=6.3712e3;    %earth radius (km)     

      thetaA=pi/2.-siteLat*pi/180;
      phiA=siteLong*pi/180;
      
      thetaAp1=pi/2.-(siteLat+1.)*pi/180;   % 1 deg. increment of latitude
      phiAp1=(siteLong+1.)*pi/180;          % 1 deg. increment of longitude
      
      xA = r*sin(thetaA)*cos(phiA);   % Point A coordinate
      yA = r*sin(thetaA)*sin(phiA);
      zA = r*cos(thetaA);
      
%The unit vector of A along the east is expressed in terms of earth coord.
      dLong=distance_a_b(siteLong, siteLat, siteLong+1, siteLat);
      xU = r*sin(thetaA)*cos(phiAp1);
      yU = r*sin(thetaA)*sin(phiAp1);
      zU = r*cos(thetaA);
       
      XuvLong = (xU-xA)/dLong;
      YuvLong = (yU-yA)/dLong;
      ZuvLong = (zU-zA)/dLong;
      
    %The unit vector of A along the north is expressed in terms of earth coordinates.
      dLat=distance_a_b(siteLong, siteLat, siteLong, siteLat+1);
      xU = r*sin(thetaAp1)*cos(phiA);
      yU = r*sin(thetaAp1)*sin(phiA);
      zU = r*cos(thetaAp1);
      
      XuvLat = (xU-xA)/dLat;
      YuvLat = (yU-yA)/dLat;
      ZuvLat = (zU-zA)/dLat;

% Vector AB

      thetaB=pi/2.-obsLat*pi/180;
      phiB=obsLong*pi/180;
      
      xB = r*sin(thetaB)*cos(phiB);   %Point B coordinate
      yB = r*sin(thetaB)*sin(phiB);
      zB = r*cos(thetaB);
      
      xAB = xB-xA;
      yAB = yB-yA;
      zAB = zB-zA;
      
%Project vector AB onto unit vector of A along the east and north

      XX = xAB*XuvLong+yAB*YuvLong+zAB*ZuvLong;
      YY = xAB*XuvLat+yAB*YuvLat+zAB*ZuvLat;
end