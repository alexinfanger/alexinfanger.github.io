
using LinearAlgebra
using SparseArrays
using DifferentialEquations
using Statistics

function matrix_multiplies(s)
    r = (0:1:10000)
    @time for n in 1:s
        r = test_matrix(3,.1)*r
    end
    return r
end

function lambda_func(t, p)
    base = p["sin_base"]
    rel_amp = p["sin_rel_amp"]
    rate = p["sin_rate"]
    phase_shift = p["phase_shift"]
    return base .+ base.*rel_amp.* cos.(rate*t.+phase_shift)
end


function bd_stat(Q)
    Q = Q'
    n = size(Q)[1]
    stat_dist = zeros(n)
    stat_dist[1]=1
    for i in range(2, stop=n)
        stat_dist[i] = stat_dist[i-1]*Q[i-1,i]/Q[i,i-1]
    end
    stat_dist = stat_dist./max(abs(sum(stat_dist)))
    if is_stochastic_vector(stat_dist)
        return stat_dist
    else
        print(stat_dist)
        print("NO!")
        return -1
    end    
end 

function bd_stat_mode(Q)
    Q = Q'
    n = size(Q)[1]
    births = diag(Q,1)
    deaths = diag(Q,-1)

    if size(findall(births./deaths.<1))[1]>0
        mode_index = minimum(findall(births./deaths.<1))
    else
        mode_index = n
    end
    stat_dist = zeros(n)
    stat_dist[mode_index] = 1

    for i in range(mode_index +1, stop = n)
        stat_dist[i] = stat_dist[i-1]*Q[i-1,i]/Q[i,i-1]
    end
    for i in reverse(range(1, stop=mode_index-1))
        stat_dist[i] = stat_dist[i+1]*Q[i+1,i]/Q[i,i+1]
    end
    stat_dist = stat_dist./max(abs(sum(stat_dist)))
    return stat_dist
    if is_stochastic_vector(stat_dist)
        return stat_dist
    else
        print("NO! \n")
        return -1
    end
end 

function bd_stat_log(Q)
    Q = Q'
    n = size(Q)[1]
    stat_dist = zeros(n)
    stat_dist[1]=1
    stat_dist[1] = log(stat_dist[1])
    for i in range(2, stop=n)
        stat_dist[i] = stat_dist[i-1]+log.(Q[i-1,i])-log.(Q[i,i-1])
    end
    stat_dist = exp.(stat_dist)
    stat_dist = stat_dist./max(abs(sum(stat_dist)))
    if is_stochastic_vector(stat_dist)
        return stat_dist
    else
        return -1
    end
end

function bd_stat_mode_log(Q)
    Q = Q'
    n = size(Q)[1]
    births = diag(Q,1)
    deaths = diag(Q,-1)

    if size(findall(births./deaths.<1))[1]>0
        mode_index = minimum(findall(births./deaths.<1))
    else
        mode_index = n
    end
    stat_dist = zeros(n)
    stat_dist[mode_index] = 1
    stat_dist[mode_index] = log(stat_dist[mode_index])


    for i in range(mode_index +1, stop = n)
        stat_dist[i] = stat_dist[i-1]+log.(Q[i-1,i])-log.(Q[i,i-1])
    end
    for i in reverse(range(1, stop=mode_index-1))
        stat_dist[i] = stat_dist[i+1] + log.(Q[i+1,i])-log.(Q[i,i+1])
    end
    stat_dist = exp.(stat_dist)
    stat_dist = stat_dist./max(abs(sum(stat_dist)))
    return stat_dist
    if is_stochastic_vector(stat_dist)
        return stat_dist
    else
        print("NO! \n")
        return -1
    end
end


function Finite_Server_Q(t, p)
    S = Int(p["S"])
    s = Int(p["s"])
    mu = p["mu"]
    lambd = lambda_func(t,p)
    v = collect(1:S)
    br = ones(S)*lambd
    dr = min.(v, s)*mu
    dg = zeros(S+1)
    dg[1] = -br[1]
    dg[2:end-1] = -br[2:end]-dr[1:end-1]
    dg[end] = -dr[end]
    dr = float(dr)
    Q = Tridiagonal(dr,dg,br)
    return Q'
end

function Finite_Server_dudt(mu_t,p,t)
    if p["forwards"] == true
        return Finite_Server_Q(t, p)*mu_t
    else
        return Finite_Server_Q(1440.0-t, p)'*mu_t
    end
end


function Finite_Server_Number_Waiting_r(p)
    S = Int(p["S"])
    s = Int(p["s"])
    a = zeros(s)
    b = range(0, stop=S-s)
    return vcat(a,b)
