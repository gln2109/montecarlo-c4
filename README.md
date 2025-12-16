# MonteCarlo-C4
#### Grayson Newell - gln2109
A Monte Carlo evaluator for Connect-4, in Haskell. Finds an optimal move given a board and a player. Includes an interactive game against the evaluator.

### Source Files:
- **Bench.hs** - Timing script using test boards
- **Play.hs** - Interactive Connect-4 game against evaluator
- **Board.hs** - Connect-4 game representation
- **EvalSeq.hs** - Sequential Monte-Carlo evaluator for best move
- **EvalPar.hs** - Parallel Monte-Carlo evaluator
- **EvalChunk.hs** - Chunked parallel Monte-Carlo evaluator

### Requirements:
#### Stack, GHC

### How to Run:
Stack Setup:
```
cd path/to/montecarlo-c4
stack build
```
Benchmark w/ Test Boards:
```
stack exec bench -- +RTS -N8
stack exec bench -- +RTS -N8 -A32m          (gc optimization)
```
Play Connect-4:
```
stack exec play
stack exec play -- +RTS -N8
stack exec play -- +RTS -N8 -A32m
```


