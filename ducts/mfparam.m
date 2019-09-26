%.. computes the mass flow parameter (normalized mass flow) for a given mach number

function [mfp] = mfparam(M, k)

	mfp = M / ((1 + (k-1)/2*M^2)^((k+1) / (2*(k-1))));
end