end


function Infinite_Server_closed_form(S, t, lambd, mu)
    alpha = lambd/mu * (1-exp.(-mu*t))
    a = collect(1:S)
    a = pushfirst!(a,1)
    b = cumsum(log.(a))
    r = collect(0:1.0:S)
    mu_t = exp.(-alpha .+ log.(alpha)*r .- b)
    return mu_t
end

function Infinite_Server_forward(S, t, lambd, mu, mu_0)
    prob = ODEProblem(Infinite_Server_dudt, mu_0, (0.0,t),[mu, lambd, S])
    solve(prob, reltol=1e-8,abstol=1e-8,alg_hints = "stiff")    # alg_hints = "stiff",
end

function test_function(a,b)
    if a < 1 && b==3
        c = 5
    else
        c=0
    end
    return c
end


# US Callcenter Model

US_Bank_S = 470


function US_Bank_Lambda(t)
    if isa(t,Float64) || isa(t,Int)
        return US_Bank_Lambda_single(t)
    else
        t = collect(t)
        n = size(t)[1]
        lambdas = zeros(n)
        for i in range(1, stop=n)
            lambdas[i] = US_Bank_Lambda_single(t[i])
        end
        return lambdas
    end
end


function US_Bank_Lambda_single(t)

    if t <= 5.0*60.
      x_1, y_1 = 0.0,500.0/60.
      x_2, y_2 = 5.0*60.0,400.0/60.0

    elseif t > 5.0*60.0 && t <= 7.0*60.0
      x_1, y_1 = 5.0*60.0, 400.0/60.0
      x_2, y_2 = 7.0*60.0, 500.0/60.0

    elseif t > 7.0*60 && t <= 10.0*60
      x_1, y_1 = 7.0*60.0, 500.0/60
      x_2, y_2 = 10.0*60.0, 6000.0/60

    elseif t > 10.0*60 && t <= 16.0*60
      x_1, y_1 = 10.0*60., 6000.0/60
      x_2, y_2 = 16.0*60., 4500.0/60

    elseif t > 16.0*60 && t <= 18.0*60
      x_1, y_1 = 16.0*60., 4500.0/60
      x_2, y_2 = 18.0*60., 2000.0/60.

    elseif t > 18.0*60 && t <= 24.0*60
      x_1, y_1 = 18.0*60., 2000.0/60.
      x_2, y_2 = 24.0*60., 400.0/60.

    end
    m = (y_2 - y_1) / (x_2 - x_1)
    b = y_1 - m * x_1
    return m * t + b
end

function US_Bank_Servers_single(t)
    stdev = 3
    mu = 1.0/3.0
    if t <= 5. * 60.
        lbar = mean([500. / 60.,400. / 60])
    elseif t > 5.0 * 60 && t <= 7.0 * 60
        lbar = mean([400. / 60., 500.0 / 60.])
    elseif t > 7.0 * 60 && t <= 10.0 * 60
        lbar = mean([500.0 / 60, 6000.0 / 60])
    elseif t > 10.0 * 60 && t <= 16.0 * 60
        lbar = mean([6000.0 / 60.0, 4500.0 / 60.0])
    elseif t > 16.0 * 60 && t <= 18.0 * 60
        lbar = mean([4500.0 / 60., 2000. / 60.0])
    elseif t > 18.0 * 60 && t <= 24.0 * 60
        lbar =  mean([2000.0 / 60.0, 400.0 / 60.0])
    end
    return ceil(Int,lbar / mu + stdev * sqrt(lbar / mu))
end


function US_Bank_Servers(t)
    if isa(t,Float64) || isa(t,Int)
        return US_Bank_Servers_single(t)
    else
        t = collect(t)
        n = size(t)[1]
        servers = zeros(n)
        for i in range(1, stop=n)
            servers[i] = US_Bank_Servers_single(t[i])
        end
        return servers
    end        
end

function US_Bank_Q(t)
    S = 470
    mu = 1/3.
    v = collect(1:S)
    br = ones(S)*US_Bank_Lambda(t)
    dr = min.(v, US_Bank_Servers(t)).*mu
    dg = zeros(S+1)
    dg[1] = -br[1]
    dg[2:end-1] = -br[2:end]-dr[1:end-1]
    dg[end] = -dr[end]
    dr = float(dr)
    Q = Tridiagonal(dr,dg,br)
    return Q'
end

function US_Bank_dudt(mu_t,p,t)
    if p["forwards"] == true
        return US_Bank_Q(t)*mu_t # mu, lambd
    else
        return US_Bank_Q(t)'*mu_t
    end
