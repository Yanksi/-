---
layout: archive
title: "CV"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---

{% include base_path %}

A PDF version of my CV is available [here](/files/cv.pdf).

Education
======
* **Ph.D. in Computer Science**, ETH Zurich, 2025–present
  * Thesis: *Hardware-Aware Neural Network Architecture Design*
  * Advisor: Prof. Torsten Hoefler (Scalable Parallel Computing Laboratory)
  * Second advisor: Prof. Dan Alistarh
* **M.Sc. in Computer Science**, ETH Zurich, 2022–2025
  * GPA: 5.60 / 6.00
* **B.Sc. in Computer Science**, University of Toronto, 2016–2021
  * Average GPA: 3.88 / 4.0; graduated with High Distinction
  * Focus: Artificial Intelligence, Computer Vision, Scientific Computing

Research experience
======
* **PrismLinear** and the `cute_prism` kernel library &mdash; ETH Zurich, SPCL, 2026–present
  * Proposed a block-diagonal grouped linear layer that, paired with a gated SiLU activation, serves as a parameter-efficient width-expansion primitive for network pretraining: each layer provides multiple independent pathways at a fraction of the parameter and compute cost of an equivalently-wide dense MLP.
  * Building [`cute_prism`](https://github.com/Yanksi), a CUTLASS/CuTe-based kernel library that exposes the fused BMM&ndash;GEMM primitive (block-diagonal multiply &rarr; optional activation / GLU gating &rarr; dense GEMM) with three backends: a JIT-compiled tensor-core path for peak performance, a cuBLAS fallback, and a PyTorch reference. To be released open-source alongside the first paper.
  * Implemented a fused batched-GEMM + GEMM forward kernel in CuTe that computes $(AR^\top)B^\top$ with block-diagonal $R$ in a single kernel launch. On an RTX 3080 Ti the forward kernel matches cuBLAS GEMM runtime at the equivalent dense $(M, N, K)$ problem size, and achieves a >3&times; speedup over an optimized cuBLAS baseline that requires two cuBLAS calls per group ($2n_\text{groups}$ kernel launches in total).
  * Used Nsight Compute to identify distinct throughput bottlenecks at each computation stage (memory-bound stalls preceding the batched-GEMM $AR$, compute-bound tensor-core contention preceding the subsequent GEMM) and restructured the kernel into a producer–consumer warp model with PTX-level barrier coordination (`bar.sync`, `bar.arrive`) to overlap the two resource profiles.
  * Implemented matching fused backward kernels for the $A/R$ and $B$ gradients, integrated with PyTorch via a custom autograd op. Built an end-to-end autotuning system with pipelined JIT compilation and benchmarking (producer–consumer overlap, multi-GPU, on-disk result cache) that selects optimal tile sizes, pipeline depths, and warp layouts per problem shape.

* **NCCL Trace Generation for Distributed Training Simulation** &mdash; ETH Zurich, SPCL, 2025–2026
  * Re-architected a translator from Nsight Systems traces to the Goal trace format used by the LogGOPSim network simulator. Replaced a monolithic 2000-line procedural script with a domain-driven object model (physical, NCCL, and Goal IR layers), enabling extensibility to alternative collective implementations and per-communication context labeling.
  * Resolved performance regressions introduced by the richer object model: fork-based multiprocessing with copy-on-write–friendly immutable data layouts for parallelism without serialization overhead, and lazy evaluation via Python generators to bound memory consumption on large-scale traces.
  * Developed a lightweight training-simulation framework (`simple_sim`) with a PyTorch-like API and a built-in autograd engine that supports communication operators (AllReduce, ReduceScatter, AllGather), enabling synthetic trace generation with roofline-modeled compute costs for workloads beyond available hardware scale.

* **Replacing Dense Layers with Higher-Efficiency Structures** &mdash; MSc thesis, ETH Zurich, SPCL, 2024–2025
  * Investigated structured-sparsity-aware linear-layer parameterizations that exploit NVIDIA Sparse Tensor Cores (2:4 structured sparsity) for higher training and inference throughput on Ampere GPUs.
  * Generalized orthogonal fine-tuning (OFT) to block-structured variants that admit substantially higher kernel efficiency while preserving the orthogonal-constraint benefits of the original formulation.
  * Empirically showed that block-diagonal layer structures used during pretraining recover the accuracy gap of 2:4-sparse models, bridging pretraining-time architecture design with post-training hardware sparsification.

Work experience
======
* **Research Engineer (Contract)**, Noah's Ark Laboratory, Huawei Technologies Canada, Markham, ON, 2021–2022
  * Contributed to an on-device eye-tracking algorithm for smartphone applications. Implemented model calibration via Newton's method for fast per-user adaptation, and designed the accompanying gaze-following calibration protocol with verified fixation tracking.
  * Built an end-to-end Android application that captures calibration data via the designed protocol, runs on-device calibration, and demonstrates live gaze-tracking performance with the calibrated model.

* **Research Intern**, Noah's Ark Laboratory, Huawei Technologies Canada, Markham, ON, 2019–2020
  * Led the development of a smartphone-based paint color estimation method, resulting in granted US patent [US11810329B2](https://patents.google.com/patent/US11810329B2) with the author listed as inventor.
  * Proposed a flash-based measurement protocol that recovers the environment-invariant spectral response of a paint sample by pairing a flash-lit capture with an ambient capture.
  * Developed Android demo applications showcasing the team's computer-vision algorithms.

Projects
======
* **Polybench Kernel Optimization** &mdash; Design of Parallel and High-Performance Computing, ETH Zurich, 2024
  * Implemented a CUDA tensor-core kernel for symmetric matrix–matrix multiplication (`symm`) using the WMMA API with TF32 precision. Exploited symmetry of $A$ at tile-load time — below-diagonal, above-diagonal, and diagonal-crossing tiles each follow a distinct shared-memory layout path — to halve redundant global-memory traffic while preserving vectorized 128-bit loads and WMMA fragment alignment.
  * Achieved 2.1&times; speedup over cuBLAS `symm` on RTX 4090 by combining symmetry-aware tiling with multi-level blocking (thread-block, warp, and WMMA-fragment granularity).
  * Co-developed a fused CPU kernel for `gemver` consolidating four BLAS calls into a single pass, achieving 8&times; speedup over composed OpenBLAS kernels on AMD EPYC 7H12 by saturating memory bandwidth with minimal redundant traffic.

Skills
======
* **Programming:** C/C++, CUDA, PTX, Python, OpenMP, MPI
* **GPU & HPC:** CuTe, CUTLASS, tensor-core programming (Ampere MMA), GPU kernel autotuning, profiling-driven optimization (Nsight Compute), warp-level synchronization primitives
* **ML & Frameworks:** PyTorch (custom autograd ops, C++/CUDA extensions), Deep Learning

Teaching
======
* **Computational Intelligence Lab**, ETH Zurich &mdash; Teaching Assistant, Spring 2026
* **Linear Algebra**, ETH Zurich &mdash; Teaching Assistant, Fall 2025

Publications
======
{% if site.publications.size > 0 %}
  <ul>{% for post in site.publications reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}</ul>
{% else %}
*In preparation.*
{% endif %}
