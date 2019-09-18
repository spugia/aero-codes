function [M2] = Nozzle(A2A1, M1, k)

	sym M;

	eqn = M1/M2*sqrt((1+(k-1)/2*M2^2) / (1+(k-1)/2*M1^2) ^ ((k+1) / (k-1))) == A2A1;

	M2 = double(solve(eqn, M));
end