%%% StochasticSIRsimulations

%%% Parameter initialization
t0 = 0;
num_iter = 1000;
k1 = 0.1;
k2 = 0.7;
n0 = 100;
m0 = 10;
num_repeats = 1000;

%% Empty matrices
S_all = [n0*ones(num_repeats,1), zeros(num_repeats, (num_iter -1))];
I_all = [m0*ones(num_repeats,1), zeros(num_repeats, (num_iter -1))];
t = [t0*ones(num_repeats,1), zeros(num_repeats, (num_iter -1))];

hold off;
%% Running 10 iterations of stochastic SIR model
for i = 1:num_repeats
    [time, S, I] = stochasticSIR(t0, num_iter, k1, k2, n0, m0);
    S_all(i, :) = S;
    I_all(i, :) = I;
    t(i, :) = time;
    
    plot(t(i, :), S_all(i, :), 'b');
    hold on;
    plot(t(i, :), I_all(i, :), 'r');
    
end
   
hold off 

Imax = max(I_all.');

histogram(Imax, 28);

%% null vector 
t_noS = [];

%% 
for i = 1:num_repeats
    t_noS(i) = t(i, find(S_all(i, :) == 0,1));


end

histogram(t_noS, 30);
