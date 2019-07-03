function CV = calc_spikemat_CV(S, tvec)
% Calcualate average CV of a set of spike trains
% S - matrix of spikes (neurons x samples); S==1 if thre is a spike
% tvec- vector of time moments

N = size(S,1);

CV = NaN * ones(1,N);

%nspikes_min = 7;
nspikes_min = 3;

for n = 1 : N
    tspikes = tvec(find(S(n,:)));
    if length(tspikes) >= nspikes_min
        ISI = tspikes(2:end) - tspikes(1:end-1);
        CV(n) = std(ISI) / mean(ISI);
    end
end

CV = nanmean(CV);

end

