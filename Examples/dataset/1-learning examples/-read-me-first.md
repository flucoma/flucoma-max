# Salutations to the avid reader: what is the content of this folder

These are learning examples I devised as I was learning the framework and the starting tasks and concepts of data handling. I devised them in graphical means, in low dimensionality, to provide a model for me to test and understand the limits of each element of the chain.

## What is What
### 1a-starting-1D-example /// 1b-starting-2D-example
These examples show how to build a simple line(1a) or grid(1b) of equidistant points, and show how to retrieve the nearest elements and their distances. It also shows how to cluster them. As they are equidistant, they should give results easy to intuit.
### 2a-starting-1D-example2 /// 2b-starting-2D-example2
These are the same as above, but leave a hole in the middle of the line (2a) or the space (2b) so we can see how values behave again in more predictable way, especially for the clustering.
### 3a-classifier-example.maxpat /// 3b-classifier-example2.maxpat
These allow to understand classifiers. In the first example (3a), we make a grid of dots again, of 2 clearly segregated classes, and then poke around to see in which class any entry would be put. In the second example (3b), the user is drawing pixels of both classes anywhere on the canvas, and then can explore where classification becomes more difficult.
### 4-regressor-example.maxpat
This patch draws a recognisable function, leaving holes in it, and tries to reconstruct the missing element by interpolating from the nearest neighbours.
### 5-normalization-and-standardization-example.maxpat
This allows to understand the various data preprocessing one can do, and their impact on nearest neighbours. It makes 20 entries of random values, normalize and standardize them, and query the 3 datasets to showcase first what values look like, then searches for nearest entries, demonstrating how their order might be different.
### 6a-dimension-reduction-example.maxpat /// 6b-dimension-reduction-example2.maxpat
In these patch, we explore 2 dimensionality reduction algorithms and their impact on distances and therefore potentially order of nearest neighbours. In the first one (6a) we explore PCA, drawing a simple line in a 2D space, and observing the impact of normalisation, dimensionality reduction, whilst progressively adding noise. In the 2nd one (6b) we start with a predictable 2D curve and observe how PCA compares with various modes of MDS in trying to keep overall and local topologies whilst reducing to 1D.
### 7-making-subsets-of-datasets.maxpat
In this patch, we explore conditional dataset pruning, to allow the creation of new, smaller datasets.
