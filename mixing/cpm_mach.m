%.. computes the ideal mixed mach number for constant pressure mixing process

function [Mm] = cpm_mach(Um, T0m, k, R)

	syms M;

	eqn = Um * ((k*R*T0m) / (1 + (k-1)/2*M^2))^(-1/2) == M;

	Mm = double(solve(eqn, M));
end