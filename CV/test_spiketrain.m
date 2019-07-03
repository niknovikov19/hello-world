
r = 10;
T = 1;

CV0 = 2.5;

%x = gen_poisson_spiketrain(r,T);
x = gen_gamma_spiketrain(r, CV0, T);

ISI=x(2:end)-x(1:end-1);

CV = std(ISI)/mean(ISI);
CV2 = calc_spiketrain_CV2(x);

fprintf('CV = %f\n', CV);
fprintf('CV2 = %f\n', CV2);

figure(1000); hold on;
for n = 1 : length(x)
    plot(x(n)*[1,1], [0,1], 'k');
end
ylim([-0.5,1.5]);