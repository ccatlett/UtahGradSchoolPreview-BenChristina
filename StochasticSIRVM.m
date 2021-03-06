%% Stochastic SIRVM 
%% Su, Sv, Iu, Iv, R, M
%% Su + Iu -> 2Iu
%% Su + Iv -> Iv + Iu
%% Sv + Iu -> Iv + Iu
%% Sv + Iv -> 2Iv
%% Iu -> M
%% Iu -> R
%% Iv -> M
%% Iv -> R
%% Parameter initialization

function [time, Su, Sv, Iu, Iv, R, M] = StochasticSIRVM(t0, num_iter, k1, k2, k3, k4, k5, k6, k7, k8, n0, m0, p0)
Su = [n0, zeros(1, (num_iter - 1))];
Sv = [n0, zeros(1, (num_iter - 1))];
Iu = [m0, zeros(1, (num_iter - 1))];
Iv = [m0, zeros(1, (num_iter - 1))];
R = [p0, zeros(1, (num_iter - 1))];
M = [p0, zeros(1, (num_iter - 1))];
time = [t0];

   for i = [2:num_iter]
        %% Generate 2 randomly distributed numbers 
        r1 = rand(1,1);
        r2 = rand(1,1);

        %% Calculate alpha
        alpha1 = Su(i-1)*Iu(i-1)*k1;
        alpha2 = Su(i-1)*Iv(i-1)*k2;
        alpha3 = Sv(i-1)*Iu(i-1)*k3;
        alpha4 = Sv(i-1)*Iv(i-1)*k4;
        alpha5 = Iu(i-1)*k5;
        alpha6 = Iu(i-1)*k6;
        alpha7 = Iv(i-1)*k7;
        alpha8 = Iv(i-1)*k8;
        alpha0 = alpha1 + alpha2 + alpha3 + alpha4 + alpha5 + alpha6 + alpha7 + alpha8;

        %% Calculate timestep
        tau = (1/alpha0)*log(1/r1);
        time(i) = time(i-1) + tau;

            %% Safety net
            %if I(i-1) ==0
                    %S(i) = S(i-1);
                   % I(i) = 0;
                   % R(i) = R(i-1);
             %% Su + Iu -> 2Iu     
            if r2 < alpha1/alpha0 
               Su(i) = Su(i-1) - 1;
               Iu(i) = Iu(i-1) + 1; 
               Iv(i) = Iv(i-1);
               Sv(i) = Sv(i-1);
               M(i) = M(i-1);
               R(i) = R(i-1);
             %% Su + Iv -> Iv + Iu
            elseif r2 >= (alpha1/alpha0) && r2 < (alpha1 + alpha2)/alpha0
                 Su(i) = Su(i-1) - 1;
                 Iu(i) = Iu(i-1) + 1;
                 Iv(i) = Iv(i-1);
                 Sv(i) = Sv(i-1);
                 M(i) = M(i-1);
                 R(i) = R(i-1); 
             %% Sv + Iu -> Iv + Iu
            elseif r2 >= (alpha1 + alpha2)/alpha0 && r2 < (alpha1 + alpha2 + alpha3)/alpha0
                Sv(i) = Sv(i-1) - 1;
                Iv(i) = Iv(i-1) + 1;
                Iu(i) = Iu(i-1);
                Su(i) = Su(i-1);
                M(i) = M(i-1);
                R(i) = R(i-1);
             %% Sv + Iv -> 2Iv
            elseif r2 >= (alpha1 + alpha2 + alpha3)/alpha0 && r2 < (alpha1 + alpha2 + alpha3 + alpha4)/alpha0
                Sv(i) = Sv(i-1) - 1;
                Iv(i) = Iv(i-1) + 1;
                Iu(i) = Iu(i-1);
                Su(i) = Su(i-1);
                M(i) = M(i-1);
                R(i) = R(i-1);
             %% Iu -> M   
            elseif r2 >= (alpha1 + alpha2 + alpha3 + alpha4)/alpha0 && r2 < (alpha1 + alpha2 + alpha3 + alpha4 + alpha5)/alpha0
                Iu(i) = Iu(i-1) - 1;
                M(i) = M(i-1) + 1;
                Iv(i) = Iv(i-1);
                Sv(i) = Sv(i-1);
                Su(i) = Su(i-1);
                R(i) = R(i-1);
              %% Iu -> R 
            elseif r2 >= (alpha1 + alpha2 + alpha3 + alpha4 + alpha5)/alpha0 && r2 < (alpha1 + alpha2 + alpha3 + alpha4 + alpha5 + alpha6)/alpha0
                Iu(i) = Iu(i-1) - 1;
                R(i) = R(i-1) + 1;
                Iv(i) = Iv(i-1);
                Sv(i) = Sv(i-1);
                Su(i) = Su(i-1);
                M(i) = M(i-1);
              %% Iv -> M   
            elseif r2 >= (alpha1 + alpha2 + alpha3 + alpha4 + alpha5 + alpha6)/alpha0 && r2 < (alpha1 + alpha2 + alpha3 + alpha4 + alpha5 + alpha6 + alpha7)/alpha0
                Iv(i) = Iv(i-1) - 1;
                M(i) = M(i-1) + 1;
                Iu(i) = Iu(i-1);
                Sv(i) = Sv(i-1);
                Su(i) = Su(i-1);
                R(i) = R(i-1);
              %% Iv -> R
            else 
                Iv(i) = Iv(i-1) - 1;
                R(i) = R(i-1) + 1;
                Iu(i) = Iu(i-1);
                Sv(i) = Sv(i-1);
                Su(i) = Su(i-1);
                M(i) = M(i-1);     
            end
    end
end
