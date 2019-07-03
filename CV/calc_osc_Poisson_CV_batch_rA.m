% Calculate CV of Poisson spike train with periodic rate modulation
% vs. modulation amplitude

T = 50;
dt = 1*10^-3;

% Mean and amlitude of firing rate, modulation frequency (Hz)
r0 = 10;
rA_vals = linspace(0,10,10);
rf = 40;

tvec = [0:dt:T];
Nt = length(tvec);

CV = [];
CV2 = [];

for n = 1 : length(rA_vals)

	fprintf('%i / %i\n', n, length(rA_vals)); 

	% Firing rate dynamics
	rvec = r0 + rA_vals(n) * sin(2*pi*rf*tvec);

	% Spike train
	S = (rand(1,Nt) < (rvec*dt));
	st = tvec(S);

	% CV, CV2
	ISI = st(2:end) - st(1:end-1);
	CV(n) = std(ISI) / mean(ISI);
	q = 2 * abs(ISI(1:end-1) - ISI(2:end)) ./ (ISI(1:end-1) + ISI(2:end));
	CV2(n) = mean(q);

end

figure; hold on;
plot(rA_vals, CV);
plot(rA_vals, CV2);
xlabel('rA, Hz');
legend('CV', 'CV2');



