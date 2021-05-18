function A = algorithm1(t0, t_final, delta_t, k, n0) 
    timespan = t0:delta_t:t_final;
    A = [n0, zeros(1, (length(timespan) -1))];
    
    for i = [2:length(timespan)]
        r = rand(1,1);
        if r < (A(i-1)*k*delta_t)
            A(i) = A(i-1) - 1;
        else
            A(i) = A(i-1);
        end
    end
end