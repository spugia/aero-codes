classdef LFSR < handle

	properties

		Tc = 10;

		taps = zeros(1, 10);
		seed = zeros(1, 10);

		signal = zeros(1, 10);
	end

	methods

		function lfsr = LFSR(Tc, seed, taps)

			if (length(seed) ~= Tc)
				fprintf('invalid seed size\n');
				return;
			end

			if (length(taps) < 2)
				fprintf('invalid tap length\n');
				return;
			end

			if (max(taps) > Tc || min(taps) < 1)
				fprintf('invalid tap ID\n');
				return;
			end

			lfsr.Tc   = Tc;
			lfsr.seed = seed;
			lfsr.taps = taps;

			lfsr.signal = lfsr.seed;
		end

		function increment(lfsr)

			s = 0;

			for tap = lfsr.taps
				s = s + lfsr.signal(tap);
			end

			if mod(s, 2) == 0
				s = 0;
			else
				s = 1;
			end

			lfsr.signal = [s, lfsr.signal(1:end-1)];
		end
	end
end