%.. computes mach number for constant entropy area change

function [Mach] = mach(E, k)

	syms M;

	eqn = ((k+1)/2)^(-(k+1)/(2*(k-1)))*(1+(k-1)/2*M^2)^((k+1)/(2*(k-1)))/M == E;

	Machs = double(solve(eqn, M));

	Machs(find(imag(Machs) ~= 0)) = [];

	Mach = max(Machs);
end