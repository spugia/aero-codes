%.. computes the Prandtl-Meyer function for nu

function nu = pm_nu(M, k)

	nu = sqrt((k+1) / (k-1)) * atand(sqrt((k-1) / (k+1) * (M^2 - 1))) - atand(sqrt(M^2 - 1));
end