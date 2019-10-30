function [xs, As, mfs, Ms, vs, P0s, T0s, Ps, Ts, Fj] = supersonic_comb(k, Cp, M3, P03, T03, mf, Hc, f, AR, Ls, as)

	T3 = temp(T03, M3, 1.4, false);
	[~, Cpa, ~, ka, Ra, ~] = air(T3, false);

	T3   = temp(T03, M3, ka, false);
	P3   = pressure(P03, M3, ka, false);
	rho3 = density(P03/(Ra*T03), M3, ka, false);
	h0   = sqrt(mf/(rho3*M3*sqrt(ka*Ra*T3)*AR));
	u3   = M3*sqrt(ka*Ra*T3);
	A3   = h0^2*AR;

	L1 = Ls(1);
	L2 = Ls(2);
	L3 = Ls(3);

	a1 = as(1);
	a2 = as(2);
	a3 = as(3);

	Lt = L1 + L2 + L3;

	ai1 = f*mf*pi/(2*Lt*L1);
	ai2 = f*mf*pi/(2*Lt*L2);
	ai3 = f*mf*pi/(2*Lt*L3);

	As  = [];
	mfs  = [];
	Ms  = [];
	vs  = [];
	Ps  = [];
	P0s = [];
	Ts  = [];
	T0s = [];

	As(1)  = A3;
	mfs(1) = mf;
	Ms(1)  = M3;
	Ps(1)  = P3;
	P0s(1) = P03;
	Ts(1)  = T3;
	T0s(1) = T03;
	vs(1)  = u3;

	xs = linspace(0, L1+L2+L3, 1E5);
	xinc = xs(2) - xs(1);

	for n = [2 : 1 : length(xs)]

		x = xs(n);

		if (x <= L1)

			ax = a1;
			Li = L1;
			ai = ai1;

			dx = x;
			hx = h0 + dx*tand(ax);
			
		elseif (x <= L1 + L2)

			ax = a2;
			Li = L2;
			ai = ai2;

			dx = x-L1;
			hx = h0 + L1*tand(a1) + dx*tand(ax);
			 
		elseif (x <= L1 + L2 + L3)

			ax = a3;
			Li = L3;
			ai = ai3;

			dx = x-L2-L1;
			hx = h0 + L1*tand(a1) + L2*tand(a2) + dx*tand(ax);			
		end

		%.. area
		dAdx   = AR*hx^2*tand(ax);
		As(n)  = AR*hx^2;

		%.. mass flow
		dmdx   = ai*sin(pi*dx/Li);
		mfs(n) = mfs(n-1) + dmdx*xinc;

		%.. stag temperature
		dTdx   = dmdx*(Hc/(Cp*T0s(n-1)) - 1) / mfs(n);
		T0s(n) = T0s(n-1) + dTdx*xinc;

		lst = -1;
		it = 0;

		while (abs(lst - T0s(n)) > 1E-3)

			dTdx   = dmdx*(Hc/Cp-T0s(n)) / mfs(n);

			lst   = T0s(n);
			T0s(n) = T0s(n-1) + dTdx*xinc;

			it = it + 1;

			if (it > 10)
				break;
			end
		end

		%.. mach number
		dMdx  = Ms(n-1)*((1 + (k-1)/2*Ms(n-1)^2) / (1 - Ms(n-1)^2))*(-dAdx/As(n)+(1+k*Ms(n-1)^2)/2*dTdx/T0s(n-1));
		Ms(n) = Ms(n-1) + dMdx*xinc;

		lst = -1;
		it = 0;

		while (abs(lst - Ms(n)) > 1E-3)

			dMdx  = Ms(n)*((1 + (k-1)/2*Ms(n)^2) / (1 - Ms(n)^2))*(-dAdx/As(n)+(1+k*Ms(n)^2)/2*dTdx/T0s(n));
			
			lst = Ms(n);
			Ms(n) = Ms(n-1) + dMdx*xinc;

			it = it + 1;

			if (it > 10)
				break;
			end
		end

		%.. other properties
		Ts(n)  = T3*T0s(n)/T03*((2+(k-1)*M3^2) / (2+(k-1)*Ms(n)^2));
		Ps(n)  = P3*As(1)/As(n)*M3/Ms(n)*sqrt(Ts(n)/T3);
		P0s(n) = pressure(Ps(n), Ms(n), k, true);
		vs(n)  = u3*Ms(n)/M3*sqrt(Ts(n)/T3);
	end

	Fj = mfs(end)*vs(end);
end