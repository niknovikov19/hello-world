
T = 2500 * 10^-3;
dt = 1 * 10^-3;

TH = 100 * 10^-3;

A1 = 2;
A2 = -1;
tau1 = 5 * 10^-3;
tau2 = 10 * 10^-3;

A3 = 1;
tau3 = 8 * 10^-3;

tsig0 = 150 * 10^-3;
Tsig = 300 * 10^-3;

nsteps = 500;


tvec = [0:dt:T];
Nt = length(tvec);

tvecH = [0:dt:TH];

A1 = A1 / tau1;
A2 = A2 / tau2;
A3 = A3 / tau3;

H1 = A1*exp(-tvecH/tau1);
H2 = A2*exp(-tvecH/tau2);
%H1 = H1 / (sum(H1)*dt);
%H2 = H2 / (sum(H2)*dt);
H12 = H1 + H2;
H12 = H12 / (sum(H12)*dt) * 0.9;

H3 = A3*exp(-tvecH/tau3);
%H3 = H3 / sum(H3);

R = zeros(nsteps, Nt);

tsig_idx = find((tvec >= tsig0) & (tvec <= (tsig0+Tsig)));
R(1,tsig_idx) = 1;

for n = 2 : nsteps	
	if mod(n,2)==0
		X = conv(R(n-1,:), H12, 'full') * dt;
	else
		X = conv(R(n-1,:), H3, 'full') * dt;
	end
	R(n,:) = X(1:Nt);
end

figure(10); clf; hold on;

%{
for n = 1 : nsteps
	plot(tvec, R(n,:) - n*0.5);
end
%}

%%{
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
%%}