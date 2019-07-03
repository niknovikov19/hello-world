function S = gen_modpoisson_spikemat(tvec, N, r, f, A)
% Generate a binary matrix, in which 1's are spikes from sinusoidally modulated Poisson process
% tvec - time bins
% N - number of neurons
% r - firing rate
% f - freq of modulation
% A - amplitude of modulation (peak rate / mean rate)

Nt = length(tvec);
T = tvec(end) - tvec(1);
dt = tvec(2) - tvec(1);

% Firing rate dynamics
rvec = r + A*r*cos(2*pi*f*tvec);

S = bsxfun(@le, rand(N,Nt), dt*rvec);

end

