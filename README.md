## dutch-flag
The Dutch national flag problem is a partitioning problem proposed and solved by E. Dijkstra in the 1970s.
The problem is solved in +CAL in TLA.

A description is to be found here: https://en.wikipedia.org/wiki/Dutch_national_flag_problem

### Implementation
The algorithms takes as inputs an array t with domain 1..N and values in 0..MAXINT (N and MAXINT are parameters),
and two values low and high in 0..MAXINT, such that low < high.
The value low represents the biggest "red" value and high is the smallest "blue" value.

### Info
- Input: Unsorted array of three partitions
- Output: Sorted array of three (ordered) partitions which reflects the post condition
- Pre-condition: The initial array should contain a random number of ALL three colors [RED, WHITE, BLUE].
- Post-condition: Given that the Pre-Condition has been met, the expected result is the right order of the balls (regardless of the number of the different colored balls).
