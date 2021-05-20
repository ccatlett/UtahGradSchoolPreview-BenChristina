
% Solve ODE over 300 sec
tspan = [0 10];
S_u_i = 999;
S_v_i = 0;
I_u_i = 1;
I_v_i = 0;
R_i = 0;
M_i = 0;
init_conds = [S_u_i; S_v_i; I_u_i; I_v_i; R_i; M_i];
[t, ode_out] = ode45(@(m,y) vax_sys(m, y), tspan, init_conds);

function vec_out = vax_sys(t_in, vec_in)
r =.7;
N = 1000;
lambda = .5;
beta = .1;
gamma_u = .6;
gamma_v = .95;
mu_u = .01;
mu_v = .005;

S_u = vec_in(1);
S_v = vec_in(2);
I_u = vec_in(3);
I_v = vec_in(4);
R = vec_in(5);
M = vec_in(6);

dS_u = -beta*(I_u + I_v)*S_u - r*S_u*(1-S_u/N);
dS_v = r*S_u*(1-S_u/N)-lambda*beta*(I_u + lambda*I_v)*S_v;
dI_u = beta*(I_u + I_v)*S_u-(gamma_u + mu_u)*I_u;
dI_v = lambda*beta*(I_u + lambda*I_v)*S_v-(gamma_v + mu_v)*I_v;
dR = gamma_u*I_u+gamma_v*I_v;
dM = mu_u*I_u+mu_v*I_v;

vec_out = [dS_u; dS_v; dI_u; dI_v; dR; dM];
end

