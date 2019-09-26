%.. computes the mixed property of two streams
%.. applicable for velocity, stagnation temperature, and stagnation pressure

function [m] = cpm_upt(p, s, a)

	m = (p + a*s) / (1 + a);
end