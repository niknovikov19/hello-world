function S = gen_gamma_spikemat(tvec, N, r, CV)
% Generate a binary matrix, in which 1's are spikes from gamma process
% tvec - time bins
% N - number of neurons
% r - firing rate
% CV - CV of the gamma process

Nt = length(tvec);
T = tvec(end) - tvec(1);

S = zeros(N,Nt);

for n = 1 : N
   st = gen_gamma_spiketrain(r,CV,T) + tvec(1);
   st_idx = arrayfun(@(x)min_id(abs(x-tvec)), st);
   S(n,st_idx) = 1;
end


end

