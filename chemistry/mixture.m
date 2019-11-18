function [Cpm, km, Rm, Mwm] = mixture(flowprops, T)

	Cpm = 0;
	km  = 0;
	Mwm = 0;

	nt = 0;

	for n = [1 : 1 : length(flowprops.fluids)]

		fluid = flowprops.fluids{n};
		[Cp, k, ~, Mw] = fluid(T);

		nx = flowprops.mf(n)/Mw;

		Cpm = Cpm + Cp*nx;
		km  = km + k*nx;
		Mwm = Mwm + Mw*nx;

		nt = nt + nx;
	end

	Cpm = Cpm / nt;
	km  =  km / nt;
	Mwm = Mwm / nt;

	Ru = 8.314462618;
	Rm  = Ru / Mwm;
end