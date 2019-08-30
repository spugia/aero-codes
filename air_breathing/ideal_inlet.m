function [P02P00] = ideal_inlet(M)

  	if (M < 1)
    	P02P00 = 1;
	elseif (M < 5)
		P02P00 = 1-0.075*(M-1)^1.35;
	else
		P02P00 = 800 / (M^4 + 935);
	end

end
