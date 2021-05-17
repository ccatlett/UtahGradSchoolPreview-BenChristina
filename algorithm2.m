%%% Algorithm 2
%% Initial Parameters
function [time, A] = algorithm2(t0,k, n0)
A = [n0];
time = [t0];

while (A(end) > 0)
    r = rand(1,1);
    tau = (1/(A(end)*k))*log(1/r);
    time_next = time(end) + tau;
    A_next = A(end) - 1;
    A = [A, A_next];
    time = [time, time_next];
    
end

end
