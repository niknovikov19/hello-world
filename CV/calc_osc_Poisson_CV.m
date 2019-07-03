% Calculate CV of Poisson spike train with periodic rate modulation


T = 100;
dt = .1*10^-3;

% Mean and amlitude of firing rate, modulation frequency (Hz)
r0 = 10;
rA = 10;
rf = 38;		% should not be a divisor of 1/dt

tvec = [0:dt:T];
Nt = length(tvec);


% Firing rate dynamics
rvec = r0 + rA*sin(2*pi*rf*tvec);
phi = mod(2*pi*rf*tvec, 2*pi);

% Spike train
S = (rand(1,Nt) < (rvec*dt));
st = tvec(S);

% CV, CV2
ISI = st(2:end) - st(1:end-1);
CV = std(ISI) / mean(ISI);
q = 2 * abs(ISI(1:end-1) - ISI(2:end)) ./ (ISI(1:end-1) + ISI(2:end));
CV2 = mean(q);

fprintf('CV = %.01f\n', CV);
fprintf('CV2 = %.01f\n', CV2);

figure;
sp_phi_vec = sort(phi(S));
%plot(sort(phi(S)), 'k.');
%ylim([0,2*pi]);
[h,b] = hist(sp_phi_vec,15);
h = h / sum(h);
figure;
plot(b,h);
xlabel('Phase');
ylabel('Percentage of spiked');

