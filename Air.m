%.. computes thermodynamic properties of air
%.. valid for T = 250 -> 1500
%.. data source: https://www.ohio.edu/mechanical/thermo/property_tables/air/air_Cp_Cv.html

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

	Tq = [250 : 50 : 1500];
	Cpq = [1.003 1.005 1.008 1.013 1.020 1.029 1.040 1.051 1.063 1.075 1.087 1.099 1.121 1.142 1.155 1.173 1.19 1.204 1.216];

	%.. calculation
	R  = Ru / Mw;
	Cp = interp1(Tq, Cpq, T) .* 1000;
	Cv = Cp - R;
	k  = Cp ./ Cv;

	%.. unit conversion
	Cp = Cp .* 0.2390057361377
	Cv = Cv .* 0.2390057361377
	R  = R  .* 0.2390057361377

	Mw = Mw * 2.20462;
end