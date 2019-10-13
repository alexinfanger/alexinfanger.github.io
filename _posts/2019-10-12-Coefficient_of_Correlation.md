---
layout: post
title: Coefficient of Correlation
permalink: /research/coefficient_of_correlation
---

In this post we consider the dependence of the Markov jump processes through time. In particular, we are interested in computing the correlation coefficient. 

$$
\rho(t;u) = \frac{EX(t)X(t+u) - EX(t)EX(t+u)}{\sigma_{X(t)}\sigma_{X(t+u)}},
$$

for $$u=1,2,..., 30$$ minutes and for $$t=1,2,...,(1440-30)$$ minutes. To compute $$\rho(t;u)$$ we will first compute the following two intermediary quantities:


1.  $$P(X(t) = x)$$ for every state $$x$$ and every $$t$$.
2.  $$E[X(t + u) \vert X(t) = x]$$ for every state $$x$$, every $$t$$, and every $$u\in\{1,2,...,30\}$$.



From 1., we can compute $$EX(t)$$ and $$EX^2(t)$$ for each $$t$$, so that we can compute $$var X(t)$$ for each $$t$$. Also, we can compute $$EX(t) X(t + u)$$ from 1. and 2) by writing it as $$\sum_{x\in\mathcal{S}} P(X(t) = x)x E[X(t + u) \vert X(t) = x]$$ . Now, we compute the correlation by subtracting off $$EX(t) * EX(t + u)$$ and normalizing by the standard deviation,

&nbsp;

$$
\rho(t;u) = \frac{\sum_{x\in\mathcal{S}} P(X(t) = x)x E[X(t + u) \vert X(t) = x] - EX(t)EX(t + u)}{\sqrt{var X(t) var X(t+u)}}.
$$


We will compute 1. by running the backwards equations from time $$s=30,31...,1440$$ back $$t'=1,2,...,30$$ time steps, with initial vector $$r(x)=x$$. We will compute 2. by running the forwards equation from time 1. We will use the stationary distribution of $$Q(0)$$ as our starting distribution. 

# US Bank Callcenter Model


The US Bank Callcenter model is an $$M(t)/M(t)/N(t)$$ queue where the arrival rate $$\lambda(t)$$, the service rate $$\mu(t)$$, and the number of servers $$s(t)$$ are piecewise linear, piecewise constant, and piecewise constant, over an hourly partition, respectively. We show $$\lambda(t)$$, the service completions $$\mu(t)s(t)$$, and $$s(t)$$ on a double axis plot in Figure 1 below.

&nbsp;

![svg](/files/Research/Pointwise_Stationary_Approximation/figures/US_Bank_model.svg)
&nbsp;

We use a finite waiting room approximation to the infinite waiting room model. That is we pick a state space. We find that the choice $$\mathcal{S}=\{0,1....,S\}$$ with $$S=470$$ is sufficient.

Below we plot the correlation coefficient for a few representative samples of $$u=10,20,30$$ on the US Bank Callcenter model.


![svg](/files/Research/Coefficient_of_Correlation/figures/correlation.svg)



