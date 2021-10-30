function [dTD, dTW] = hopfield(H, P, T, Hr)

	T = T + 273.15;

	c = 299792458;

	dTD = [];
	dTW = [];

	hw = 11000;

	for n = [1 : 1 : length(P)]

		%.. dry
		hd  = 40136 + 148.72 * (T(n) - 273.16);
		Nd0 = 77.64 * P(n) / T(n);

		Nd = [];

		dl = abs(H - hd) / 1000;

		for h = [H : dl : hd]

			Nd(end+1) = Nd0 * (1 - h / hd) ^ 4;
		end

		dTD(end+1) = 10^-6 / c * sum(Nd .* dl);

		%.. wet
		e0 = 6.108 * Hr(n) / 100 * exp((17.15 * T(n) - 4684) / (T(n) - 38.5));
		Nw0 = 3.73E5 * e0 / (T(n) ^ 2);

		dl = abs(H - hw) / 1000;

		Nw = [];

		for h = [H : dl : hw]

			Nw(end+1) = Nw0 * (1 - h / hw) ^ 4;
		end	

		dTW(end+1) = 10^-6 / c * sum(Nw .* dl);
	end
end