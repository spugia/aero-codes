%.. computes static density for a given mach number in an isentropic process

function [rho] = static_rho(rho0, M, k)

	rho = rho0 * (1 + (k - 1)/2 * M^2) ^ (-1/(k - 1));
end