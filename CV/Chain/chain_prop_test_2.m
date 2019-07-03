
%%%% Parameters

T = 3000 * 10^-3;
dt = 0.1 * 10^-3;

% Filter parameters
TH = 500 * 10^-3;		% Filter kernel length
A = 30;					% Amplitude
tau = 50 * 10^-3;		% Decay time constant
f = 40;					% Carrier frequency
c = 0.3;				% Intercept

% Signal properties
sig_t0 = 800 * 10^-3;	% Center of the spindle
sig_sigma = 50 * 10^-3;			% Spindle envelope std.
sig_f = 40;				% Spindle frequency
sig_A = 0.1;				% Signal amplitude

% Numberof propagation steps
nsteps = 100;

%%%%

% Time samples (data)
tvec = [0:dt:T];
Nt = length(tvec);

% Time samples (filter)
tvecH = [0:dt:TH];
NtH = length(tvecH);

% Initial phase of filter oscillations that provides zero integral of the filter
phi = atan(1/(2*pi*f*tau));

% Create filter
H = A * exp(-tvecH/tau) .* cos(2*pi*f*tvecH + phi*1.15);

% Allocate output
R = zeros(nsteps, Nt);

% Generate signal
R(1,:) = sig_A * normpdf(tvec, sig_t0, sig_sigma) .* cos(2*pi*sig_f*(tvec-sig_t0));

% Test
figure(200); clf;
subplot(2,1,1);
plot(tvecH, H);
title('Filter');
subplot(2,1,2);
plot(tvec, R(1,:));
title('Signal');

disp(sum(H));

for n = 2 : nsteps	
	X = conv(R(n-1,:), H, 'full') * dt;
	X(1:NtH) = 0;
	X = X + c;
	R(n,:) = X(1:Nt);
end

figure(10); clf; hold on;

%{
for n = 1 : nsteps
	D = -n*2;
	plot(tvec, R(n,:) + D);
	plot(minmax(tvec), D*[1,1], 'k');
end
%}

%{
subplot(2,1,1); hold on;
imagesc(tvec, [1:nsteps], R);
xlabel('Time');
ylabel('Step');
xlim(minmax(tvec));
ylim([1,nsteps]);
set(gca, 'ydir', 'normal');
colorbar;

subplot(2,1,2);
plot(tvecH, H);
%}

plot(max(R-c,[],2));
plot([1,nsteps], [0,0], 'k');