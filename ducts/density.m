%.. computes static/stagnation density for a given mach number in an isentropic process

function [rho2] = density(rho1, M, k, stag)

	pow = -1;

	if (stag)
		pow = 1;
	end

	rho2 = rho1 * (1 + (k - 1)/2 * M^2) ^ (1/(k - 1) * pow);
end