% Su + Iu -> 2Iu
% Su + Iv -> 2Iu
% Su -> Sv
% Sv + Iu -> 2Iv
% Sv + Iv -> 2Iv
% Iu -> R
% Iu -> M
% Iv -> R
% Iv -> M

% params = [.1, .5, .3, .7, .2, .85, .1]
% init_conds = [99, 0, 1, 0, 0, 0];
% num_iter = 200;

function [time_out, out] = stochSIRVM(t0, num_iter, init_conds, params)
    % Order: Su, Sv, Iu, Iv, R, M
    out = [init_conds.', zeros(6, num_iter-1)];
    time_out = t0;
    
    for i = 2:num_iter
        
        rr = rand(1,2);
        
        beta = params(1);
        lambda = params(2);
        q = params(3);
        gamma_u = params(4);
        mu_u = params(5);
        gamma_v = params(6);
        mu_v = params(7);
      
        SuIu_pr = beta*out(1, i-1)*out(3, i-1);          
        SuIv_pr = lambda*beta*out(1, i-1)*out(4, i-1);   
        SuSv_pr = q*out(1, i-1)*(1-out(1, i-1)/init_conds(1));                         
        SvIu_pr = lambda*beta*out(2, i-1)*out(3, i-1);   
        SvIv_pr = lambda^2*beta*out(2, i-1)*out(4, i-1); 
        IuR_pr = gamma_u*out(3, i-1);                    
        IuM_pr = mu_u*out(3, i-1);                       
        IvR_pr = gamma_v*out(4, i-1);                    
        IvM_pr = mu_v*out(4, i-1); 
        
        SuI =  [-1;0;1;0;0;0]; % Su + Iu -> 2Iu, Su + Iv -> 2Iu
        SuSv = [-1;1;0;0;0;0]; % Su -> Sv
        SvI =  [0;-1;0;1;0;0]; % Sv + Iv -> 2Iv, Sv + Iu -> 2Iv
        IuR =  [0;0;-1;0;1;0]; % Iu -> R
        IuM =  [0;0;-1;0;0;1]; % Iu -> M
        IvR =  [0;0;0;-1;1;0]; % Iu -> R
        IvM =  [0;0;0;-1;0;1]; % Iu -> M
        

        props = [SuIu_pr, SuIv_pr, SuSv_pr, SvIu_pr, SvIv_pr, IuR_pr, ...
            IuM_pr, IvR_pr, IvM_pr];
        reactions = [SuI, SuI, SuSv, SvI, SvI, IuR, IuM, IvR, IvM];
        
        ind2remove = [];
        % Su0
        if out(1, i-1) == 0
           ind2remove = [1,2,3];
        end
        % Sv=0
        if out(2, i-1) == 0
           ind2remove = [ind2remove, 4, 5];
        end
        % Iu=0
        if out(3, i-1) == 0
            ind2remove = [ind2remove, 6, 7];
        end
        % Iv=0
        if out(4, i-1) == 0
            ind2remove = [ind2remove, 8, 9];
        end
                  
       % Remove impossible events
       props(ind2remove) = [];
       reactions(:, ind2remove) = [];
       
       % Calculate timestep tau
       alpha0 = sum(props);
       tau = (1/alpha0)*log(1/rr(1));
       time_out(end+1) = time_out(i-1) + tau;
       
       % Chosen reaction
       chosen_reac = reactions(:, find(rr(2)<cumsum(props)/alpha0, 1, 'first'));
       
       % Apply reaction
       out(:, i) = out(:, i-1) + chosen_reac;        
    end
end