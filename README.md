# MonteCarlo-C4
A Haskell Monte-Carlo evaluator for Connect-4.
#### Grayson Newell - gln2109

### Source Files:
- **Board.hs** - Connect-4 board representation
- **EvalSeq.hs** - Sequential Monte-Carlo evaluator for best move
- **EvalParOld.hs** - Parallel Monte-Carlo evaluator
- **EvalPar.hs** - Chunked parallel Monte-Carlo evaluator
- **Benchmark.hs** - Timing script using test boards
- **Main.hs** - 


### How to Run:

Benchmark:
```
stack exec benchmark -- +RTS -N8
```


