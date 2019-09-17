%.. ideal turbofan performance
%.. english units only

function [Isp, cont] = ideal_turbofan(V0, M, P0, T0, P00, T00, CPR, FPR, BPR, T05, Hc, Cp, k)

  btuconv = 778.169;
  g = 32.17405;

  %.. stagnation
  P00 = P0 * (1 + (k - 1) / 2 * M ^ 2) ^ (k / (k - 1));
  T00 = T0 * (1 + (k - 1) / 2 * M ^ 2);

  %.. inlet
  P02 = P00 * ideal_inlet(M);
  T02 = T00;

  %.. fan
  P03 = P02 * FPR;
  T03 = T02 * (FPR) ^ ((k - 1) / k);

  %.. compressor
  P04 = P03 * CPR;
  T04 = T03 * (CPR) ^ ((k - 1) / k);

  %.. combustor
  P05 = P04;
  f = Cp * (T05 - T04) / (Hc - Cp * T05);

  %.. turbine
  T06 = T05 - (T04 - T03 + (1 + BPR)*(T03 - T02)) / (1 + f);
  P06 = P05 * (T06 / T05) ^ (k / (k - 1));

  %.. nozzles
  V9b = sqrt(2*Cp*btuconv*g*T03*(1 - (P0 / P03)^((k-1) / k)));
  V9  = sqrt(2*Cp*btuconv*g*T06*(1 - (P0 / P06)^((k-1) / k)));

  %.. performance characteristics
  Isp = ((1 + f)*V9 + BPR*V9b - (1 + BPR)*V0) / (f*g);

  cont = false;

  if f > 0 & Isp > 0
    cont = true;
  end
end
