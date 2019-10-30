---
layout: post
title: How Staffing is Done in Practice
permalink: /literature/callcenter
---


## Call Centers

As [(Hur et al., 2009)](https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1937-5956.2004.tb00221.x) point out, staffing call centers can be thought of as a three stage process:

1. __Forecasting__. First, managers forecast the amount of agents they will need based on predicted demand, performance metrics, and sometimes economic optimization. The staffing requirements are typically set in half-hour or hourly intervals. 

2.  __Matching__. Second, managers match full-time and/or part-time workers to those half-hour and hourly intervals. They have to do that in a way that respects the workers shifts. This is typically solved with integer programming.

3.  __Real-Time Adjustments__. Third, managers make real-time adjustments to the schedules.



### Forecasting

Forecasts generally go out __one to three weeks__ in advance. [(Aksin et al. 2007)](https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1937-5956.2007.tb00288.x) say that "resource deployment decisions are typically made 1 or more weeks in advance of when the calls actually arrive... as new data [becomes available] for a given day or week, [staffers modify] both the near-term call arrival forecasts and the agent schedules that drive them." 


This is confirmed in a few case studies that I found. At the call centers run by *L.L.Bean* managers plan out __three weeks__ in advance [(Andrews et al. 1995)](https://pubsonline.informs.org/doi/pdf/10.1287/inte.25.6.1). At the Indiana Police Department, they used 28-day work cycles, which implies a __four week__ forecast on staffing needs [(Mabert 1983)](https://www.tandfonline.com/doi/pdf/10.1080/05695558308974653?casa_token=LVaq-oAoEWAAAAAA:k3VHXwDeqMquMMB0uUvWS9K85hpNHKLm1EodKO5Qt-MshFpGfo580gJjDSN1zYQCBGQRy5HFjplmOg). The *New Brunswick Telephone Company* uses a __two-week forecast__ [(Thompson 1997)](https://pubsonline.informs.org/doi/pdf/10.1287/inte.27.4.1).


The granularity for forecasted staffing requirements is typically in __half hour or one-hour intervals__. For *L.L.Bean*, the staffing requirements are made on a __half hourly__ basis [(Andrews et al. 1993)](https://pubsonline.informs.org/doi/pdf/10.1287/inte.23.2.14). The Indiana Police Department used __one hour__ intervals [(Mabert 1983)](https://www.tandfonline.com/doi/pdf/10.1080/05695558308974653?casa_token=LVaq-oAoEWAAAAAA:k3VHXwDeqMquMMB0uUvWS9K85hpNHKLm1EodKO5Qt-MshFpGfo580gJjDSN1zYQCBGQRy5HFjplmOg). See Figure 1.

![png](/files/literature/Empirical_Analyses_of_Call_Centers/figures/Mabert_Indiana_Police_Table.png)



<!-- [In one such paper](https://pubsonline.informs.org/doi/pdf/10.1287/inte.25.6.1), they report,

> "Schedulers \[use models\] to predict daily call volumes for the next three weeks so that they can create week-long staffing schedules... the real focus is on the third week ahead... every Monday, on the first day of the 21-day planning horizon, the \[schedulers\] each load seven forecasts of daily call volumes for Monday the (15th day) through Sunday (the 21st day) into their automated staff scheduling system. This allows them to post agent work schedules for work weeks two weeks in advance."
>  -->


<!-- > "Managers need to (1) forecast the work load for the telemarketing center on a half-hourly basis, (2) translate the work load into capacity requirements, and (3) genereate week-long staffing schedules for part-time and full-time telephone agents to meet the capacity requirements."
>  -->

<!-- They go on to say,

>Prior to this study , L.L. Bean used the traditional way of determining the target number of telephone agents on duty, \[ which is to maintain a pset so that not more than 15 percent of the calls wait more than 20 seconds before reaching an operator. -->



<!-- Mabert also has work with "Chemical Bank" and "PSI" Energy's call center. Some of these are unpublished, but we might reach out if we want to get a sense of how those were done.
 -->


## Matching

Not included.
<!-- Another example is Thompson's [work with the New Brunswick Telephone Company](https://pubsonline.informs.org/doi/pdf/10.1287/inte.27.4.1). In this system, employees bid for shifts and mention when they cannot work, and then a matching algorithm based on seniority finds a solution to the allocation problem. Here is a table showing the shift schedules that need to be allocated to staffers based on preferences.  -->

<!-- ![png](/files/literature/Empirical_Analyses_of_Call_Centers/figures/Thompson_Shift.png) -->


<!-- 
Walker summarizes Rand's contributions to blah. -->


## Real Time Adjustments

Real-time adjustments play a big role in call center staffing. [(Mehotra et al., 2010)](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1937-5956.2009.01097.x) say "recent empirical research estimates that over 70% of callcenters routinely make real-time schedule adjustments, with these decisions based largely on experience and intuition."


What kinds of adjustments are done exactly? [(Hur et al., 2009)](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1937-5956.2004.tb00221.x) give some examples in Table 1 below. All of these are commonly used in practice.


![png](/files/literature/Empirical_Analyses_of_Call_Centers/figures/Real_Time_Adj.png)



# Piecewise constant versus piecewise linear

Brown et al 2005.

<!-- ## Police Dispatch 
[The San Fracisco Police Department](https://pubsonline.informs.org/doi/pdf/10.1287/inte.19.1.4) forecasts hourly needs and schedules patrol officers. The forecasts are made based on historical calls for service, consumed times by call type, management policy on percent of time officers should spend answering calls, percent of each call type requireing two or more police officers, and percent of cars allocated two officers. But you don't hire police officers on an hourly basis, but work with shifts:

> Many departments use three shifts with different numbers of officers beginning their week each day of the week. Many departments include overlay or power shifts in addition to the basic three.
> 

Part of the staffing problem is that police officers either use a four-day, ten-hour or five-day, eight-hour shift schedule. Deciding which of these is better for hitting optimal staffing numbers was a problem of this paper: and the researchers showed the 4/10 schedule to be preferred.
 -->



<!-- 
Gary Thompson did some work  -->


