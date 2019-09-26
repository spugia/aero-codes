%.. computes static temperature for a given mach number in an isentropic process

function [T] = static_p(T0, M, k)

	T = T0 * (1 + (k - 1)/2 * M^2) ^ -1;
end