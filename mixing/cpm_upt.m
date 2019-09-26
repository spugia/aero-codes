%.. computes the mixed property of two streams
%.. applicable for velocity, stagnation temperature, and stagnation pressure

function [Pm] = cpm_upt(Pp, Ps, a)

	Pm = (Pp + a*Ps) / (1 + a);
end