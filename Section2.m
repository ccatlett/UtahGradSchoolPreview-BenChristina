% Erban Paper Code
% Ben & Christina

%% Figure 2.1 a,b

clear all;

% Figure 2.1a

% Initialize times
t0 = 0;
delta_t = 0.005;
t_final = 30;
timespan = t0:delta_t:t_final;

% Initialize A vec
k = 0.1;
n0 = 20;

A1 = degradation(t0, t_final, delta_t, k, n0);
A2 = degradation(t0, t_final, delta_t, k, n0); 
plot(timespan,[A1; A2]);
pause;

% Figure 2.1b
A_all = zeros(10, (length(t0:delta_t:t_final)));
for i = 1:10
    A_all(i, :) = degradation(t0, t_final, delta_t, k, n0);
end

A_mean_sample = mean(A_all);
A_mean_analytic = n0*exp(-k*timespan);

plot(timespan, [A_all;A_mean_sample;A_mean_analytic]);

%% Figure 2.2



