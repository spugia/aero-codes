%.. real turbojet performance with bypass and afterburner
%.. english units only

function [Fps, SFC, f, Tts, Pts] = ideal_turbojet(u0, Hc, Cp, k, Beta, CPR, T04, T07, etas)

  %.. constants
  btuconv = 778.169;
  g       = 32.17405;

  %.. efficiencies
  nc  = etas(1);
  nb  = etas(2);
  nt  = etas(3);
  nab = etas(4);
  nn  = etas(5);

  %.. inlet
  P02 = P00 * ideal_inlet(M);
  T02 = T00;

  %.. compressor
  T03 = T02*(1+1/nc*(CPR^((k-1)/k)-1))^(k/(k-1));
  P03 = CPR * P02;

  %.. burber
  fb = (Cp*(T04-T03)) / (nb*Hc);

  P04 = P03;

  %.. turbine
  T05 = T04 - (1+fb)*(T03-T02) / nt;
  P05 = P04*(T05/T04)^((k-1)/k);

  %.. constant pressure mixer
  T06 = ((1+fb)*T05 + Beta*T02) / (1+fb+Beta);
  P06 = ((1+fb)*P05 + Beta*P02) / (1+fb+Beta);

  %.. afterburner
  fab = (Cp*(1+Beta+fb)*(T07-T06)) / (nab*Hc);

  P07 = P06;

  %.. nozzle
  T09 = T07;
  P09 = P07;

  v9 = sqrt(2*Cp*btuconv*g*nn*T05*(1-(P9/P07)^((k-1)/k)))

  %.. performance parameters
  Fsp = ((1+Beta+fb+fab)*v9 - (1+Beta)*v0) / (g*(1+Beta)); 
  SFC = (g*(fb+fab)) / ((1+Beta+fb+fab)*v9 - (1+Beta)*u0);

  %.. compressing data
  f   = [fb, fab];
  Tts = [T00, T02, T03, T04, T05, T06, T07, T09];
  Pts = [P00, P02, P03, P04, P05, P06, P07, P08];

end
