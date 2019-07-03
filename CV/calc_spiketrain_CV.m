function CV = calc_spiketrain_CV(tspikes)
% Calcualate CV of a spike train

ISI = tspikes(2:end) - tspikes(1:end-1);
CV = std(ISI) / mean(ISI);

end

