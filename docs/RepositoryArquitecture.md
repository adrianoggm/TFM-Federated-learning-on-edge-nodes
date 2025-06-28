# Federated Learning System – Repository Layout & Workflow

A modular, privacy-preserving FL system for stress detection. The codebase is split into three repositories, each with clear responsibilities:

1. **fl-shared** — Common types, interfaces, and cryptographic utilities  
2. **fl-client** — Edge device agent for local training and communication  
3. **fl-server** — Central orchestrator and aggregator  

---

## 📦 1. Repository Breakdown

| Repository    | Purpose                                   | Key Components & Description                                                                                   |
|---------------|-------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| **fl-shared** | Shared logic, types, and cryptography     | - **DataWindow**: Standardizes input data<br>- **ModelDelta**: Encapsulates model updates<br>- **Interfaces**: For messaging and serialization<br>- **Crypto Helpers**: Homomorphic encryption & differential privacy |
| **fl-client** | On-device training & update publishing    | - **DataLoader**: Loads and preprocesses data<br>- **Model**: Encoder (feature extractor) + Head (classifier)<br>- **LocalTrainer**: Handles training logic<br>- **Updater**: Computes and encrypts updates<br>- **BrokerClient**: Handles communication<br>- **FLAgent**: Orchestrates client workflow |
| **fl-server** | Orchestration, aggregation, and storage   | - **Orchestrator**: Manages training rounds<br>- **FedAvgAggregator**: Aggregates client updates<br>- **StorageClient**: Persists models<br>- **BrokerServer**: Listens for updates<br>- **API & Monitor**: Health checks and metrics |

---

## 🔧 2. Repo Details & Responsibilities

### 2.1 **fl-shared**

> **Purpose:** Houses all code shared between client and server, ensuring consistency and security.

- **Data Models**
    - `DataWindow`: Represents a single data sample, including features, label, and metadata (e.g., timestamp, sensor ID).
    - `ModelDelta`: Contains model parameter updates (Δθ) and associated client identifiers.
- **Interfaces**
    - `IMessageBroker`: Abstracts publish/subscribe messaging (e.g., MQTT, gRPC).
    - `ISerializer`: Handles data serialization/deserialization (e.g., JSON, Protobuf).
- **Crypto Helpers**
    - `HEHelper`: Provides homomorphic encryption/decryption for secure aggregation.
    - `DPHelper`: Adds differential privacy noise to updates for enhanced privacy.
- **Utilities**
    - Logging setup, configuration loader, and path utilities for consistent behavior.

<details>
<summary>Directory Structure</summary>

```
fl_shared/
├─ configs.py           # Shared configuration definitions
├─ data_window.py       # DataWindow model
├─ comms_interface.py   # Messaging interfaces
├─ serialization.py     # Serialization utilities
├─ encryption/
│   ├─ homomorphic.py   # Homomorphic encryption helpers
│   └─ differential.py  # Differential privacy helpers
└─ utils.py             # Miscellaneous utilities
```
</details>

---

### 2.2 **fl-client**

> **Purpose:** Runs on edge devices, handling local data, training, and communication with the server.

- **Data Loading & Preprocessing**
    - `DataLoader`: Reads raw sensor data, applies filtering, normalization, and windowing.
- **Model Components**
    - `Encoder`: Feature extractor (e.g., 1D-CNN or autoencoder).
    - `StressHead`: Dense classifier for stress detection.
- **Training Logic**
    - `LocalTrainer`: 
        1. Pretrains the encoder on local data.
        2. Fine-tunes the head for classification.
- **Delta & Communication**
    - `Updater`: Computes model updates (Δθ), encrypts them, and sends via `BrokerClient`.
    - `BrokerClient`: Handles network communication (MQTT/gRPC).
- **Agent Orchestration**
    - `FLAgent`: Coordinates training phases, handles retries, and manages workflow.

<details>
<summary>Directory Structure</summary>

```
fl_client/
├─ client_config.py     # Client-specific configuration
├─ data_loader.py       # Data loading and preprocessing
├─ model.py             # Encoder and head model definitions
├─ trainer.py           # Local training logic
├─ updater.py           # Update computation and encryption
├─ broker_client.py     # Communication with server
└─ agent.py             # Orchestration of client workflow
```
</details>

