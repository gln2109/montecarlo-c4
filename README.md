# MonteCarlo-C4
A Haskell Monte Carlo evaluator for Connect-4.
#### Grayson Newell - gln2109

### Source Files:
- **Board.hs** - Connect-4 board representation
- **EvalSeq.hs** - Sequential Monte-Carlo evaluator for best move
- **EvalPar.hs** - Parallel Monte-Carlo evaluator
- **EvalChunk.hs** - Chunked parallel Monte-Carlo evaluator
- **Main.hs** - Timing script using test boards

### Requirements:
#### Stack, GHC

### How to Run:
Stack Setup:
```
stack build
```
Main Benchmark:
```
stack exec mcc4 -- +RTS -N8
```


