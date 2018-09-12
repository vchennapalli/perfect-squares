#Perfect Squares

##Group Info
* Vineeth Chennapalli - 31242465


##Size of Work Unit
* I experimented initially by creating N/c number of actors where each actor is responsible for calculating the k consecutive squares sum for c values. I experimented by considering a couple of values for c (10, 100 etc).
* While this worked well for all the sizes, I realized that I could potentially create more actors than N/c number when the number N is small. I understood that this would excute my code in a more concurrent manner. Therefore, I decided to create N actors when N < 20000 and about 10000 actors when N >= 20000. Finally, work unit size is 1 when N < 20000 and around N/10000 when N >= 20000.


##Running Instructions

* Ensure that the mix.exs and proj1.exs are present in the same directory. Run the following command with desired values of N and k.
```
mix run proj1.exs N k
```

* Output Format: All the starting numbers of the perfect square series will be printed in a new line one after the other. 


##Performance Measurements

* For N = 1000000 and k = 4, I didn't receive any output. I got an average CPU/Real time ratio of 2.8 on a quad-core machine.


##Solved Test Cases

* The largest test case I considered was with N = 100000000 and k = 24. I got 43 numbers and the following is the output.

```
mix run proj1.exs 100000000 24
52422128
3500233
1
9
20
25
44
76
121
197
304
353
29991872
20425
540
30908
856
841476
1301
45863965
2002557
202289
2053
12602701
82457176
1273121
12981
3112
19823373
353585
3597
54032
5295700
534964
84996
5448
35709
306060
34648837
3029784
128601
8576
8329856
```

* For N = 1000000 and k = 24, I got 30 numbers and the following output:

```
mix run proj1.exs 100000000 24
841476
534964
353585
306060
202289
128601
84996
54032
35709
30908
20425
12981
8576
5448
3112
3597
2053
1301
856
540
304
353
1
121
9
20
25
44
76
197
```



