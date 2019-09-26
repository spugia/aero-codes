%.. computes the conditions of an oblique shock wave

function [B1, M1n, M2n, M2] = oblique(M1, theta, k)

	B1  = tbm(M1, theta, k);
	M1n = M1 * sind(B1);
	M2n = sqrt((M1n^2 + 2 / (k - 1)) / ((2*k) / (k - 1) * M1n^2 - 1));
	M2  = M2n / sind(B1 - theta);
end