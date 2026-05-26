---
permalink: /
title: "About"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

I am a PhD student in Computer Science at [ETH Zurich](https://ethz.ch/), in the [Scalable Parallel Computing Laboratory (SPCL)](https://spcl.inf.ethz.ch/) advised by [Prof. Torsten Hoefler](https://htor.inf.ethz.ch/), with [Prof. Dan Alistarh](https://ist.ac.at/en/research/alistarh-group/) as my second advisor. I completed my MSc in Computer Science at ETH Zurich and my BSc in Computer Science at the University of Toronto.

My thesis &mdash; *Hardware-Aware Neural Network Architecture Design* &mdash; sits at the intersection of **high-performance computing** and **machine learning systems**. I am interested in the principled co-design of neural network structures with the hardware they run on: identifying computation patterns that simultaneously satisfy mathematical requirements (expressiveness, training stability, hyperparameter transfer) and hardware constraints (tensor-core tile shapes, memory hierarchy, accumulator precision), so that the resulting architectures are both theoretically motivated and close to peak hardware utilization.

Research interests
======
- **Fused tensor-core kernels.** Block-diagonal batched matrix multiplications chained on-chip into dense GEMMs, designed around tensor-core tile shapes and warp-level producer–consumer scheduling. I am developing [`cute_prism`](https://github.com/Yanksi), a CuTe/CUTLASS-based kernel library for this family of primitives.
- **Structured layers for pretraining.** *PrismLinear*, a drop-in replacement for dense linear layers that processes disjoint feature groups through small block-diagonal transforms (optionally gated) before a shared dense projection, giving an implicit width expansion at a fraction of the parameter and FLOP cost of an equivalent dense MLP.
- **Parameter-efficient fine-tuning.** Block-structured generalizations of Orthogonal Fine-Tuning (OFT) that preserve its theoretical guarantees while running at LoRA-competitive wall-clock latency.
- **Low-precision pretraining and quantization.** Using block-diagonal linear corrections (rather than per-channel scalar scales) as a richer per-block representation, aiming to outperform GPTQ/AWQ/SmoothQuant at matched storage budgets and to help stabilize end-to-end FP8 / INT8 pretraining.
- **Theory of structured sparse architectures.** muP-style parameterizations and signal-propagation analyses extended to block-diagonal and other structured-sparse layer families, so that hyperparameter transfer and scaling laws carry over from the dense setting.

I do not have any published results yet &mdash; this page will be updated as work from my PhD comes out. In the meantime, please see my [CV](/cv/) for details on ongoing projects.

Contact
======
The best way to reach me is by email at [shuhao.li@inf.ethz.ch](mailto:shuhao.li@inf.ethz.ch). Code I work on in the open lives at [github.com/Yanksi](https://github.com/Yanksi).
