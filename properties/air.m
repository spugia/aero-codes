%.. computes thermodynamic properties of air
%.. valid for T = 60 -> 1900 K

% T   = temperature of air
% eng = english units flag
%     - false: Pr = [], T = [K], Cp/Cv = [J/kg-k],    R = [J/kg-k]    k = [], Mw = [kg/mol]
%     -  true: Pr = [], T = [R], Cp/Cv = [BTU/lbm-R], R = [BTU/lbm-R] k = [], Mw = [lbm/mol]

function [Pr, Cp, Cv, k, R, Mw] = air(T, eng)

	if (eng)
		T = T ./ 1.8;
	end

	%.. data
	Ru = 8.314462618;
	Mw = 28.9647 / 1000;

	% - https://www.engineeringtoolbox.com/air-specific-heat-capacity-d_705.html
	Tq1 = [60    78.79 81.61 100  120   140   160   180   200   220   240   260   273.2 280   288.7 300   320   340   360  380   400   500  600   700   800   900   1100  1300  1500  1600  1700  1800  1900  2000  2100  2200  2300  2400  2500  2600  2700  2800  2900  3000  3100  3200  3300  3400  3500];
	Cpq = [1.901 1.933 1.089 1.04 1.022 1.014 1.011 1.008 1.007 1.006 1.006 1.006 1.006 1.006 1.006 1.006 1.007 1.009 1.01 1.012 1.014 1.03 1.051 1.075 1.099 1.121 1.159 1.188 1.211 1.220 1.229 1.237 1.244 1.250 1.255 1.260 1.265 1.269 1.274 1.278 1.281 1.285 1.288 1.291 1.294 1.297 1.300 1.303 1.306];
	
    % - https://www.engineeringtoolbox.com/air-prandtl-number-viscosity-heat-capacity-thermal-conductivity-d_2009.html
	Tq2 = [60 80 100 120 140 180 200 220 240 260 273 280 289 300 320 340 360 380 400 500 600 700 800 900 1000 1100 1500 1900];
	Prq = [4.138 1.7 0.78 0.759 0.747 0.731 0.726 0.721 0.717 0.713 0.711 0.71 0.709 0.707 0.705 0.703 0.701 0.7 0.699 0.698 0.703 0.71 0.717 0.724 0.73 0.734 0.743 0.742];

	for n = [1 : 1 : length(T)]

		if (T(n) > max(Tq1))
			T(n) = max(Tq1);
		end
	end

	%.. calculation
	R  = Ru / Mw;
	Cp = interp1(Tq1, Cpq, T) .* 1000;	
	Cv = Cp - R;
	k  = Cp ./ Cv;
	Pr = interp1(Tq2, Prq, T);

	%.. unit conversion
	if (eng)
		
		Cp = Cp .* 0.000238845896627;
		Cv = Cv .* 0.000238845896627;
		R  = R  .* 0.000238845896627;

		Mw = Mw * 2.20462;
	end
end