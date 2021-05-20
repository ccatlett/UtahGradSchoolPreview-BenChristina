% Simple SSA, deteministic timestep
% Author(s): Ben & Christina
% Date: 5/17/21
% Desc: Implementation of Alg 1 from Erban et al - Simulates degradation
%       over time period (t0,t_final) with delta_t timesteps for n0 initial
%       particles and rate of degradation k

function A = algorithm1(t0, t_final, delta_t, k, n0) 
    % Define timespan w timestep, initialize vec
    timespan = t0:delta_t:t_final;
    A = [n0, zeros(1, (length(timespan) -1))];
    
    % Perform alg for all time
    for i = [2:length(timespan)]
        % Random sample
        r = rand(1,1);
        if r < (A(i-1)*k*delta_t)
            A(i) = A(i-1) - 1; % Decay with prob A(i-1)*k*delta_t
        else
            A(i) = A(i-1); % Remain with prob 1-A(i-1)*k*delta_t
        end
    end
end