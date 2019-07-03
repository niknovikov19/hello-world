function S = gen_poisson_spikemat(tvec, N, r)
% Generate a binary matrix, in which 1's are spikes from Poisson process
% tvec - time bins
% N - number of neurons
% r - firing rate

Nt = length(tvec);
T = tvec(end) - tvec(1);

S = zeros(N,Nt);

for n = 1 : N
   st = gen_poisson_spiketrain(r,T) + tvec(1);
   st_idx = arrayfun(@(x)min_id(abs(x-tvec)), st);
   S(n,st_idx) = 1;
end


end

