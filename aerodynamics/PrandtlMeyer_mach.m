%.. computes the Prandtl-Meyer function for mach number

function Ms = PrandtlMeyer_mach(nu, k)

	syms M;

	eqn = 180 * (sqrt((k+1) / (k-1)) * atan(sqrt((k-1) / (k+1) * (M^2 - 1))) - atan(sqrt(M^2 - 1))) / pi == nu;
	Ms  = abs(solve(eqn, M));
end