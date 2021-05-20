% Stochastic SIR simulations
% Author(s): Ben & Christina
% Date: 5/19/21
% Desc: Run simulations using stochasticSIR.m - Gives 3 plots:
%       1) All trajectories (S -> blue, I -> red)
%       2) Histogram of max infected at once
%       3) Histogram of time when all have been infected

% Set params
t0 = 0;
num_iter = 1000;
k1 = 0.1;
k2 = 0.7;
n0 = 100;
m0 = 10;
num_repeats = 10000;

% Initialize vecs
S_all = [n0*ones(num_repeats,1), zeros(num_repeats, (num_iter -1))];
I_all = [m0*ones(num_repeats,1), zeros(num_repeats, (num_iter -1))];
t = [t0*ones(num_repeats,1), zeros(num_repeats, (num_iter -1))];

hold on;
%% Running 10 iterations of stochastic SIR model
for i = 1:num_repeats
    [time, S, I] = stochasticSIR(t0, num_iter, k1, k2, n0, m0);
    % Save each iter
    S_all(i, :) = S;
    I_all(i, :) = I;
    t(i, :) = time;
    
    % Plot trajectories
    plot(t(i, :), S_all(i, :), 'b');
    plot(t(i, :), I_all(i, :), 'r');
end
   
hold off;

%% Plots for analysis

% Max infected at one time
Imax = max(I_all.');
histogram(Imax, 40);

% Time at depletion of S
t_noS = zeros(1,num_repeats);
for i = 1:num_repeats
    t_noS(i) = t(i, find(S_all(i, :) == 0,1));
end
histogram(t_noS, 40);
