%.. computes the ideal mixed mach number for constant pressure mixing process

function [Mm] = cpm_mach(Um, T0m, k, R)

	syms M;

	eqn = Um * sqrt((k*R*T0m) / (1 + (k-1)/2*Mm^2)) == M;

	Mm = double(solve(eqn, M));
end