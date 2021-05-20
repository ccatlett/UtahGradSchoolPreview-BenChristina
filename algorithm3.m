%% Algorithm 3

function [timespan, A] = algorithm3(t0, t_final, delta_t, k1, k2, n0)
timespan = [t0:delta_t:t_final];
A = [n0, zeros(1, (length(timespan) -1))];
time = [t0];

    for i = [2:length(timespan)]
        
        % Select rand vals
        r1 = rand(1,1);
        r2 = rand(1,1);
        
        % Calc tau
        alpha0 = A(i-1)*k1 + k2;
        tau = (1/alpha0)*log(1/r1);
         time(i) = time(i-1) + tau;

        % Calc new state
            if r2 < k2/alpha0
                A(i) = A(i-1) + 1;
            else
                A(i) = A(i-1) - 1;
            end
    end
end