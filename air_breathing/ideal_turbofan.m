function [Fsp, T05] = ideal_turbofan(M, P0, T0, k, Cp, FPR, BPR, CPR, f, Hc)

  %.. stagnation
  P00 = P0 * (1 + (k - 1) / 2 * M ^ 2) ^ (k / (k - 1));
  T00 = T0 * (1 + (k - 1) / 2 * M ^ 2);

  %.. inlet
  P02 = P00 * ideal_inlet(M);
  T02 = T00;

  %.. fan
  P03 = FPR * P02;
  T03 = T02 * (FPR) ^ ((k - 1) / k);

  %.. compressor
  P04 = P03 * CPR;
  T04 = T03 * (CPR) ^ ((k - 1) / k);

  %.. combustor
  P05 = P04;
  T05 = (1/f*Hc + Cp*T04) / (Cp*(1 + 1/f));

  %.. turbine
  T06 = T05 - (T04 - T03 + (1 + BPR)*(T03 - T02)) / (1 + 1/f);
  P06 = P05 * (T06 / T05) ^ (k / (k - 1));

  %.. nozzles
  V9b = sqrt(2*Cp*T03*(1 - (P0 / P03)^((k-1) / k)))
  V9  = sqrt(2*Cp*T06*(1 - (P0 / P06)^((k-1) / k)))

  %.. performance characteristics
  Fsp = (BPR*V9b - BPR*V0 + (1 + 1/f)*V9 - V0) / (1 + BPR);
end
