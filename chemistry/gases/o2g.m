function [Cp, k, R, Mw] = o2g(T)

	Ru = 8.314462618;
	Mw = 31.9988E-3;
	R  = Ru / Mw;

	%.. specific heat ratio
	%.. NIST
	A = [31.32234, 30.03235, 20.91111];
	B = [-20.23531, 8.772972, 10.72071];
	C = [57.86644, -3.988133, -2.020498];
	D = [-36.50624, 0.788313, 0.146449];
	E = [-0.007374, -0.741599, 9.245722];
	F = [-8.903471, -11.32468, 5.337651];
	G = [246.7945, 236.1663, 237.6185];

	if T < 700

		n = 1;

	elseif T < 2000

		n = 2;

	elseif T < 6000

		n = 3;
	end

	T = T / 1000;

	Cp = A(n)+B(n)*T+C(n)*T^2+D(n)*T^3+E(n)/T^2;

	Cp = Cp / Mw;

	Cv = Cp - R;
	k  = Cp / Cv;
end