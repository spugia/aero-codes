function [flowprops] = addfluid(flowprops, fluid, mf)

	found = false;

	%.. adding to mass flow if already exists
	for n = [1 : 1 : length(flowprops.fluids)]

		if (strcmp(func2str(flowprops.fluids{n}), func2str(fluid)))

			flowprops.mf(n) = flowprops.mf(n) + mf;
			
			found = true;
			break;
		end
	end

	%.. adding if not already exists
	if (~found)

		flowprops.fluids{end+1} = fluid;
		flowprops.mf(end+1)     = mf;
	end
end