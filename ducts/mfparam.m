function [mfp] = mfparam(M, k)

	mfp = M / ((1 + (k-1)/2*M^2)^((k+1) / (2*(k-1))));
end