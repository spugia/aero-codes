%.. computes the conditions behind a normal shock

function [M2, P2P1, P02P01, T2T1] = normal(M1, k)

	M2     = sqrt(((k-1)*M1^2 + 2) / (2*k*M1^2 - (k-1)));
	P2P1   = (2*k*M1^2 - (k-1)) / (k+1);
	P02P01 = (((k+1)*M1^2) / ((k-1)*M1^2 + 2))^(k/(k-1)) * ((k+1) / (2*k*M1^2 - (k-1)))^(1/(k-1));
	T2T1   = ((2*k*M1^2-(k-1)) * ((k-1)*M1^2+2)) / ((k+1)^2*M1^2);
end