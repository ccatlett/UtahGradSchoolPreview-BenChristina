% Degradation-only SSA with tau-stepping
% Author(s): Ben & Christina
% Date: 5/17/21
% Desc: Implementation of Alg 2 from Erban et al - Simulates degradation
%       until fully degraded (A(t) = 0)

function [time, A] = algorithm2(t0, k, n0)
% Initialize vecs
A = [n0];
time = [t0];

    while (A(end) > 0)
        % Gen rand val
        r = rand(1,1);
        % Calc tau step
        tau = (1/(A(end)*k))*log(1/r);
        time_next = time(end) + tau;
        % Calc state
        A_next = A(end) - 1;
        A = [A, A_next];
        time = [time, time_next];    
    end

end
