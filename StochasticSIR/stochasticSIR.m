% Stochastic SIR model w Gillespie Algorithm:
%   S + I -> 2I (via param k1)
%   I -> 0      (via param k2)
% Author(s): Ben & Christina
% Date: 5/19/21
% Desc: Implementation of simple SIR model with SSA for num_iter iterations

function [time, S, I] = stochasticSIR(t0, num_iter, k1, k2, n0, m0)
S = [n0, zeros(1, (num_iter - 1))];
I = [m0, zeros(1, (num_iter - 1))];
time = [t0];

    for i = 2:num_iter
        % Generate 2 randomly distributed numbers 
        r1 = rand(1,1);
        r2 = rand(1,1);

        % Calc alpha
        alpha1 = S(i-1)*I(i-1)*k1;
        alpha2 = I(i-1)*k2;
        alpha0 = alpha1 + alpha2;

        % Calc timestep
        tau = (1/alpha0)*log(1/r1);
        time(i) = time(i-1) + tau;

            % Safety net: pop > 0
            if I(i-1) ==0
                    S(i) = S(i-1);
                    I(i) = 0;
            % S + I -> 2I
            elseif r2 < alpha1/alpha0 
               S(i) = S(i-1) - 1;
               I(i) = I(i-1) + 1;
            % I -> 0
            else
                 S(i) = S(i-1);
                 I(i) = I(i-1) - 1;         
            end
    end
end