end

function US_Bank_forward()
    S = 470
    t = 1440
    mu_0 = zeros(S+1)
    mu_0[1] = 1
    prob = ODEProblem(US_Bank_dudt, mu_0, (0.0,t))
    solve(prob, reltol=1e-8, abstol=1e-8, alg_hints = "stiff")    # alg_hints = "stiff",
end

function is_Rate_Matrix(Q)
    if maximum(abs.(sum(Q, dims=2)))<1e-12 && all(diag(Q).<=0) && all(Q-Diagonal(diag(Q)).>=0)
        return true
    else
        return false
    end
end


function US_Bank_Forward_Euler(mu_0, t_f)
    h_sum = 0.0
    t = 0
    while(h_sum <= t_f)
        Qt = US_Bank_Q(t)
        h = 1/unif_param(Qt)
        mu_0 = mu_0 + (h/2.0)*Qt*mu_0
        h_sum += h
    end
    return mu_0, h_sum
end


function US_Bank_Number_Waiting_r(t)
    S = 470
    a = zeros(US_Bank_Servers(t))
    b = range(0, stop=S-US_Bank_Servers(t))
    return vcat(a,b)
end



function unif_param(Q)
    return maximum(abs.(diag(Q)))
end

function US_Bank_Backward_Euler(mu_0, t_f)
    h_sum = 0.0
    t = 0
    while(h_sum <= t_f)
        Qt = US_Bank_Q(t)
        h = 1/unif_param(Qt)
        mu_0 = mu_0 + (h/2.0)*Qt*mu_0
        h_sum += h
    end
    return mu_0, h_sum
end

function get_stat_dist_Q(Q)
    # ADD PETER WAY
    # if typeof(Q)== Tridiagonal{Float64,Array{Float64,1}}:
    #
    #
    # else
    n = size(Q)[1]
    B = Q[1:n-1, 1:n-1]
    d = Array{Float64,1}(Q[1:n-1,n])
    piv = B \ (-1*d)
    piv = vcat(piv,1)
    piv = piv/sum(piv)
    if ~ is_stochastic_vector(piv)
        piv[piv.<0] .= 0
        if is_stochastic_vector(piv)
            return piv
        else
            print("not stochastic after shift")
            return false
        end
    end
    return piv
end

function is_stochastic_matrix(P)
    truth = true
    if any(abs.(sum(P,dims=2).-1).>1e-7)
        truth = false
    elseif any(P.<0)
        truth = false
    elseif any(isnan.(P))
        truth = false
    elseif any(isinf.(P))
        truth = false
    end
    return truth
end

function is_stochastic_vector(piv)
    truth = true
    if abs(sum(piv)-1)>1e-8
        truth = false
    elseif ~all(piv.>=0)
        truth = false
    elseif any(isnan.(piv))
        truth = false
    elseif any(isinf.(piv))
        truth = false
    end
    return truth
end

function e_i(i,n)
    vec = zeros(n)
    vec[i]=1
    return vec
end

# Currently implemented for solution matrices
function tau(sol)
    return (maximum(sol,dims=1)-minimum(sol, dims=1))
end


function S_Selector(rho_max, eps=1e-8)
    S=50
    while((1-rho_max)*(rho_max^S)>eps)
        S = S+1
    end
    return S
end


function generate_primatives(chain_dict)
    if p["type"] == "sinusoidal"
        rho_max = chain_dict["rho_bar"] *  (1 + chain_dict["sin_rel_amp"])
        chain_dict["S"] = S_Selector(rho_max)
        chain_dict["sin_base"] = chain_dict["s"]*chain_dict["mu"]*chain_dict["rho_bar"]
        if chain_dict["sin_type"] == "rev-up"
            chain_dict["phase_shift"] = pi
            chain_dict["sin_rate"] = (1*pi)/1440.0
            print("dude")
        elseif chain_dict["sin_type"] == "Linda_Green"
            chain_dict["phase_shift"] = 0
            chain_dict["sin_rate"] = (2*pi)/1440.0
        elseif chain_dict["sin_type"] == "rev-up-four-times"
            chain_dict["phase_shift"] = pi
            chain_dict["sin_rate"] = (8*pi)/1440.0
        end
    end
    return chain_dict
end


# reward functions

function prob_of_wait_r(S, num_servers)
    a = zeros(num_servers+1)
    b = ones(S-num_servers)
    return vcat(a,b)        
end

function number_waiting_r(S, num_servers)
    a = zeros(num_servers)
    b = range(0, stop=S-num_servers)
    return vcat(a,b)
end
