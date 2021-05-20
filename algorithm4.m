% Gillespie Algorithm for reactions:
%   A + A -> 0 (via param k1)
%   A + B -> 0 (via param k2)
%   0 -> A     (via param k3)
%   0 -> B     (via param k4)
% Author(s): Ben & Christina
% Date: 5/18/21
% Desc: Implementation of Alg 4 from Erban et al - Runs for some num_iter
%       number of iterations before stopping

function [time, A, B] = algorithm4(t0, t_final, delta_t, k1, k2, k3, k4, n0, m0) 
% Initialize vecs
timespan = t0:delta_t:t_final;
A = [n0, zeros(1, (length(timespan) -1))];
B = [m0, zeros(1, (length(timespan) -1))];
time = [t0];

    for i = [2:length(timespan)]
    % Gen 2 random dist numbers 
    r1 = rand(1,1);
    r2 = rand(1,1);

    % Calc alpha
    alpha1 = A(i-1)*(A(i-1)-1)*k1;
    alpha2 = A(i-1)*B(i-1)*k2;
    alpha3 = k3;
    alpha4 = k4;
    alpha0 = alpha1 + alpha2 + alpha3 + alpha4;

    % Calc tau
    tau = (1/alpha0)*log(1/r1);
    time(i) = time(i-1) + tau ;
        % Determine reaction w/ probability
        if r2 >= 0 && r2 < (alpha1/alpha0)
            A(i) = A(i-1) - 2;
            B(i) = B(i-1);
        elseif r2 >= (alpha1/alpha0) && r2 < (alpha1 + alpha2)/alpha0
            A(i) = A(i-1) - 1;
            B(i) = B(i-1) -1;
        elseif r2 >= (alpha1 + alpha2)/alpha0 && r2 < (alpha1 + alpha2 + alpha3)/alpha0 
            A(i) = A(i-1) + 1;
            B(i) = B(i-1);
        elseif r2 >= (alpha1 + alpha2 + alpha3)/alpha0 && r2 < 1
            A(i) = A(i-1);
            B(i) = B(i-1) + 1;
        end
    end
end
