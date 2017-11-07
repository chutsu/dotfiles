Hello Jason,

1. about "Algorithm Demonstration"

You need not worry, I did not mark your report down because of this, I had a suspicion that you may have been asked to do this.

2. and 3. about results

This is rather unfortunate you forgot to deduce a quantitative result or made plots, but I stand firm that when a report requires a "comparative study" you need to substantiate your claims with numbers and plots, I have already emphasised in almost all occasions during project meetings, project presentations and tutorial that you will be judge heavily on being able to compare effectively and concisely on how each algorithm performs against each other, I also remember emphasising that you must be able to visualise your results and make conclusions, dumping the data into tables and asking the reader to draw conclusions for themselves is not ideal. Additionally using subjective words such as "faster" or "better" or "seems to be more optimal" is not only unscientific it gives me no relative sense of how much faster, how much better, or how much more optimal one algorithm is compared to others.

In short, from an academic point view the lack of actual comparison between algorithms is why I felt the mark was justified. I hope you won't be too dishearten by this experience but look forward in the learning from this experience and look into how academics use metrics to compare by reading papers and emulate how they make claims and draw conclusions, it is a very useful and important scientific skill.

For completeness sake, lets examine your evaluation section together:

"Based on the results between ACO and GA, it is clear that ACO has the better runtime performance. This shows that one of the advantages of ACO is that it uses parallelism which greatly improves the runtime of the algorithm."

This is not true, GA can also be trivially parallelized, where each individual can be evaluated by each thread.

"Speed is a big factor in drone delivery and so, a low runtime by ACO is preferred."

Not always the case, maybe if a longer run time produces a better result I might prefer an algorithm that produces a better path than one that runs "faster". Addiitionally, the environment map is assumed to be static, so I might just need to compute the paths once.

"In addition, by the graphs of the experiments, the paths produced by ACO seemed to be more optimal than the paths produced by GA. Unlike GA, ACO retains memory of the entire colony instead of just previous generation. This allows ACO to choose a better overall path. "

Again "seemed to be more optimal" does not tell me how much more optimal, 1% better? 10% better? How does ACO's ability to retain memory allow ACO choose a better overall path? You did not provide enough ground how having memory translates to more optimal path, I'm not convinced.

"The disadvantage of ACO is that it uses a lot of parameters, and so the selection of values are mostly experimental. The alpha, beta, ant colony size and evaporation parameters were all determined through many rounds of trial and error until a decent path cost and runtime were observed. Furthermore, the number of iterations that was used in the experiments may not have achieved the best path. Increasing the number of iterations may take too long for a best solution to converge."

Having too many parameters is not just a ACO problem, you also have that problem in GAs as well. Consider this, in GA you have to choose:

- Number of iterations
- Population size
- Selection method
  - If tournament selection is chosen, what is the tournament size
  - etc
- Crossover method
  - If N-point crossover is chosen, what is N?
  - etc
- Mutation method
  - If N-point mutation is chosen, what is N?
  - etc
- Crossover probability
- Mutation probability

"GA on the other hand is relatively easier to implement compared to ACO. Its concepts are easier to grasp. In addition, mutation allows GA to search across the entire search space of the problem, however the randomness may prevent it from finding the best solution in the search space. At low iterations, its randomness makes the solution very inconsistant compared to ACO, but at higher iterations, the solution becomes much more consistent, at the cost of performance time."

How easy it is to implement is relatively subjective, you cannot objectively make that claim without proper metrics.










