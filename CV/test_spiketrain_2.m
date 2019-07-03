
r = 10;
T = 25;
CV = 1;
N = 1000;

S = {};

for n = 1 : N
    S{n} = gen_gamma_spiketrain(r, CV, T);
end

[h,b] = hist([S{:}],20);
h = h / sum(h);

figure;
plot(b,h);

CV_vec = zeros(1,N);

for n = 1 : N
    S1 = S(1:n);
    st = sort([S1{:}]);
    CV_vec(n) = calc_spiketrain_CV(st);
end

figure;
plot(CV_vec);

%fprintf('CV = %.01f\n', CV_1);

% 11111111
