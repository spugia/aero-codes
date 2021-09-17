classdef PRN < handle

	properties

		ID;

		G1;
		G2;

		signal = [];
	end

	properties (Constant)

		codephase = [1 2 6; 2 3 7; 3 4 8; 4 5 9; 5 1 9; 6 2 10; 7 1 8; 8 2 9; ...
		             9 3 10; 10 2 3; 11 3 4; 12 5 6; 13 6 7; 14 7 8; 15 8 9; 16 9 10; ...
		             17 1 4; 18 2 5; 19 3 6; 20 4 7; 21 5 8; 22 6 9; 23 1 3; 24 4 6; ...
		             25 5 7; 26 6 8; 27 7 9; 28 8 10; 29 1 6; 30 2 7; 31 3 8; 32 4 9; ...
		             33 5 10; 34 4 10; 35 1 7; 36 2 8; 37 4 10]
	end

	methods

		function prn = PRN(ID, Tc, seed)

			prn.ID = ID;

			prn.G1 = LFSR(Tc, seed, [3 10]);
			prn.G2 = LFSR(Tc, seed, [2 3 6 8 9 10]);

			prn.signal(end+1) = prn.calculate();
		end

		function s = increment(prn)

			prn.G1.increment(); prn.G2.increment();

			s = prn.calculate;

			prn.signal(end+1) = prn.calculate();
		end

		function s = calculate(prn)

			cid = find(prn.codephase(:, 1) == prn.ID);

			g1s = prn.G1.signal(end);

			t1 = prn.codephase(cid, 2); t2 = prn.codephase(cid, 3);

			g2s = prn.G2.signal(t1) + prn.G2.signal(t2);

			if mod(g2s, 2) == 0
				g2s = 0;
			else 
				g2s = 1;
			end

			s = g1s + g2s;

			if mod(s, 2) == 0
				s = 0;
			else 
				s = 1;
			end
		end
	end
end