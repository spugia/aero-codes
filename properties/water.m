%.. computes thermodynamic properties of water

% T = temperature of water

function [Hv, s, Pv, Cp, Cv, k, R, Mw] = water(T)

	Mw = 18.01528E-3;
	R = 461.52;

	%.. vapor pressure [Pa]
	%.. NIST chemical database
	A = 5.40221;
	B = 1838.675;
	C = -31.737;

	Pv = 10.^(A-B./(T+C) + 5);

	%.. surface tension
	%https://srd.nist.gov/JPCRD/jpcrd231.pdf
	B = 235.8E-3;
	b = -0.625;
	mu = 1.256;
	Tc = 647.15;

	s = B.*((Tc - T) ./ Tc).^mu.*(1+b.*((Tc - T) ./ Tc));

	%.. heat of vaporization
	%.. engineering toolbox
	Hvs = [2500.9 2496.2 2491.4 2477.2 2467.7 2458.3 2453.5 2441.7 2429.8 2420.3 2406 2396.4 2381.9 2372.3 2357.7 2333 2308 2282.5 2266.9 2256.4 2229.6 2202.1 2144.3 2082 2014.2 1939.7 1857.4 1765.4 1661.6 1543 1404.6 1238.4 1027.3 719.8];
	Ts = [0.01 2 4 10 14 18 20 25 30 34 40 44 50 54 60 70 80 90 96 100 110 120 140 160 180 200 220 240 260 280 300 320 340 360];

	Hv = interp1(Ts, Hvs, T, 'linear') .* 1000;
end