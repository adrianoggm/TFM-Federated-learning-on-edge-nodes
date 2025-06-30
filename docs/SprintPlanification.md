## SprintPlanification 
Objetivo
## 🎯 **Project Objectives**

### 🏛️ **O1: Edge-Based FL Reference Architecture**
> *Design a bulletproof federated learning pipeline for untrusted edge environments*

**🎯 What we build:**
- **Secure communication** with TLS mutual authentication
- **Privacy protection** using differential privacy and secure aggregation
- **Fault tolerance** for unreliable edge connections
- **Heterogeneity handling** for devices with different computational power

**📦 Deliverables:**
- Architecture diagrams and specifications
- FL Agent (local trainer + secure uploader)
- Messaging layer (MQTT/gRPC broker)
- Aggregator with FedAvg/FedProx algorithms

### ⚡ **O2: Lightweight Model Optimization**
> *Find the sweet spot between model accuracy and edge device constraints*

**🎯 What we optimize:**
- **Model size** (target: <10MB for mobile deployment)
- **Inference latency** (target: <100ms real-time stress detection)
- **Training efficiency** (battery-friendly local training)
- **Accuracy preservation** (maintain >85% stress detection F1-score)

**📊 Techniques explored:**
- Model quantization (8-bit, mixed precision)
- Neural network pruning 
- Knowledge distillation
- Efficient architectures (MobileNets, EfficientNets)

### 🔌 **O3: Pluggable Classifier Hub**
> *Create a flexible framework for deploying new ML models across the federation*

**🎯 What we enable:**
- **Hot-swappable models** without system downtime
- **A/B testing** of different algorithms in production
- **Auto-scaling** based on federated training load
- **Easy deployment** with simple SDK and CLI tools

---

# Project Task Breakdown & Milestones

Below is a detailed, granular breakdown of all project tasks along with their dependencies and associated milestones. This will serve as the roadmap for our federated-learning-on-edge-nodes project.

---

## 🚀 Milestones

| Milestone ID | Name                            | Description & Exit Criteria                                                   | Target Date |
|-------------:|---------------------------------|-------------------------------------------------------------------------------|------------:|
| **M1**       | Project Kick-off & Specs Final  | Objectives, scope, F/NF requirements, high-level plan approved                | Week 2      |
| **M2**       | Research & Feasibility Complete | SOTA survey, tech comparison, dataset selection, algorithm/architecture pick   | Week 6      |
| **M3**       | System Design Freeze            | Class diagrams, data-flow, actor definitions, CI/CD blueprint finalized        | Week 8      |
| **M4**       | Core Components MVP             | Basic client, broker, server, data-prep prototypes all running end-to-end      | Week 12     |
| **M5**       | Full Feature Implementation     | All modules (FL-agent, broker, aggregator, UI) implemented & integrated       | Week 20     |
| **M6**       | Testing & Hardening             | Automated tests in CI, performance tuning, security review, DP/HE validated    | Week 24     |
| **M7**       | Documentation & Delivery        | User/developer docs, final demos, deployment guides, project closeout         | Week 26     |

---

## 🔧 Task List

### 1. Project Initiation & Planning  
1.1 **Define Project Objectives**  
&nbsp;&nbsp;&nbsp;- Draft clear O1–O3 (see README)  
&nbsp;&nbsp;&nbsp;- **Dependency:** none  
1.2 **Capture Functional & Non-Functional Requirements**  
&nbsp;&nbsp;&nbsp;- Use-cases, performance, security, scale, device targets  
&nbsp;&nbsp;&nbsp;- **Depends on:** 1.1  
1.3 **High-Level Project Plan**  
&nbsp;&nbsp;&nbsp;- Gantt chart, resource allocation, risk register  
&nbsp;&nbsp;&nbsp;- **Depends on:** 1.1, 1.2

> **Milestone M1**  

---

### 2. Research & Feasibility (SOTA)  
2.1 **Literature Survey: Federated Learning Architectures**  
&nbsp;&nbsp;&nbsp;- Google Scholar + Scopus + arXiv + conferences  
&nbsp;&nbsp;&nbsp;- Compare HFL / VFL / FTL pros/cons for stress detection  
2.2 **ML Algorithm Review**  
&nbsp;&nbsp;&nbsp;- Tree models (XGBoost), SVM, logistic regression, CNN, RNN  
&nbsp;&nbsp;&nbsp;- Suitability for streaming, tiny-ML, personalization  
2.3 **Dataset Landscape & Selection**  
&nbsp;&nbsp;&nbsp;- Catalog SWEET, WESAD, SWELL, etc.  
&nbsp;&nbsp;&nbsp;- Evaluate size, format, licensing, modalities  
2.4 **Technology & Framework Comparison**  
&nbsp;&nbsp;&nbsp;- TF-TFLite vs PyTorch Mobile vs Flower vs TFF  
&nbsp;&nbsp;&nbsp;- Broker: MQTT vs gRPC vs Kafka  
2.5 **Feasibility Report & Recommendations**  
&nbsp;&nbsp;&nbsp;- Summarize findings, pick our stack  
&nbsp;&nbsp;&nbsp;- **Depends on:** 2.1, 2.2, 2.3, 2.4  

> **Milestone M2**  

---

