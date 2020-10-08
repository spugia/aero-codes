%.. computes the mass flow parameter (normalized mass flow) for a given mach number

function [mfp] = mfparam(M, k, R)

	mfp = M * sqrt(k/R) * ((1 + (k-1)/2*M^2)^(-(k+1) / (2*(k-1))));
end