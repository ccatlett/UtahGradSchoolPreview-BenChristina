% Production-Degradation SSA with tau-stepping
% Author(s): Ben & Christina
% Date: 5/18/21
% Desc: Implementation of Alg 3 from Erban et al - Runs for some num_iter
%       number of iterations before stopping

function [time, A] = algorithm3(t0, num_iter, k1, k2, n0)
% Initialize vecs
A = [n0, zeros(1, (num_iter - 1))];
time = [t0];

    for i = 1:num_iter    
        % Select rand vals
        r1 = rand(1,1);
        r2 = rand(1,1);
        
        % Calc tau
        alpha0 = A(i-1)*k1 + k2;
        tau = (1/alpha0)*log(1/r1);
         time(i) = time(i-1) + tau;

        % Calc new state
            if r2 < k2/alpha0
                A(i) = A(i-1) + 1; % Produce w prob k2/alpha0
            else
                A(i) = A(i-1) - 1; % Degrade w prob 1-k2/alpha0
            end
    end
end