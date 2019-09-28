%.. computes static or stagnation pressure for a given mach number in an isentropic process

function [P2] = pressure(P1, M, k, stag)

	pow = -1;

	if (stag)
		pow = 1;
	end

	P2 = P1 * (1 + (k - 1)/2 * M^2) ^ ((k/(k - 1)) * pow);
end