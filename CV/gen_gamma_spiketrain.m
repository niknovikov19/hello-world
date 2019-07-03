function spiketimes = gen_gamma_spiketrain(r, CV, T)
% Generate vector of spike times of gamma process
% r - firing rate, Hz
% T - length of the spike train, sec

% Parameters of gamma distribution
mu = 1 / r;
alpha = 1 / CV^2;
rho = alpha / mu;

% Vector of time intervals at which gamma distribution will be calculated
M = 2000;
t = linspace(10^-3, 2, M);

% Gamma distribution
p = 1 / gamma(alpha) * rho * (rho*t).^(alpha-1) .* exp(-rho*t);
p(isnan(p)) = 0;

N = round(r*T*4);

d = 0.5;

while 1==1    
    ISI = randsample(t,N,true,p);
    %ISI = ISI(randperm(N));
    if sum(ISI) > (1+d)*T
        break;
    end
    fprintf('Repeat\n');
end

% ISI's -> spike times
spiketimes = cumsum(ISI);

% Take spike times from a given time interval
% (discard the beginning due to accumulation problems)
idx = find((spiketimes >= d*T) & (spiketimes <= (1+d)*T));
spiketimes = spiketimes(idx) - d*T;

end
