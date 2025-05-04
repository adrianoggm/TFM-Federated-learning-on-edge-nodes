# Federated  learning Project Objectives

This document outlines the primary goals for the federated learning project on edge devices.

> **See the full [Federated Learning System Overview](./docs/SystemOverview.md) for detailed architecture and workflow.**

## O1: Edge-based Federated Learning Architecture
- **Goal:** Propose a robust system and reference architecture that enables federated learning directly on heterogeneous edge components (e.g., mobile devices, Raspberry Pi).
- **Key Deliverables:**
  - Detailed architectural diagrams (client–broker–server).
  - Component specifications (FL agent, messaging layer, aggregation server).
  - Security and privacy considerations (TLS, secure aggregation, differential privacy).

## O2: Lightweight AI Model Analysis
- **Goal:** Investigate how “light” an AI model can be made while maintaining representativeness and satisfactory performance on target tasks.
- **Key Deliverables:**
  - Benchmark suite comparing model size vs. accuracy/latency on edge hardware.
  - Techniques for compression and optimization (quantization, pruning, knowledge distillation).
  - Guidelines for balancing model footprint against inference/training quality.

## O3: Dynamic and Scalable Classifier System
- **Goal:** Deliver a flexible, scalable framework of classifiers that can be easily deployed and updated by researchers or applications.
- **Key Deliverables:**
  - APIs for on-the-fly classifier registration and orchestration.
  - Auto-scaling strategies in cloud/backend for classifier workloads.
  - User-friendly interface or SDK for integrating new classifiers into experiments.

---