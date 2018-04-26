Genetic Algorithms are an extremely powerful class of Evolutionary Algorithms especially used in domain of Non-Convex or Gradient-free optimization. The core of genetic algorithms is based on stochastic operations rather than deterministic operators. However unlike random walk or Monte Carlo methods, the search is carefully directed by appropriate mapping of representations and careful control of variation per iteration.

There are many variants of Genetic Algorithms based upon their internal structure, however at the core, these methods defer from other optimization paradigms in three main ways by:
- Utilizing a population of points (potential solutions) in their search
- Using direct fitness computation instead of function derivatives or other related knowledge
- Performing probabilistic transition operation(s) called evolutionary operations.

This project explores the power of Genetic Algorithms to optimize multivariate functions using the popular MATLAB software. Special focus was given to have an implementation that not only produces results of expected accuracy but to minimize the computation time. Genetic Algorithms often suffer in speed compared to gradient based optimization methods when the search space is too large. Every evolutionary step was carefully vectorized to minimize the run time of implemented algorithm.
