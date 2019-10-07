---
layout: post
title: Pointwise Stationary Approximation
permalink: /research/pointwise_stationary_approximation
---


We measure how well the Pointwise Stationary Approximation (PSA) serves for computing performance measures on Markov chains by comparing it to solutions computed with ODE-based methods that account for the non-stationarity in the model. We begin by looking at the US Bank Callcenter model. 

## US Bank Callcenter Model


The US Bank Callcenter model is an $$M(t)/M/N(t)$$ queue where the birth-rate $$\lambda(t)$$ and the number of servers $$s(t)$$ are piecewise linear and piecewise constant, over the same partition, respectively. Furthemore, $$N(t)$$ follows a square-root staffing model: if the average value of $$\lambda(t)$$ over segment $$i$$ is $$\lambda_i$$, then $$s(t)=s_i$$ on that segment with


<p>
$$
s_i  = \frac{\lambda_i}{\mu} + 3\sqrt{\frac{\lambda_i}{\mu}}.
$$
</p>

We show $$\lambda(t)$$ and $$s(t)$$ on a double axis plot in Figure 1 below.

![svg](/files/Research/Pointwise_Stationary_Approximation/lambda.svg)



Observe that during maximum load, we have that $$\frac{\lambda(t)}{\mu}\approx 300$$ and hence, we choose a waiting room of size $$ S =300 + 10\sqrt{300}\approx 470$$. In other words, the state space is $$\mathcal{S} = \\{0,1,...,470\\}$$.



We start by computing the non-stationary time evolution versus the stationary time evolution of the measures. For the NS model, we assume that we start at time 0 at the stationary distribution of Q(0), so that the methods coincide at time 0. 

In the following cell we compute some performance measures. In particular, we plot the probability-of-waiting, expected number waiting, and mean waiting time. The probability of waiting corresponds to the reward function

<p>
$$
r(x) = I(x>s(t)).
$$
</p>

The expected number waiting corresponds to
<p>
$$
r(x) = [x-s(t)]^+.
$$
</p>

The mean waiting time corresponds to

<p>
$$
r(x) = \frac{[x-s(t)]^+}{\mu}.
$$
</p>




<img src="/files/Research/Pointwise_Stationary_Approximation/US_Bank.gif" />



# Fast Rise Time

We now investigate the discrepancy of PSA and NS when $$\lambda(t)$$ increases the fastest for varying choices of constant $$s(t)=s$$. From the US Callcenter data, we see that during the period of fastest increase, $$\lambda(t)$$ ranges from approximately $$~50/6 = 8.3$$ to $$100$$ from time $$t=420$$ to $$t=600$$. (This can be confirmed in Figure 1 above.) In other words, in the span of three hours, $$\lambda(t)$$ increases by about 90. 

Here we consider only the ramp up period going from $$\lambda=10$$ to $$\lambda =100$$ in 180 minutes. We keep $$\mu=1/3$$ and keep the number of servers stationary so that $$\rho_{\max} = \rho(180)$$ varies in $$\{.8,.9,1.1\}$$. 







![svg](/files/Research/Pointwise_Stationary_Approximation/output_11_1.svg)



### $$\rho=0.8$$ 
<img src="/files/Research/Pointwise_Stationary_Approximation/rho_0.8.gif" />



### $$\rho=0.99$$ 
<img src="/files/Research/Pointwise_Stationary_Approximation/rho_.99.gif" />




### $$\rho=1.1$$ 
<img src="/files/Research/Pointwise_Stationary_Approximation/rho_1.1.gif" />


