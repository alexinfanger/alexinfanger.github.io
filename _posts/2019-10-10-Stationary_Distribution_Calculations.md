---
layout: post
title: Stationary Distribution Calculations 
permalink: /research/stationary_distribution_calculations
---

In this notebook, we compare stationary distribution calculators on two models: (1) an approximation to the infinite server queue, and (2) the US Bank Callcenter model. We show that all methods converge and produce equivalent results. We consider five different methods, outlined below.

#### 1. Birth death 

The birth death method sets $$\pi(0)=1$$ and computes

$$
\begin{align}
\pi(i+1) = \frac{\lambda(i)}{\mu(i+1)} \pi(i).
\end{align}
$$

for $$i=\{0,1...S-1\}$$. And then normalizes $$\pi$$ to sum to one. 


&nbsp;
#### 2. Birth death starting at mode

This method assumes the stationary distribution has a single mode. It computes the mode by finding the first index $$i$$ wherein $$\lambda(i)/\mu(i+1)<1$$ and chooses $$i$$ to be the mode. Call this mode $$i^*$$. Then it sets $$\pi(i^*)=1$$ and recursively computes

$$
\pi(i+1) = \frac{\lambda(i)}{\mu(i+1)} \pi(i)
$$

for $$i=i^*,i^*+1,...S-1$$. And then recursively computes

$$
\pi(i-1) = \frac{\mu(i)}{\lambda(i-1)} \pi(i)
$$

for $$i=i^*, i^*-1, ... 1$$.


&nbsp;
#### 3. Birth death (log-exp)

This sets $$\ell(0)=log(\pi(0))=0$$ and then recursively computes

$$
\begin{align}
\ell(i+1)=  \log(\lambda(i))-\log(\mu(i+1))+\ell(i).
\end{align}
$$

and then exponentiates elementwise to compute $$\pi = \exp.(\ell)$$ and normalizes $$\pi$$ to sum to one. 


&nbsp;
#### 4. Birth death chains starting at mode (log-exp)
This implements both the ideas in (2) and (3) at once.


&nbsp;
#### 5. Linear System Approach

Suppose $$W=Q^T$$ has block form

$$
W = \begin{pmatrix}
B & d\\
t^T & \alpha
\end{pmatrix}.
$$

We solve the system 
$$
Bw=-d.
$$
(The invertibility of $$B$$ is guaranteed by the irreducibility of $$Q$$.) Then we set $$\pi=(w,1)$$ and normalize. 


# Infinite Server Queue Approximation

We start with a small example. Let $\lambda =\mu =1$ and $s=S=10$. According to square-root staffing, this is about ten deviations out. Hence this is a good approximation to the infinite server model. We will want to see whether the stationary distribution solvers coincide to the known true distribution for the infinite server model:

Note we show the tranpose: 

    11×11 Tridiagonal{Float64,Array{Float64,1}}:
     -1.0   1.0    ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅      ⋅      ⋅ 
      1.0  -2.0   2.0    ⋅     ⋅     ⋅     ⋅     ⋅     ⋅      ⋅      ⋅ 
       ⋅    1.0  -3.0   3.0    ⋅     ⋅     ⋅     ⋅     ⋅      ⋅      ⋅ 
       ⋅     ⋅    1.0  -4.0   4.0    ⋅     ⋅     ⋅     ⋅      ⋅      ⋅ 
       ⋅     ⋅     ⋅    1.0  -5.0   5.0    ⋅     ⋅     ⋅      ⋅      ⋅ 
       ⋅     ⋅     ⋅     ⋅    1.0  -6.0   6.0    ⋅     ⋅      ⋅      ⋅ 
       ⋅     ⋅     ⋅     ⋅     ⋅    1.0  -7.0   7.0    ⋅      ⋅      ⋅ 
       ⋅     ⋅     ⋅     ⋅     ⋅     ⋅    1.0  -8.0   8.0     ⋅      ⋅ 
       ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅    1.0  -9.0    9.0     ⋅ 
       ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅    1.0  -10.0   10.0
       ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     ⋅     1.0  -10.0


Below we use the Poisson distribution with mean 1 as a reference to compare against our stationary distribution calculators.

```julia
ref_statdist = pdf.(Poisson(),0:1:10)

for (key, value) in dict_of_solvers
    print(key); print(":   ")
    if "stat" in keys(value)
        print(sum(abs.(value["stat"]-ref_statdist)))
        println()
    else
        print("N/A")
        println()
    end
end
```

    bd_stat         :   1.0047766378055312e-8
    bd_stat_mode    :   1.0047766378055312e-8
    bd_stat_log     :   1.0047766390489928e-8
    bd_stat_mode_log:   1.0047766390489928e-8
    linear_system   :   1.004776631414878e-8




The fact that they all differ by the infinite server approximation by the same amount to so many digits suggests that the error is dominated by the infinite server approximation. 

&nbsp;

# US Bank Callcenter Model


The US Bank Callcenter model is an $$M(t)/M(t)/N(t)$$ queue where the arrival rate $$\lambda(t)$$, the service rate $$\mu(t)$$, and the number of servers $$s(t)$$ are piecewise linear, piecewise constant, and piecewise constant, over an hourly partition, respectively. We show $$\lambda(t)$$, the service completions $$\mu(t)s(t)$$, and $$s(t)$$ on a double axis plot in Figure 1 below.

&nbsp;

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/US_Bank_model.svg)
&nbsp;

There is an abandonment rate of 0.134 1/min (that is, customers have a patience of approximately 7.5 minutes). We use a finite waiting room approximation to the infinite waiting room model. That is we pick a state space. We find that the choice $$\mathcal{S}=\{0,1....,S\}$$ with $$S=470$$ is sufficient.

The only solver which failed to converge for all times on the above movdel was the linear system based solver (5). In the following plot, we show the total variation error of the calculated stationary distributions from a reference measure. For the reference measure, we use the birth death starting at mode solver (2). 



![svg](/files/Research/Stationary_Distribution_Calculations/output_12_0.svg)



