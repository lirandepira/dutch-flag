## dutch-flag
The Dutch national flag problem is a partitioning problem proposed and solved by E. Dijkstra in the 1970s.
The problem is solved in +CAL in TLA.

A description is to be found here: https://en.wikipedia.org/wiki/Dutch_national_flag_problem

### Implementation
The algorithms takes as inputs an array t with domain 1..N and values in 0..MAXINT (N and MAXINT are parameters),
and two values low and high in 0..MAXINT, such that low < high.
The value low represents the biggest "red" value and high is the smallest "blue" value.
