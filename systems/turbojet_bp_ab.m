%.. real turbojet performance with bypass and afterburner
%.. english units only

function [Fsp, SFC, f, Tts, Pts] = turbojet_bp_ab(M0, T0, P0, Hc, Cp, k, Beta, CPR, T04, T07, etas, abon)

  %.. constants
  btuconv = 778.169;
  g       = 32.17405;
  R       = 53.353;

  %.. efficiencies
  nc  = etas(1);
  nb  = etas(2);
  nt  = etas(3);
  nab = etas(4);
  nn  = etas(5);

  %.. freestream
  u0 = sqrt(k*R*g*T0) * M0;

  T00 = T0 * (1 + (k - 1)/2 * M0^2);
  P00 = P0 * (1 + (k - 1)/2 * M0^2)^(k/(k - 1));

  %.. inlet
  P02 = P00 * ideal_inlet(M0);
  T02 = T00;

  %.. compressor
  T03 = T02*(1+1/nc*(CPR^((k-1)/k)-1));
  P03 = CPR * P02;

  %.. burner
  fb = (Cp*(T04-T03)) / (nb*Hc - Cp*T04);

  P04 = P03;

  %.. turbine
  T05 = T04 - (T03-T02) / (nt*(1+fb));
  P05 = P04*(T05/T04)^(k/(k-1));

  %.. constant pressure mixer
  T06 = ((1+fb)*T05 + Beta*T02) / (1+fb+Beta);
  P06 = ((1+fb)*P05 + Beta*P02) / (1+fb+Beta);

  %.. afterburner
  if (abon)

    fab = (Cp*(1+Beta+fb)*(T07-T06)) / ((1+Beta)*(nab*Hc - Cp*T07));

  else 

    fab = 0;
    T07 = T06;
  end

  P07 = P06;

  %.. nozzle
  T09 = T07;
  P09 = P07;

  u9 = sqrt(2*Cp*btuconv*g*nn*T05*(1-(P0/P07)^((k-1)/k)));

  %.. performance parameters
  Fsp = ((1+Beta+fb+fab)*u9 - (1+Beta)*u0) / (g*(1+Beta)); 
  SFC = (g*(fb+fab)) / ((1+Beta+fb+fab)*u9 - (1+Beta)*u0);

  %.. compressing data
  f   = [fb, fab];
  Tts = [T00, T02, T03, T04, T05, T06, T07, T09];
  Pts = [P00, P02, P03, P04, P05, P06, P07, P09];
end