### 3. System Design  
3.1 **High-Level Architecture Diagram**  
&nbsp;&nbsp;&nbsp;- Client–broker–server components, data flows  
&nbsp;&nbsp;&nbsp;- **Depends on:** 2.5  
3.2 **Detailed Class & Module Diagrams**  
&nbsp;&nbsp;&nbsp;- FL Agent classes, Broker interface, Aggregator module  
3.3 **Data-Flow Diagrams**  
&nbsp;&nbsp;&nbsp;- Raw → Preprocessed → Local model → Δθ → Aggregation  
3.4 **Actors & Use-Case Definitions**  
&nbsp;&nbsp;&nbsp;- Edge devices, admin console, data scientists  
3.5 **CI/CD Platform Plan**  
&nbsp;&nbsp;&nbsp;- Repo structure, pipelines for build/test/deploy  
&nbsp;&nbsp;&nbsp;- Code quality (lint, security scans)  
3.6 **Design Documentation**  
&nbsp;&nbsp;&nbsp;- Markdown + diagrams under `/docs/SystemOverview.md`  

> **Milestone M3**  

---

### 4. Core Implementation (MVP)  
4.1 **Repo Scaffolding & Submodules Setup**  
&nbsp;&nbsp;&nbsp;- Create `edge-agent/`, `broker/`, `aggregator/`, `common/`, `docs/`  
4.2 **Data–Prep & Formatting Library**  
&nbsp;&nbsp;&nbsp;- Parsers for SWEET/WESAD/SWELL sliding windows  
&nbsp;&nbsp;&nbsp;- Feature extraction CLI / Python API  
4.3 **FL Agent (Client)**  
&nbsp;&nbsp;&nbsp;- Download global model, local train, compute Δθ, send updates  
&nbsp;&nbsp;&nbsp;- Configurable ML algorithm plugin interface (XGBoost, SVM, CNN…)  
4.4 **Messaging Broker**  
&nbsp;&nbsp;&nbsp;- MQTT/gRPC stub server, reliability, TLS  
4.5 **Aggregation Server**  
&nbsp;&nbsp;&nbsp;- Receive Δθ, apply FedAvg / FedProx, update checkpoint  
4.6 **End-to-End Smoke Test**  
&nbsp;&nbsp;&nbsp;- One client → broker → aggregator → new model → client  

> **Milestone M4**  

---

### 5. Full-Feature Implementation  
5.1 **Advanced FL Strategies**  
&nbsp;&nbsp;&nbsp;- FTL pre-train + fine-tune heads, optional frozen/unfreeze rounds  
&nbsp;&nbsp;&nbsp;- Resilience: timeouts, retries, differential privacy hooks  
5.2 **Model Plugins**  
&nbsp;&nbsp;&nbsp;- Tree-based (XGBoost), SVM, logistic regression, tiny-CNN  
&nbsp;&nbsp;&nbsp;- Performance profiling on Pi & phones  
5.3 **Web Front-End (Future-Proof)**  
&nbsp;&nbsp;&nbsp;- Simple React/Next.js dashboard to kick off rounds & visualize metrics  
5.4 **CI/CD Integration**  
&nbsp;&nbsp;&nbsp;- Automated unit/integration tests for each repo, publishing artifacts  
5.5 **Containerization & Deployment**  
&nbsp;&nbsp;&nbsp;- Dockerfiles + Helm charts for all services  

> **Milestone M5**  

---

### 6. Testing, Hardening & Performance  
6.1 **Unit & Integration Tests**  
&nbsp;&nbsp;&nbsp;- 100% coverage on core modules, simulated multi-client flows  
6.2 **Performance Benchmarking**  
&nbsp;&nbsp;&nbsp;- Model size vs accuracy vs latency on RPi, Android emulator  
6.3 **Security & Privacy Audit**  
&nbsp;&nbsp;&nbsp;- TLS, auth, secure aggregation, DP parameter checks  
6.4 **Fault Injection & Recovery**  
&nbsp;&nbsp;&nbsp;- Simulate dropped clients, stale updates, duplicate messages  
6.5 **Load Testing**  
&nbsp;&nbsp;&nbsp;- Scale to dozens of clients, measure aggregator throughput  

> **Milestone M6**  

---

### 7. Documentation & Project Close-out  
7.1 **User & Dev Guides**  
&nbsp;&nbsp;&nbsp;- `/README.md` in each repo, `/docs` for overall system  
7.2 **API References**  
&nbsp;&nbsp;&nbsp;- Auto-generated OpenAPI / gRPC proto docs  
7.3 **Final Demo & Slide Deck**  
&nbsp;&nbsp;&nbsp;- End-to-end demo script, performance graphs  
7.4 **Hand-off & Training**  
&nbsp;&nbsp;&nbsp;- Knowledge transfer sessions, “How to onboard someone new”  
7.5 **Project Retrospective**  
&nbsp;&nbsp;&nbsp;- Lessons learned, backlog of “nice-to-haves”  

> **Milestone M7**  

---

## ⚙️ Task Dependencies at a Glance

```text
1.1 → 1.2 → 1.3 → [M1]
   ↓
2.5 ← 2.1,2.2,2.3,2.4 → [M2]
   ↓
3.1 → 3.2 → 3.3 → 3.4 → 3.5 → [M3]
   ↓
4.1 → 4.2 → 4.3 → 4.4 → 4.5 → 4.6 → [M4]
   ↓
5.1 → 5.2 → 5.3 → 5.4 → 5.5 → [M5]
   ↓
6.1 → 6.2 → 6.3 → 6.4 → 6.5 → [M6]
   ↓
7.1 → 7.2 → 7.3 → 7.4 → 7.5 → [M7]
```
Arrows (→) denote strict “must complete before” relationships.

Milestones bracketed [Mx] mark the exit criteria at the end of each phase.


