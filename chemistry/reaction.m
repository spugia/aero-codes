function [flowprops] = reaction(flowprops, mff, mwf, c, h)

	%.. computing total oxygen mass flow
	mfo = 0;

	for n = [1 : 1 : length(flowprops.fluids)]

		if (strcmp(func2str(flowprops.fluids{n}), 'o2g'))

			mfo = mfo + flowprops.mf(n);
		end
	end

	%.. molecular weights
	[~, ~, ~, mwo] =  o2g(298);
	[~, ~, ~, mww] = h2og(298);
	[~, ~, ~, mwc] = co2g(298);

	%.. computing moles of oxygen and fuel
	no = mfo / mwo;
	nf = mff / mwf;

	%.. computing reaction
	A = [0 1 0; 1 2 2; 2 0 0];
	y = [c*nf; 2*no; h*nf];

	x = A\y;

	mw = x(1)*mww;
	mc = x(2)*mwc;
	mo = x(1)*mwo;

	%.. updating masses
	flowprops = addfluid(flowprops, @h2og, mw);
	flowprops = addfluid(flowprops, @co2g, mc);
	flowprops = addfluid(flowprops, @o2g,  mo-mfo);
end