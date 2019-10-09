%.. ideal turbojet performance with bypass and afterburner
%.. english units only

function [Isp] = ideal_turbojet(M0, Hc, Cp, k, CPR, T04, T07, etas)

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
  

end
