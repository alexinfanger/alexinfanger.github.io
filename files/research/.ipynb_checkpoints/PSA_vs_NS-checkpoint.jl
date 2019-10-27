using LinearAlgebra
using SparseArrays
using DifferentialEquations
using Statistics
using Sundials
using DataStructures
using Plots
using Plots.PlotMeasures
include("MC_functions.jl")


model_name = "US_Bank_Callcenter"
p = Dict("forwards" => true)
S = 470
t = 1440.0
u_0 = bd_stat(US_Bank_Q(0))
prob = ODEProblem(US_Bank_dudt, u_0, (0.0, 1440.0),p)
sol = solve(prob, CVODE_BDF(), reltol=1e-14, abstol=1e-14, saveat=5.0)

NS_perf_mes = zeros(288)
rhos = zeros(288)
lzs = zeros(288)
for i in range(1,stop=288)
    if ~ is_stochastic_vector(sol[i])
        sol[i][sol[i].<0].=0
        if ~ is_stochastic_vector(sol[i])
            print("Not stochastic after shift.")
        end
    end
    NS_perf_mes[i] = sol[i]' * US_Bank_Number_Waiting_r(sol.t[i])
    rhos[i] = US_Bank_Lambda(sol.t[i])/(1/3*US_Bank_Servers(sol.t[i]))
    lzs[i] = US_Bank_Lambda(sol.t[i])
end

perf_mes = zeros(288)
for i in range(1,stop=288)
    # perf_mes[i] = get_stat_dist_Q(US_Bank_Q(sol.t[i]))' * US_Bank_Number_Waiting_r(sol.t[i])
    print(i)
    perf_mes[i] = bd_stat_mode(US_Bank_Q(sol.t[i]))' * US_Bank_Number_Waiting_r(sol.t[i])
end

rel_error = (perf_mes.-NS_perf_mes)./NS_perf_mes

plot(sol.t[1:288], rel_error,
    title="PSA versus NS Relative Error", legend=:topleft,
    label="Abs (PSA-NS)/NS", xlabel="Time (Minutes)",
    ylabel="Abs (PSA-NS)/NS",right_margin=20mm)
plot!(NaN.*[1:288], label="rho(t)", grid=false,
    legend=:topleft,linecolor=:green)
plot!(twinx(), sol.t[1:288], rhos, label="rho(t)", legend=false,linecolor=:green, ylabel="rho(t)")
savefig(string(model_name,"PSA_vs_NS_relative_error_USBank.png"))


plot(sol.t[1:288], perf_mes, title="PSA and NSA Actual",
    label="PSA", xlabel="Time (Minutes)",yscale =:log,
        ylabel="Expected Number Waiting",
        right_margin=20mm, legend =:topleft)
plot!(sol.t[1:288], NS_perf_mes, label="NS", xlabel="Time (Minutes)",right_margin=20mm)
plot!(NaN.*[1:288], label="rho(t)", grid=false, legend=:left,linecolor=:green)
plot!(twinx(), sol.t[1:288], rhos, label="rho(t)", legend=false,linecolor=:green, ylabel="rho(t)")
savefig(string(model_name,"PSA_vs_NS_Actual_Values"))

# Also plot the different in measures in 2-norm.


# Same thing but for a simple sin M/M/s queue
# We look at the expected delay on such a thing.

model_name = "Queue_Saturated"


p = Dict("forwards" => true, "S"=> 600, "s"=>330, "mu"=> .333)
p["sin_base"] = .8*p["mu"]*p["s"]
p["sin_rel_amp"] = .1
p["phase_shift"] = 0
p["sin_rate"] = 2*pi/1440.0

u_0 = get_stat_dist_Q(Finite_Server_Q(0,p))
prob = ODEProblem(Finite_Server_dudt, u_0, (0.0, 1440.0),p)
sol = solve(prob, CVODE_BDF(), reltol=1e-12, abstol=1e-12, saveat=5.0)

NS_perf_mes = zeros(288)
rhos = zeros(288)
for i in range(1,stop=288)
    if ~ is_stochastic_vector(sol[i])
        sol[i][sol[i].<0].=0
        if ~ is_stochastic_vector(sol[i])
            print("Not stochastic after shift.")
        end
    end
    NS_perf_mes[i] = sol[i]' * Finite_Server_Number_Waiting_r(p)
    rhos[i] = lambda_func(sol.t[i], p)/(p["mu"]*p["s"])
end

perf_mes = zeros(288)
for i in range(1,stop=288)
    perf_mes[i] = (bd_stat(Finite_Server_Q(sol.t[i],p)))' * Finite_Server_Number_Waiting_r(p)
end

rel_error = (perf_mes.-NS_perf_mes)./NS_perf_mes

plot(sol.t[1:288], rel_error, title="PSA versus NS Relative Error", label="(PSA-NS)/NS",
        xlabel="Time (Minutes)", ylabel="(PSA-NS)/NS",right_margin=20mm)
plot!(NaN.*[1:288], label="rho(t)", grid=false, legend=:left,linecolor=:green)
plot!(twinx(), sol.t[1:288], rhos, label="rho(t)", legend=false,linecolor=:green, ylabel="rho(t)")
savefig(string(model_name,"PSA_vs_NS_relative_error_large_rho_USBankLevel.png"))


plot(sol.t[1:288], perf_mes, title="PSA and NS Actual",
 label="PSA", xlabel="Time (Minutes)", ylabel="Expected Number Waiting",
 right_margin=20mm)
plot!(sol.t[1:288], NS_perf_mes, label="NS")
plot!(NaN.*[1:288], label="rho(t)", grid=false,
    legend=:topleft, linecolor=:green)
plot!(twinx(), sol.t[1:288], rhos,
        label="rho(t)", legend=false,linecolor=:green, ylabel="rho(t)")
savefig(string(model_name,"PSA_vs_NS_Actual_Values_large_rho_USBankLevel.png"))
