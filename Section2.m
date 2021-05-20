% Replication of Erban et al. Figure 2.1
% Author(s): Ben & Christina
% Date: 5/17/21
% Desc: Implementation of Alg 1 from to recreate Fig 2.1a,b from Erban et
%       al.

clear all;

%% Figure 2.1a

% Initialize times
t0 = 0;
delta_t = 0.005;
t_final = 30;
timespan = t0:delta_t:t_final;

% Initialize A vec
k = 0.1;
n0 = 20;

% Calc 2 runs
A1 = algorithm1(t0, t_final, delta_t, k, n0);
A2 = algorithm1(t0, t_final, delta_t, k, n0); 

% Plot
plot(timespan,[A1; A2]);

%% Figure 2.1b

% Initialize vec
A_all = zeros(10, (length(t0:delta_t:t_final)));

% Calc 10 runs
for i = 1:10
    A_all(i, :) = algorithm1(t0, t_final, delta_t, k, n0);
end

% Calc means
A_mean_sample = mean(A_all);
A_mean_analytic = n0*exp(-k*timespan);

% Plot runs, means
plot(timespan, [A_all;A_mean_sample;A_mean_analytic]);




