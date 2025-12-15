# MonteCarlo-C4
#### Grayson Newell - gln2109
A Monte Carlo evaluator for Connect-4, in Haskell. Finds an optimal move given a board and a player.

### Source Files:
- **Main.hs** - Timing script using test boards
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
Main Benchmark:
```
stack exec mcc4
stack exec mcc4 -- +RTS -N4
stack exec mcc4 -- +RTS -N8
```