---

### 2.3 **fl-server**

> **Purpose:** Central server for orchestrating rounds, aggregating updates, and managing model storage.

- **Round Control**
    - `Orchestrator`: Selects clients, enforces timeouts, and triggers training phases.
- **Aggregation**
    - `FedAvgAggregator`: Computes weighted average of client updates for global model.
- **Checkpoint Storage**
    - `StorageClient`: Saves and loads models to/from cloud storage (e.g., S3, GCS), manages versioning.
- **Broker Listener**
    - `BrokerServer`: Subscribes to update topics (e.g., “encoder/delta”, “head/delta”).
- **Health & Metrics**
    - `API`: Provides endpoints for health checks (`/health`) and metrics (`/metrics`).
    - `Monitor`: Exports metrics for monitoring (e.g., Prometheus).

<details>
<summary>Directory Structure</summary>

```
fl_server/
├─ server_config.py     # Server configuration
├─ orchestrator.py      # Round management
├─ aggregator.py        # Aggregation logic
├─ broker_server.py     # Message broker listener
├─ storage_client.py    # Model storage interface
├─ api.py               # Health and metrics API
└─ monitor.py           # Monitoring and metrics exporter
```
</details>

---

## 🔄 3. System Workflow

### **Phase I – Encoder Pre-Training**

**Clients:**
1. Run `pretrain_encoder()` on local data windows.
2. Compute and encrypt encoder updates (Δθ_enc).
3. Publish encrypted updates to the `encoder/delta` topic.

**Server:**
1. `Orchestrator` collects all Δθ_enc from clients.
2. `FedAvgAggregator` aggregates updates to form a new global encoder.
3. `StorageClient` saves the new encoder version (`encoder_vX`).
4. Notifies clients to proceed to Phase II.

---

### **Phase II – Head Fine-Tuning**

**Clients:**
1. Download the frozen encoder (`encoder_vX`).
2. Run `finetune_head()` locally.
3. Compute and encrypt head updates (Δθ_head).
4. Publish encrypted updates to the `head/delta` topic.

**Server:**
1. Collects all Δθ_head from clients.
2. Aggregates updates into the full model (`θ_full_vX`).
3. Persists and versions the new model.
4. Notifies clients that the next round is ready.

---

## 🗺️ 4. Overall Flowchart

```mermaid
flowchart TD
    subgraph CLIENTS
        direction TB
        A1[Phase I: pretrain_encoder() - Train encoder locally] --> A2[encrypt & send Δθ_enc - Send to broker]
        A3[Phase II: finetune_head() - Train head locally]  --> A4[encrypt & send Δθ_head - Send to broker]
    end

    subgraph BROKER["MQTT / gRPC Broker"]
        A2 -->|topic "encoder/delta"| S1[Orchestrator.collect_encoder_deltas()]
        A4 -->|topic "head/delta"| S2[Orchestrator.collect_head_deltas()]
    end

    subgraph SERVER
        S1 --> AG1[FedAvgAggregator.aggregate_encoder() - Aggregate encoder updates] --> ST1[StorageClient.save_encoder_vX - Persist encoder]
        ST1 --> ORT1[Orchestrator.notify_phase2() - Trigger Phase II]

        S2 --> AG2[FedAvgAggregator.aggregate_head() - Aggregate head updates]   --> ST2[StorageClient.save_full_model_vX - Persist full model]
        ST2 --> ORT2[Orchestrator.notify_phase1() - Next round]
    end
```

---

## ✅ 5. Key Benefits

- **Separation of Concerns:**  
    - Shared logic in `fl-shared`  
    - Clear client/server partitioning

- **Independent Deployments:**  
    - Each repo has its own CI/CD, versioning, and permissions

- **Resilience & Security:**  
    - Cryptographic boundaries enforced in `fl-shared`  
    - Broker decouples network issues

- **Onboarding & Extensibility:**  
    - New contributors know exactly where to add features  
    - Easily swap encoder/head architectures without server changes

At the end of each training round, the orchestrator logs metrics, archives models, and alerts clients—ensuring a robust, private, and scalable FL pipeline for medical stress detection.

