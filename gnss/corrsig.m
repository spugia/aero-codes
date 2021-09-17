function [dk, r12] = corrsig(s1, s2)

	if (length(s1) ~= length(s2))
		return;
	end

	L = length(s1);

	r12 = [];
	dk  = [];

	for k = [1 : 1 : (2 * L + 1)]

		s2s = circshift(s2, k-1);

		dk(end+1)  = (2 * L + 2) - 2 * k;
		r12(end+1) = mean(s1 .* s2s);
	end
end