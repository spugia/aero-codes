%.. computes mach number for constant entropy area change

function [M2] = mach(A2A1, M1, k)

	syms M;

	eqn = M1/M*sqrt((1+(k-1)/2*M^2) / (1+(k-1)/2*M1^2) ^ ((k+1) / (k-1))) == A2A1;

	M2 = double(solve(eqn, M));
end