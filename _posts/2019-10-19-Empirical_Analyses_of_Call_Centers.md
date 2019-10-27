---
layout: post
title: How Staffing is Done in Practice
permalink: /literature/callcenter
---


## Call Centers

Based on the literature I have read so far, staffing call centers is a two-part process:

(1) First, managers forecast the amount of agents that will be necessary based on predicted demand, performance metrics, and sometimes economic optimization. The staffing requirements are typically set in half-hour or hourly intervals. 

(2)  Second, managers match full-time and/or part-time workers to those half-hour and hourly intervals. They have to do that in a way that respects the workers shifts. This is typically solved with integer programming.

For (1) The forecasts generally go out for one to three weeks in advance. In [The Modern Call Center: A Multi-Disciplinary Perspective on Operations Management and Research](https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1937-5956.2007.tb00288.x), a literature survey from 2007, it is stated without citation that

> "Resource deployment decisions are typically made 1 or more weeks in advance of when the calls actually arrive... as new data \[becomes available\] for a given day or week, \[staffers modify\] both the near-term call arrival forecasts and the agent schedules that drive them." 


At the call centers run by L.L. Bean, the clothing company, managers plan out three weeks in advance. There was a series of papers by Andrews and Cunningham (two professors at the University of Southern Maine -- L.L. Bean was founded in Maine) on the subject. [In one such paper](https://pubsonline.informs.org/doi/pdf/10.1287/inte.25.6.1), they report,

> "Schedulers \[use models\] to predict daily call volumes for the next three weeks so that they can create week-long staffing schedules... the real focus is on the third week ahead... every Monday, on the first day of the 21-day planning horizon, the \[schedulers\] each load seven forecasts of daily call volumes for Monday the (15th day) through Sunday (the 21st day) into their automated staff scheduling system. This allows them to post agent work schedules for work weeks two weeks in advance."
> 

In their [other paper on the LL Bean staffing problem](https://pubsonline.informs.org/doi/pdf/10.1287/inte.23.2.14), they point out that  

> "Managers need to (1) forecast the work load for the telemarketing center on a half-hourly basis, (2) translate the work load into capacity requirements, and (3) genereate week-long staffing schedules for part-time and full-time telephone agents to meet the capacity requirements."
> 

They go on to say,

>Prior to this study, L.L. Bean used the traditional way of determining the target number of telephone agents on duty, which is controlled by management's view of an acceptable level of cutstomer service ... \[The \] telephone service factor is routinely adobed by telephone centers as a common standard, often set so that not more than 15 percent of the calls wait more than 20 seconds before reaching an operator.



Professor Vincent Mabert did a lot of work in applied staffing problems. [In planning the staffing requirements for the Indiana Police Department (IPD) Communcations Support](https://www.tandfonline.com/doi/pdf/10.1080/05695558308974653?casa_token=LVaq-oAoEWAAAAAA:k3VHXwDeqMquMMB0uUvWS9K85hpNHKLm1EodKO5Qt-MshFpGfo580gJjDSN1zYQCBGQRy5HFjplmOg), he assigned constant staffing requirements for each hour. However, IPD operators are full-time skilled personell that work eight-hour shifts. They work a 28-day cycle and then repeat this cycle. Deciding how to allocate people into various ``tour types'' is decided via an integer program.

![png](/files/literature/Empirical_Analyses_of_Call_Centers/figures/Mabert_Indiana_Police_Table.png)

Mabert also has work with "Chemical Bank" and "PSI" Energy's call center. Some of these are unpublished, but we might reach out if we want to get a sense of how those were done.


Another example is Thompson's [work with the New Brunswick Telephone Company](https://pubsonline.informs.org/doi/pdf/10.1287/inte.27.4.1). In this system, employees bid for shifts and mention when they cannot work, and then a matching algorithm based on seniority finds a solution to the allocation problem. Here is a table showing the shift schedules that need to be allocated to staffers based on preferences. 

![png](/files/literature/Empirical_Analyses_of_Call_Centers/figures/Thompson_Shift.png)


<!-- 
Walker summarizes Rand's contributions to blah. -->



## Police Dispatch 
[The San Fracisco Police Department](https://pubsonline.informs.org/doi/pdf/10.1287/inte.19.1.4) forecasts hourly needs and schedules patrol officers. The forecasts are made based on historical calls for service, consumed times by call type, management policy on percent of time officers should spend answering calls, percent of each call type requireing two or more police officers, and percent of cars allocated two officers. But you don't hire police officers on an hourly basis, but work with shifts:

> Many departments use three shifts with different numbers of officers beginning their week each day of the week. Many departments include overlay or power shifts in addition to the basic three.
> 

Part of the staffing problem is that police officers either use a four-day, ten-hour or five-day, eight-hour shift schedule. Deciding which of these is better for hitting optimal staffing numbers was a problem of this paper: and the researchers showed the 4/10 schedule to be preferred.




<!-- 
Gary Thompson did some work  -->


