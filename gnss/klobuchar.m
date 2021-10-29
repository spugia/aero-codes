function [t, dT] = klobuchar(phiR, lambdaR, tg, EL, AZ, a, b)

	d2s = 1 / 180;
	s2r = pi;
	d2r = pi / 180;

	AZ = AZ .* pi / 180;
	EL = EL ./ 180;

	psi  = 0.0137 ./ (EL + 0.11) - 0.022;

	phiI = phiR .* d2s + psi .* cos(AZ);
	phiI(find(phiI > 0.416))  =  0.416;
	phiI(find(phiI < -0.416)) = -0.416;

	lambdaI = lambdaR .* d2s + psi .* sin(AZ) ./ cos(phiI .* s2r);
	
	phiM = phiI + 0.064 .* cos((lambdaI - 1.617) .* s2r);

	A2 = [];
	A4 = [];

	for m = [1 : 1 : length(phiM)]

		A2(end+1) = 0;
		A4(end+1) = 0;

		for n = [0 : 1 : 3]
		
			A2(end) = A2(end) + (a(n+1) * phiM(m).^n);
			A4(end) = A4(end) + (b(n+1) * phiM(m).^n);
		end
	end

	A2 = A2';
	A4 = A4';

	t = 43200 .* lambdaI + tg;

	x   = 2 * pi .* (t - 50400) ./ A4;
	dTz = 5E-9 + A2 .* (1 - x.^2 ./ 2 + x.^4 ./ 24);
	dTz(find(abs(x) > pi/2)) = 5E-9;

	F = 1 + 16 .* (0.53 - EL).^3;
	dT = F .* dTz;
end