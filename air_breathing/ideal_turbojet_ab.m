%.. ideal turbojet with afterburner performance
%.. english units only

function [Isp, cont] = ideal_turbojet_ab(V0, M, P0, T0, CPR, T05, T07, Hc, Cp, k)

  btuconv = 778.169;
  g = 32.17405;

  %.. stagnation
  P00 = P0 * (1 + (k - 1) / 2 * M ^ 2) ^ (k / (k - 1));
  T00 = T0 * (1 + (k - 1) / 2 * M ^ 2);

  %.. inlet
  P02 = P00 * ideal_inlet(M);
  T02 = T00;

  %.. compressor
  P03 = P02 * CPR;
  T03 = T02 * (CPR) ^ ((k - 1) / k);

  %.. combustor
  P05 = P03;
  f = Cp*(T05 - T03) / (Hc - Cp*T05);

  %.. turbine
  T06 = T05 - (T03 - T02) / (1 + f);
  P06 = P05 * (T06 / T05) ^ (k / (k - 1));

  %.. afterburner
  fab = (Cp*(1+f)*(T07-T06)) / (Hc - Cp*T07);
  P07 = P06;

  %.. nozzles
  V9 = sqrt(2*Cp*btuconv*g*T07*(1 - (P0 / P07)^((k-1) / k)));

  %.. performance characteristics
  Isp = ((1 + f + fab)*V9 - V0) / ((f + fab) * g);

  cont = false;

  if f > 0 & fab > 0 & Isp > 0
    cont = true;
  end
end
