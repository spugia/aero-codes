%.. computes static pressure for a given mach number in an isentropic process

function [P] = static_p(P0, M, k)

	P = P0 * (1 + (k - 1)/2 * M^2) ^ (-k/(k - 1));
end