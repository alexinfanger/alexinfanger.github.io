---
layout: post
title: Pointwise Stationary Approximation
permalink: /research/pointwise_stationary_approximation
---


We measure how well the Pointwise Stationary Approximation (PSA) serves for computing performance measures on Markov chains by comparing it to solutions computed with ODE-based methods that account for the non-stationarity in the model. We begin by looking at the US Bank Callcenter model. 

## US Bank Callcenter Model


The US Bank Callcenter model is an $$M(t)/M(t)/N(t)$$ queue where the arrival rate $$\lambda(t)$$, the service rate $$\mu(t)$$, and the number of servers $$s(t)$$ are piecewise linear, piecewise constant, and piecewise constant, over an hourly partition, respectively. We show $$\lambda(t)$$, the service completions $$\mu(t)s(t)$$, and $$s(t)$$ on a double axis plot in Figure 1 below.

&nbsp;

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/US_Bank_model.svg)
&nbsp;

There is an abandonment rate of 0.134 1/min (that is, customers have a patience of approximately 7.5 minutes). We use a finite waiting room approximation to the infinite waiting room model. That is we pick a state space. We find that the choice $$\mathcal{S}=\{0,1....,S\}$$ with $$S=470$$ is sufficient.



We start by computing the non-stationary time evolution versus the stationary time evolution of the measures. For the NS model, we assume that we start at time 0 at the stationary distribution of Q(0), so that the methods coincide at time 0. 


<img src="/files/Research/Pointwise_Stationary_Approximation/figures/measures.gif" />

Below we show the TV error as a function of time between PSA and NS.

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/TV_error.svg)

In the following, we compute some performance measures. In particular, we plot the probability-of-waiting, expected number waiting, and mean waiting time. The probability of waiting corresponds to the reward function

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


### Probability of Wait
![svg](/files/Research/Pointwise_Stationary_Approximation/figures/prob_wait_values.svg)

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/prob_wait_abs_err.svg)

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/prob_wait_rel_err.svg)

### Expected Waiting Time

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/exp_wait_values.svg)

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/exp_wait_abs_err.svg)

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/exp_wait_rel_err.svg)




<!-- 
# Fast Rise Time

We now investigate the discrepancy of PSA and NS when $$\lambda(t)$$ increases the fastest for varying choices of constant $$s(t)=s$$. From the US Callcenter data, we see that during the period of fastest increase, $$\lambda(t)$$ ranges from approximately $$~50/6 = 8.3$$ to $$100$$ from time $$t=420$$ to $$t=600$$. (This can be confirmed in Figure 1 above.) In other words, in the span of three hours, $$\lambda(t)$$ increases by about 90. 

Here we consider only the ramp up period going from $$\lambda=10$$ to $$\lambda =100$$ in 180 minutes. We keep $$\mu=1/3$$ and keep the number of servers stationary so that $$\rho_{\max} = \rho(180)$$ varies in $$\{.8,.9,1.1\}$$. 







![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_segment.svg)



### $$\rho=0.8$$ 

![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_prob_values_.8.svg)
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_prob_rel_error_.8.svg)


![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_exp_wait_values_.8.svg)
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_exp_wait_rel_error_.8.svg)


### $$\rho=0.99$$ 
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_prob_values_.99.svg)
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_prob_rel_error_.99.svg)


![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_exp_wait_values_.99.svg)
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_exp_wait_rel_error_.99.svg)




### $$\rho=1.1$$ 
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_prob_values_1.1.svg)
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_prob_rel_error_1.1.svg)


![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_exp_wait_values_1.1.svg)
![svg](/files/Research/Pointwise_Stationary_Approximation/fast_rise_exp_wait_rel_error_1.1.svg)

 -->

##  Citi Bike Model

Here we examine a model of one bike station estimated from data from the Grove Street Path bike station in New York City. We use a simple hourly linear interpolation for the birth and death rates of bikes at the station.

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/citi_bike_model.svg)


