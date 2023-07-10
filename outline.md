# AI-FProj-M: Neuro-ILP-Birds

Research Question: To what degree is it possible to learn Logical Rules in a Physic Based Dynamic environment.

## Motivation

Up to now, the best performing algorithms for discovering actions in the pysics based game environment AngryBirds are mostly written by Hand with some parameter tuning using Machine Learning.
With advances in the last years in the domain of Machine Learning, Inductive Logic Programming and their combination Neuro-Symbolic AI, it should be evaluated if these new techniques can be integrated more into the development of a physics based reasoner.

Machine Learning and in Particular Deep Neural Networks have shown good results in many domains, in particual in Image and Speech synthesis.
The problem with applying neural networks in this setting however is, that the data comes in a symbolic representation and with varying sizes.
Using just a screenshot of the image requires to much inference and can not be learned from the available data.
Also is the resulting network not explainable, which does not give us the possibility to apply it in a different scenario.

Inductive Logic Programming is in many regards the opposite of Machine Learning, as it only requires small amounts of example data and learns explicit understandable rules.
However it has not yet been shown to be able to extrapolate to a larger domain and especially struggles with large amounts background knowledge. Alos the performance is quite slow in comparison to the learning in Neural Networks.
Newer Meta-Learning approaches can describe much larger amounts of data, but require a lot of knowledge about the situation to create relevant meta-rules.

Combining the two as Neuro-Symbolic AI sounds promising, however the research is still quite young and is seldom applied to larger domains.
One approach in particular seems promising in this application, which is probabilistic Logic (ProbLog) which adds probabilities to facts and clauses and DeepProbLog which adds the possibility of adding neural networks into the programs. Inductively learning these programs seems however very unlikely.

Steps of research:

- Find a number of problems where learning logic rules and or probabilities seems possible.
- Order the discovered problems by (expected) complexity
- Generate datasets for these problems
- Write learning programs with appropriate background knowledge for these problems in several different learners (if possible)
- Evaluate the results

The aim is to provide a framework to generate rules based on observations made while playing the game.

Domains:
- supports
  - some physical force from object B to object A -> supports(A,B)
  - above + when object A is removed, B moves -> supports(A,B)
- stable
  - when physical simluation is run, object remains at the same position -> stable(A)
- 
