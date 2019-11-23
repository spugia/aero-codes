function [Cp, Hv, Tv, Mw] = o2l(T, P)

	Mw = 31.9988E-3;

	%.. specific heat capacity
	Cp = 347.0;

	%.. heat of vaporization
	%.. engineering toolbox
	Hv = 6.82*1000/Mw;

	%.. boiling temperature for a given pressure
	A = 3.9523;
	B = 340.024;
	C = -4.144;

	P = P*1E-5;

	Tv = B / (A - log10(P)) - C;
end