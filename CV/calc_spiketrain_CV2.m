function CV2 = calc_spiketrain_CV2(spiketimes)
% Calculate CV2 of a spike train

ISI = spiketimes(2:end) - spiketimes(1:end-1);

q = 2 * abs(ISI(1:end-1) - ISI(2:end)) ./ (ISI(1:end-1) + ISI(2:end));
CV2 = mean(q);

end

