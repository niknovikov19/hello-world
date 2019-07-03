function spiketimes = gen_poisson_spiketrain(r, T)
% Generate vector of spike times of Poisson process
% r - firing rate, Hz
% T - length of the spike train, sec

N = r*T*10;

while 1==1    
    ISI = exprnd(1/r,1,N);
    if sum(ISI) > T
        break;
    end
end

spiketimes = cumsum(ISI);
spiketimes = spiketimes(spiketimes <= T);

end
