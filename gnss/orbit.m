function [x, y, z, Ek] = orbit(tt, e, i0, as, dn, toe, M0, w, Cus, Cuc, Crs, Crc, Cis, Cic, IDOT, W0, Wd)

	mu = 3.9860044180E14;
	We = 7.2921151467E-5;

	a  = as^2;
	n0 = sqrt(mu / a^3);
	n  = n0 + dn;
	
	tkt = tt - toe;
	tkt(find(tkt >  302400)) = tkt(find(tkt >  302400)) - 604800;
	tkt(find(tkt < -302400)) = tkt(find(tkt < -302400)) + 604800;

	Mk = M0 + n .* tkt;

	Ek = [];

	Eks = linspace(-1E2, 1E2, 1E6);
	res = Eks - e .* sin(Eks);

	for n = [1 : 1 : length(tr)]
		Ek(n) = interp1(res - Mk(n), Eks, 0);
	end

	Ek = Ek';

	vk = 2 .* atan(sqrt((1 + e) ./ (1 - e)) .* tan(Ek ./ 2));
	
	phik = vk + w;

	duk = Cus .* sin(2 .* phik) + Cuc .* cos(2 .* phik);
	drk = Crs .* sin(2 .* phik) + Crc .* cos(2 .* phik);
	dik = Cis .* sin(2 .* phik) + Cic .* cos(2 .* phik);

	uk = phik + duk;
	rk = a .* (1 - e .* cos(Ek)) + drk;
	ik = i0 + dik + IDOT .* tkt;

	xk = rk .* cos(uk);
	yk = rk .* sin(uk);

	Lk = W0 + (Wd - We) .* tkt - We .* toe;

	x = xk .* cos(Lk) - yk .* cos(ik) .* sin(Lk);
	y = xk .* sin(Lk) + yk .* cos(ik) .* cos(Lk);
	z = yk .* sin(ik);
end