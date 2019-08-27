%.. computes thermodynamic properties of air
%.. valid for T = 60 -> 1900 K

% T   = temperature of air
% eng = english units flag
%     - false: T = [K], Cp/Cv/R = [J/kg-k],   k = [], Mw = [kg/mol]
%     -  true: T = [R], Cp/Cv/R = [BTU/lb-R], k = [], Mw = [lb/mol]

function [Cp, Cv, k, R, Mw] = air(T, eng)

	if (eng)
		T = T ./ 1.8;
	end

	%.. data
	Ru = 8.314462618;
	Mw = 18.01528 / 1000;

	%.. - https://www.engineeringtoolbox.com/air-specific-heat-capacity-d_705.html
	Tq  = [60 78.79 81.61 100 120 140 160 180 200 220 240 260 273.2 280 288.7 300 320 340 360 380 400 500 600 700 800 900 1100 1500 1900];
	Cpq = [1.901 1.933 1.089 1.04 1.022 1.014 1.011 1.008 1.007 1.006 1.006 1.006 1.006 1.006 1.006 1.006 1.007 1.009 1.01 1.012 1.014 1.03 1.051 1.075 1.099 1.121 1.159 1.21 1.241];

	%.. calculation
	R  = Ru / Mw;
	Cp = interp1(Tq, Cpq, T) .* 1000;
	Cv = Cp - R;
	k  = Cp ./ Cv;

	%.. unit conversion
	if (eng)
		
		Cp = Cp .* 0.238845896627;
		Cv = Cv .* 0.238845896627;
		R  = R  .* 0.238845896627;
	
		Mw = Mw * 2.20462;
	end
end