%.. ideal ram or scram jet
%.. english units only

function [Isp, cont] = ideal_ramscramjet(V0, M, P0, T0, T04, Hc, Cp, k)

  btuconv = 778.169;
  g = 32.17405;

  %.. stagnation
  P00 = P0 * (1 + (k - 1) / 2 * M ^ 2) ^ (k / (k - 1));
  T00 = T0 * (1 + (k - 1) / 2 * M ^ 2);

  %.. inlet
  P03 = P00 * ideal_inlet(M);
  T03 = T00;

  %.. combustor
  P04 = P03;
  f = Cp*(T04 - T03) / (Hc - Cp*T04);

  %.. nozzles
  V9 = sqrt(2*Cp*btuconv*g*T04*(1 - (P0 / P04)^((k-1) / k)));

  %.. performance characteristics
  Isp = ((1 + f)*V9 - V0) / (f * g);

  cont = false;

  if f > 0 & Isp > 0
    cont = true;
  end
end
