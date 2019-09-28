%.. computes static/stagnation temperature for a given mach number in an isentropic process

function [T2] = temp(T1, M, k, stag)

	pow = -1;

	if (stag)
		pow = 1;
	end

	T2 = T1 * (1 + (k - 1)/2 * M^2) ^ (pow);
end