## SprintPlanification 
Objetivo
## 🎯 **Project Objectives**

### 🏛️ **O1: Edge-Based FL Reference Architecture**
> *Design a bulletproof federated learning pipeline for untrusted edge environments*

**🎯 What we build:**
- **Secure communication** with TLS mutual authentication
- **Privacy p### **Orden de Implementación Recomendado:**
1. **Sprint 1-2**: RF-001, RF-002, RF-003 (Core FL Pipeline)
2. **Sprint 3-4**: RNF-001, RNF-003 (Security & Performance)  
3. **Sprint 5-6**: RF-004, RF-004B (Advanced Aggregation & ML Selection)
4. **Sprint 7-8**: RNF-005, RNF-006 (Scalability & Availability)
5. **Sprint 9-10**: RF-006, RF-007 (Monitoring & Management)
6. **Sprint 11-12**: Requisitos de prioridad baja y refinamientoson** using differential privacy and secure aggregation
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

## 📋 Requisitos Funcionales

### **Prioridad ALTA** 🔴

#### **RF-001: Inicialización y Distribución del Modelo Global** 
> **Epic:** Core Federated Learning Pipeline

**📝 Descripción:**
- El servidor central debe publicar la versión inicial del modelo global (`ModelParameters`) al broker MQTT/gRPC.
- Los clientes deben recibir automáticamente el modelo global al suscribirse al topic `model/distribute`.
- Soporte para versionado de modelos y rollback a versiones anteriores.

**🎯 Historia de Usuario:**
> Como **administrador del sistema FL**, quiero **distribuir el modelo global inicial a todos los clientes conectados** para que **puedan comenzar el entrenamiento federado de forma sincronizada**.

**⚙️ Historia de Desarrollador:**
> Como **desarrollador backend**, necesito **implementar un servicio de distribución de modelos con MQTT QoS=2** para que **garantice la entrega confiable del modelo a todos los clientes suscritos**.

**✅ Criterios de Aceptación:**
- El modelo se serializa en formato Protocol Buffers
- Distribución automática en <5 segundos tras publicación
- Versionado semántico (v1.0.0) del modelo
- Logs de confirmación de recepción por cliente

---

#### **RF-002: Entrenamiento Local Adaptativo**
> **Epic:** Edge Computing Optimization

**📝 Descripción:**
- Cada cliente debe cargar el modelo recibido y entrenar sobre su dataset local privado durante un número configurable de épocas.
- Debe calcular la pérdida local y generar un delta de pesos (`delta_weights`).
- Optimización automática basada en recursos del dispositivo (CPU, memoria, batería).

**🎯 Historia de Usuario:**
> Como **usuario final con un dispositivo edge**, quiero **que el entrenamiento local se adapte automáticamente a los recursos de mi dispositivo** para que **no afecte el rendimiento de otras aplicaciones**.

**⚙️ Historia de Desarrollador:**
> Como **desarrollador mobile/IoT**, necesito **implementar un motor de entrenamiento ligero con cuantización** para que **funcione eficientemente en dispositivos con <2GB RAM**.

**✅ Criterios de Aceptación:**
- Entrenamiento configurable (1-10 épocas locales)
- Monitorización de recursos en tiempo real
- Early stopping automático si recursos < 20%
- Compresión de gradientes >50%

---

#### **RF-003: Comunicación Segura End-to-End**
> **Epic:** Security & Privacy

**📝 Descripción:**
- Todas las comunicaciones MQTT/gRPC han de ir cifradas (TLS 1.3) entre clientes, broker y servidor.
- Las actualizaciones de cliente (`ClientUpdate`) se publican en `model/updates` con QoS ≥1.
- Autenticación mutua con certificados X.509.

**🎯 Historia de Usuario:**
> Como **responsable de seguridad**, quiero **que todas las comunicaciones estén cifradas extremo a extremo** para que **los datos de entrenamiento permanezcan privados**.

**⚙️ Historia de Desarrollador:**
> Como **desarrollador de seguridad**, necesito **implementar TLS mutual authentication con rotación automática de certificados** para que **el sistema sea resistente a ataques man-in-the-middle**.

**✅ Criterios de Aceptación:**
- TLS 1.3 con Perfect Forward Secrecy
- Certificados rotan cada 30 días automáticamente
- Zero-knowledge proof de participación válida
- Auditabilidad completa de comunicaciones

---

#### **RF-004: Agregación Federada Inteligente**
> **Epic:** Distributed Learning Algorithms

**📝 Descripción:**
- El broker debe consumir mensajes de `model/updates`, deserializar y sumar los `delta_weights` de un batch de clientes.
- Aplicar algoritmos FedAvg, FedProx, FedNova según configuración.
- Integrar Differential Privacy y Secure Aggregation.

**🎯 Historia de Usuario:**
> Como **data scientist**, quiero **configurar diferentes algoritmos de agregación federada** para que **pueda experimentar y optimizar la convergencia del modelo**.

**⚙️ Historia de Desarrollador:**
> Como **desarrollador ML**, necesito **implementar una fábrica de algoritmos federados pluggable** para que **se puedan añadir nuevos algoritmos sin cambiar el core**.

---

#### **RF-004B: Selección y Evaluación de Algoritmos ML Locales**
> **Epic:** Edge Computing Optimization

**📝 Descripción:**
- Los clientes deben poder configurar y cambiar dinámicamente entre diferentes algoritmos de ML locales (CNN, Random Forest, XGBoost, SVM, etc.).
- Implementar sistema de benchmarking automático para evaluar performance de algoritmos en el dispositivo específico.
- Métricas de evaluación: accuracy, F1-score, precision, recall, latencia de inferencia, consumo de memoria, uso de CPU/GPU.
- Auto-selección del algoritmo óptimo basado en recursos del dispositivo y calidad de datos local.

**🎯 Historia de Usuario:**
> Como **investigador de ML**, quiero **poder experimentar con diferentes algoritmos de detección de estrés en mi dispositivo edge** para que **pueda encontrar el modelo que mejor balance accuracy y eficiencia para mis datos específicos**.

**⚙️ Historia de Desarrollador:**
> Como **desarrollador de ML**, necesito **implementar un framework de evaluación de algoritmos con métricas comparativas** para que **los clientes puedan seleccionar automáticamente el algoritmo más apropiado para su hardware y dataset**.

**✅ Criterios de Aceptación:**
- Soporte para al menos 5 algoritmos diferentes (CNN, Random Forest, XGBoost, SVM, Logistic Regression)
- Benchmarking automático al inicializar cliente con métricas de performance completas
- API para cambio dinámico de algoritmo sin reiniciar cliente
- Dashboard local que muestre comparativa de algoritmos con métricas en tiempo real
- Auto-selección basada en perfil del dispositivo (RAM, CPU, batería disponible)
- Logging detallado de performance para análisis posterior

---

#### **RF-005: Orquestación Inteligente de Rondas**
> **Epic:** Orchestration & Management

**📝 Descripción:**
- API REST/GraphQL para iniciar, detener o inspeccionar el estado de una ronda federada.
- Selección dinámica de clientes por disponibilidad, reputación, calidad de datos, latencia de red.
- Soporte para entrenamiento asíncrono y síncrono.

**🎯 Historia de Usuario:**
> Como **MLOps engineer**, quiero **orquestar rondas de entrenamiento con selección inteligente de clientes** para que **maximice la velocidad de convergencia del modelo**.

---

#### **RF-006: Observabilidad y Métricas Avanzadas**
> **Epic:** Monitoring & Analytics

**📝 Descripción:**
- Registrar métricas detalladas: número de clientes, pérdida global/local, tiempo de entrenamiento, throughput.
- Dashboard en tiempo real con Grafana/Prometheus.
- Alertas automáticas por anomalías (drift detection, Byzantine failures).

**🎯 Historia de Usuario:**
> Como **administrador del sistema**, quiero **monitorizar en tiempo real el estado del entrenamiento federado** para que **pueda detectar y resolver problemas rápidamente**.

---

#### **RF-007: Gestión Avanzada de Clientes**
> **Epic:** Client Lifecycle Management

**📝 Descripción:**
- Registrar nuevos clientes con identificador único y metadata del dispositivo.
- Sistema de reputación basado en calidad de actualizaciones.
- Capacidad de bloqueo temporal o permanente por comportamiento malicioso.

---

#### **RF-008: Almacenamiento Distribuido de Checkpoints**
> **Epic:** Data Persistence & Recovery

**📝 Descripción:**
- Guardar automáticamente checkpoints en S3-compatible con versionado.
- Recuperación automática ante fallos con point-in-time recovery.
- Compresión y deduplicación de checkpoints.

---

#### **RF-009: Interfaz Multi-Modal**
> **Epic:** User Experience

**📝 Descripción:**
- CLI para administradores técnicos con auto-completado.
- Dashboard web responsive para stakeholders no técnicos.
- API GraphQL para integraciones externas.

---

#### **RF-010: Adaptación de Recursos Edge**
> **Epic:** Edge Optimization

**📝 Descripción:**
- Detección automática de capacidades del dispositivo (RAM, CPU, GPU, TPU).
- Cuantización dinámica del modelo según recursos disponibles.
- Federación híbrida (edge + cloud) según conectividad de red.

---

#### **RF-014: Distribución Configurable de Datasets**
> **Epic:** Data Management & Experimentation  
> **Milestone:** M4 - Core Components MVP

**📝 Descripción:**
- Sistema para cargar datasets (CSV, JSON, Parquet) al broker/servidor desde cliente administrador.
- Distribución configurable de individuos del dataset entre clientes participantes (IID, Non-IID, Dirichlet, custom).
- Configuración de estrategias de particionado: random, stratified, temporal, geográfico, por features.
- API para definir splits personalizados y experimentos A/B con diferentes distribuciones.

**🎯 Historia de Usuario:**
> Como **investigador de ML**, quiero **subir un dataset CSV y distribuirlo de forma configurable entre los clientes** para que **pueda realizar experimentos controlados con diferentes tipos de heterogeneidad de datos**.

**⚙️ Historia de Desarrollador:**
> Como **data engineer**, necesito **implementar un sistema de particionado flexible con múltiples estrategias** para que **los investigadores puedan simular diferentes escenarios reales de distribución de datos**.

**✅ Criterios de Aceptación:**
- Upload de datasets en formatos CSV, JSON, Parquet hasta 10GB
- Al menos 5 estrategias de particionado: Random, Stratified, Dirichlet(α), Label-skewed, Feature-skewed
- API REST para configurar distribución con parámetros personalizables
- Dashboard web para visualizar distribución de datos por cliente
- Versionado automático de datasets y configuraciones de experimentos

---

#### **RF-015: Simulación de Heterogeneidad de Datos**
> **Epic:** Data Management & Experimentation  
> **Milestone:** M5 - Full Feature Implementation

**📝 Descripción:**
- Herramientas para simular diferentes tipos de heterogeneidad: estadística, de sistema, temporal.
- Generación de distribuciones Non-IID realistas basadas en papers de investigación (FedAvg, LEAF, etc.).
- Inyección configurable de ruido, outliers y missing values por cliente.
- Simulación de drift temporal y cambios de distribución durante el entrenamiento.
- Templates predefinidos para escenarios comunes (healthcare, IoT, finance).

**🎯 Historia de Usuario:**
> Como **investigador académico**, quiero **templates de heterogeneidad basados en literatura científica** para que **pueda reproducir y comparar resultados con papers existentes**.

**⚙️ Historia de Desarrollador:**
> Como **ML research engineer**, necesito **herramientas para generar heterogeneidad sintética realista** para que **los experimentos reflejen condiciones del mundo real**.

**✅ Criterios de Aceptación:**
- Al menos 10 templates de heterogeneidad predefinidos
- Configuración de parámetros Dirichlet(α) de 0.1 a 1.0
- Simulación de concept drift con ventanas temporales
- Inyección de ruido gaussiano y outliers por percentil
- Métricas de heterogeneidad automáticas (KL-divergence, Wasserstein distance)
- Exportación de configuraciones para reproducibilidad

---

### **Prioridad MEDIA** 🟡

#### **RF-005: Orquestación Inteligente de Rondas**
> **Epic:** Orchestration & Management

**📝 Descripción:**
- API REST/GraphQL para iniciar, detener o inspeccionar el estado de una ronda federada.
- Selección dinámica de clientes por disponibilidad, reputación, calidad de datos, latencia de red.
- Soporte para entrenamiento asíncrono y síncrono.

**🎯 Historia de Usuario:**
> Como **MLOps engineer**, quiero **orquestar rondas de entrenamiento con selección inteligente de clientes** para que **maximice la velocidad de convergencia del modelo**.

---

#### **RF-006: Observabilidad y Métricas Avanzadas**
> **Epic:** Monitoring & Analytics

**📝 Descripción:**
- Registrar métricas detalladas: número de clientes, pérdida global/local, tiempo de entrenamiento, throughput.
- Dashboard en tiempo real con Grafana/Prometheus.
- Alertas automáticas por anomalías (drift detection, Byzantine failures).

**🎯 Historia de Usuario:**
> Como **administrador del sistema**, quiero **monitorizar en tiempo real el estado del entrenamiento federado** para que **pueda detectar y resolver problemas rápidamente**.

---

#### **RF-007: Gestión Avanzada de Clientes**
> **Epic:** Client Lifecycle Management

**📝 Descripción:**
- Registrar nuevos clientes con identificador único y metadata del dispositivo.
- Sistema de reputación basado en calidad de actualizaciones.
- Capacidad de bloqueo temporal o permanente por comportamiento malicioso.

---

#### **RF-008: Almacenamiento Distribuido de Checkpoints**
> **Epic:** Data Persistence & Recovery

**📝 Descripción:**
- Guardar automáticamente checkpoints en S3-compatible con versionado.
- Recuperación automática ante fallos con point-in-time recovery.
- Compresión y deduplicación de checkpoints.

---

#### **RF-009: Interfaz Multi-Modal**
> **Epic:** User Experience

**📝 Descripción:**
- CLI para administradores técnicos con auto-completado.
- Dashboard web responsive para stakeholders no técnicos.
- API GraphQL para integraciones externas.

---

#### **RF-010: Adaptación de Recursos Edge**
> **Epic:** Edge Optimization

**📝 Descripción:**
- Detección automática de capacidades del dispositivo (RAM, CPU, GPU, TPU).
- Cuantización dinámica del modelo según recursos disponibles.
- Federación híbrida (edge + cloud) según conectividad de red.

---

#### **RF-014: Distribución Configurable de Datasets**
> **Epic:** Data Management & Experimentation  
> **Milestone:** M4 - Core Components MVP

**📝 Descripción:**
- Sistema para cargar datasets (CSV, JSON, Parquet) al broker/servidor desde cliente administrador.
- Distribución configurable de individuos del dataset entre clientes participantes (IID, Non-IID, Dirichlet, custom).
- Configuración de estrategias de particionado: random, stratified, temporal, geográfico, por features.
- API para definir splits personalizados y experimentos A/B con diferentes distribuciones.

**🎯 Historia de Usuario:**
> Como **investigador de ML**, quiero **subir un dataset CSV y distribuirlo de forma configurable entre los clientes** para que **pueda realizar experimentos controlados con diferentes tipos de heterogeneidad de datos**.

**⚙️ Historia de Desarrollador:**
> Como **data engineer**, necesito **implementar un sistema de particionado flexible con múltiples estrategias** para que **los investigadores puedan simular diferentes escenarios reales de distribución de datos**.

**✅ Criterios de Aceptación:**
- Upload de datasets en formatos CSV, JSON, Parquet hasta 10GB
- Al menos 5 estrategias de particionado: Random, Stratified, Dirichlet(α), Label-skewed, Feature-skewed
- API REST para configurar distribución con parámetros personalizables
- Dashboard web para visualizar distribución de datos por cliente
- Versionado automático de datasets y configuraciones de experimentos

---

#### **RF-015: Simulación de Heterogeneidad de Datos**
> **Epic:** Data Management & Experimentation  
> **Milestone:** M5 - Full Feature Implementation

**📝 Descripción:**
- Herramientas para simular diferentes tipos de heterogeneidad: estadística, de sistema, temporal.
- Generación de distribuciones Non-IID realistas basadas en papers de investigación (FedAvg, LEAF, etc.).
- Inyección configurable de ruido, outliers y missing values por cliente.
- Simulación de drift temporal y cambios de distribución durante el entrenamiento.
- Templates predefinidos para escenarios comunes (healthcare, IoT, finance).

**🎯 Historia de Usuario:**
> Como **investigador académico**, quiero **templates de heterogeneidad basados en literatura científica** para que **pueda reproducir y comparar resultados con papers existentes**.

**⚙️ Historia de Desarrollador:**
> Como **ML research engineer**, necesito **herramientas para generar heterogeneidad sintética realista** para que **los experimentos reflejen condiciones del mundo real**.

**✅ Criterios de Aceptación:**
- Al menos 10 templates de heterogeneidad predefinidos
- Configuración de parámetros Dirichlet(α) de 0.1 a 1.0
- Simulación de concept drift con ventanas temporales
- Inyección de ruido gaussiano y outliers por percentil
- Métricas de heterogeneidad automáticas (KL-divergence, Wasserstein distance)
- Exportación de configuraciones para reproducibilidad

---

## 🔒 Requisitos No Funcionales

### **Prioridad CRÍTICA** 🔴

| ID | Categoría | Requisito | Métrica Objetivo | Historia de Usuario | Historia de Desarrollador |
|----|-----------|-----------|------------------|-------------------|--------------------------|
| **RNF-001** | **Seguridad** | Cifrado TLS 1.3 en todas las comunicaciones con Perfect Forward Secrecy | 100% comunicaciones cifradas, rotación de claves cada 24h | Como **usuario final**, quiero que mis datos biomédicos estén protegidos por el cifrado más robusto disponible | Como **security engineer**, necesito implementar TLS 1.3 con certificados efímeros para máxima seguridad |
| **RNF-002** | **Privacidad** | Differential Privacy con ε ≤ 1.0 y Secure Aggregation | ε-privacy garantizada, k-anonymity ≥ 5 | Como **paciente**, quiero garantías matemáticas de que mis datos no pueden ser re-identificados | Como **privacy engineer**, necesito implementar DP con presupuesto de privacidad configurable |
| **RNF-003** | **Rendimiento Edge** | Latencia de inferencia < 100ms en dispositivos móviles | 95th percentile < 100ms en Raspberry Pi 4 | Como **usuario de aplicación móvil**, quiero detección de estrés en tiempo real sin lag perceptible | Como **mobile developer**, necesito optimizar el modelo para inferencia sub-100ms en ARM |
| **RNF-004** | **Eficiencia Energética** | Consumo de batería < 5% por sesión de entrenamiento | Training session ≤ 5% battery drain en smartphone promedio | Como **usuario móvil**, quiero que el entrenamiento federado no agote mi batería | Como **embedded developer**, necesito implementar power profiling y optimización de CPU/GPU |

### **Prioridad ALTA** 🟡

| ID | Categoría | Requisito | Métrica Objetivo | Historia de Usuario | Historia de Desarrollador |
|----|-----------|-----------|------------------|-------------------|--------------------------|
| **RNF-005** | **Escalabilidad** | Soporte para 1000+ clientes concurrentes con agregación distribuida | 1000 clientes simultáneos, latencia agregación < 2min | Como **administrador de sistema**, quiero escalar el sistema para miles de dispositivos IoT | Como **distributed systems engineer**, necesito implementar agregación jerárquica y sharding |
| **RNF-006** | **Disponibilidad** | 99.9% uptime con recuperación automática ante fallos | RTO < 30 segundos, RPO < 5 minutos | Como **stakeholder del negocio**, quiero que el sistema esté disponible 24/7 para investigación crítica | Como **SRE**, necesito implementar circuit breakers y graceful degradation |
| **RNF-007** | **Fiabilidad** | Tolerancia a Byzantine failures (hasta 30% clientes maliciosos) | Convergencia del modelo incluso con 30% Byzantine clients | Como **investigador ML**, quiero que el modelo converja incluso con dispositivos comprometidos | Como **ML engineer**, necesito implementar robust aggregation (Krum, Trimmed Mean) |
| **RNF-008** | **Latencia de Red** | Agregación federada completa < 5 minutos por ronda | 95th percentile < 5 minutos con 100 clientes | Como **data scientist**, quiero experimentos rápidos con feedback inmediato | Como **network engineer**, necesito optimizar protocolos y compresión de gradientes |

### **Prioridad MEDIA** 🟢

| ID | Categoría | Requisito | Métrica Objetivo | Historia de Usuario | Historia de Desarrollador |
|----|-----------|-----------|------------------|-------------------|--------------------------|
| **RNF-009** | **Portabilidad** | Soporte multi-plataforma (Linux, Windows, Android, iOS) | Binarios nativos para todas las plataformas objetivo | Como **desarrollador de aplicaciones**, quiero integrar FL en cualquier plataforma | Como **platform engineer**, necesito CI/CD cross-platform con testing automatizado |
| **RNF-010** | **Mantenibilidad** | Cobertura de tests > 90% y documentación completa | >90% test coverage, 100% API documentation | Como **nuevo desarrollador**, quiero entender y contribuir al código rápidamente | Como **tech lead**, necesito establecer estándares de calidad y tooling automatizado |
| **RNF-011** | **Observabilidad** | Trazabilidad distribuida completa y métricas en tiempo real | 100% requests traced, dashboards con latencia < 1s | Como **DevOps engineer**, quiero visibilidad completa del sistema distribuido | Como **observability engineer**, necesito implementar OpenTelemetry y alerting inteligente |
| **RNF-012** | **Extensibilidad** | Arquitectura plugin-based para algoritmos y optimizadores | APIs estables, nuevos algoritmos sin downtime | Como **investigador**, quiero probar nuevos algoritmos federados fácilmente | Como **software architect**, necesito diseñar interfaces pluggables y versionado de APIs |

### **Prioridad BAJA** 💙

| ID | Categoría | Requisito | Métrica Objetivo | Historia de Usuario | Historia de Desarrollador |
|----|-----------|-----------|------------------|-------------------|--------------------------|
| **RNF-013** | **Usabilidad** | CLI intuitivo y dashboard web responsive | Task completion rate > 95%, learning curve < 1 hora | Como **administrador no técnico**, quiero gestionar el sistema sin conocimiento profundo | Como **UX developer**, necesito diseñar interfaces intuitivas con user testing |
| **RNF-014** | **Cumplimiento** | Conformidad GDPR y FDA guidelines para dispositivos médicos | 100% compliance en audit, certificación FDA Class II | Como **compliance officer**, quiero garantías de cumplimiento regulatorio | Como **regulatory engineer**, necesito implementar controles de cumplimiento automatizados |
| **RNF-015** | **Interoperabilidad** | APIs estándar (REST, GraphQL) y formatos abiertos | 100% APIs documentadas en OpenAPI 3.0 | Como **integrador externo**, quiero APIs estándar para integraciones | Como **API developer**, necesito diseñar APIs RESTful siguiendo mejores prácticas |
| **RNF-016** | **Capacidad** | Soporte para modelos hasta 500MB y datasets de 10GB+ | Modelos < 500MB, datasets distribuidos > 10GB | Como **ML researcher**, quiero entrenar modelos grandes distribuidos | Como **storage engineer**, necesito implementar almacenamiento eficiente y caching |
| **RNF-017** | **Calidad de Código** | Cumplimiento estricto PEP8 y validación automática de código | 100% conformidad PEP8, 0 violations en pipeline | Como **tech lead**, quiero código consistente y mantenible siguiendo estándares de Python | Como **developer**, necesito herramientas automáticas que validen mi código según PEP8 antes del merge |
| **RNF-018** | **Documentación Automática** | Generación automática y versionado de documentación técnica | 100% APIs documentadas, docs actualizadas en <5min post-deploy | Como **developer nuevo**, quiero documentación siempre actualizada para entender APIs rápidamente | Como **devops engineer**, necesito pipeline que genere y publique docs automáticamente |
| **RNF-019** | **Code Quality Gates** | Quality gates automatizados con métricas de código | Code coverage >90%, complexity <10, duplication <3% | Como **project manager**, quiero garantías de que el código cumple estándares de calidad antes de producción | Como **quality engineer**, necesito gates automatizados que bloqueen merges de código de baja calidad |
| **RNF-020** | **Developer Experience** | Tooling y automation para productividad de desarrollo | Setup time <10min, build time <3min, hot reload <5s | Como **developer**, quiero herramientas que me permitan ser productivo inmediatamente | Como **platform team**, necesito crear experiencia de desarrollo frictionless con tooling automatizado |

---

## 🎯 Matriz de Priorización de Requisitos

### **Criterios de Priorización:**
1. **Impacto en el negocio** (1-5): ¿Qué tan crítico es para los objetivos del proyecto?
2. **Complejidad técnica** (1-5): ¿Qué tan difícil es de implementar?
3. **Dependencias** (1-5): ¿Cuántos otros requisitos dependen de este?
4. **Riesgo** (1-5): ¿Qué tan riesgoso es no implementarlo temprano?

| Requisito | Impacto | Complejidad | Dependencias | Riesgo | **Score** | Prioridad |
|-----------|---------|-------------|--------------|--------|-----------|-----------|
| RF-001 (Distribución Modelo) | 5 | 2 | 5 | 5 | **17** | 🔴 CRÍTICA |
| RF-002 (Entrenamiento Local) | 5 | 3 | 4 | 5 | **17** | 🔴 CRÍTICA |
| RF-003 (Comunicación Segura) | 5 | 4 | 3 | 5 | **17** | 🔴 CRÍTICA |
| RNF-001 (Seguridad TLS) | 5 | 3 | 4 | 5 | **17** | 🔴 CRÍTICA |
| RNF-002 (Differential Privacy) | 4 | 5 | 2 | 4 | **15** | 🟡 ALTA |
| RF-004 (Agregación Federada) | 4 | 4 | 3 | 3 | **14** | 🟡 ALTA |
| RF-004B (Selección Algoritmos ML) | 4 | 3 | 2 | 4 | **13** | 🟡 ALTA |
| RNF-017 (Calidad Código PEP8) | 3 | 2 | 4 | 4 | **13** | 🟡 ALTA |
| RNF-005 (Escalabilidad) | 3 | 4 | 2 | 3 | **12** | 🟢 MEDIA |
| RNF-018 (Documentación Auto) | 3 | 3 | 2 | 3 | **11** | 🟢 MEDIA |
| RF-011 (Generación Docs) | 3 | 3 | 2 | 2 | **10** | 🟢 MEDIA |
| RF-013 (SDK y CLI) | 4 | 4 | 1 | 1 | **10** | 🟢 MEDIA |
| RNF-019 (Quality Gates) | 2 | 3 | 3 | 3 | **11** | 🟢 MEDIA |
| RF-012 (Manual Usuario) | 2 | 2 | 1 | 2 | **7** | 💙 BAJA |
| RNF-020 (Developer Experience) | 2 | 3 | 1 | 2 | **8** | 💙 BAJA |

### **Orden de Implementación Alineado con Milestones:**
1. **M1 - Week 2 (Sprint 1)**: RF-001, RNF-017 (Foundation + Code Quality)
2. **M2 - Week 6 (Sprint 2-3)**: RF-002, RF-003, RNF-001 (Core Pipeline + Security)
3. **M3 - Week 8 (Sprint 4)**: RNF-018, RNF-019 (System Design + Quality Gates)
4. **M4 - Week 12 (Sprint 5-6)**: RF-004, RF-004B (Core MVP + ML Selection)
5. **M5 - Week 20 (Sprint 7-10)**: RF-013, RNF-005, RNF-006 (Full Features + SDK)
6. **M6 - Week 24 (Sprint 11)**: RNF-007, Performance Tuning (Testing & Hardening)
7. **M7 - Week 26 (Sprint 12)**: RF-011, RF-012, RNF-020 (Documentation & Delivery)

---

## 📚 Épicas y Backlog Estructurado

### **Epic 1: Core Federated Learning Pipeline** 🏗️
> **Objetivo:** Implementar el flujo básico de entrenamiento federado end-to-end
> **Business Value:** Funcionalidad core que permite el MVP del sistema
> **Duración Estimada:** 4 sprints

**Historias incluidas:**
- RF-001: Inicialización y Distribución del Modelo Global
- RF-002: Entrenamiento Local Adaptativo  
- RF-003: Comunicación Segura End-to-End
- RNF-001: Seguridad TLS 1.3

**Definition of Done:**
- [ ] Cliente puede recibir modelo global
- [ ] Cliente entrena localmente y envía actualizaciones
- [ ] Servidor agrega actualizaciones y publica nuevo modelo
- [ ] Todo el pipeline funciona con TLS 1.3
- [ ] Tests e2e automatizados ejecutándose

---

### **Epic 2: Edge Computing Optimization** ⚡
> **Objetivo:** Optimizar rendimiento para dispositivos con recursos limitados
> **Business Value:** Habilita despliegue en dispositivos IoT reales
> **Duración Estimada:** 3 sprints

**Historias incluidas:**
- RNF-003: Rendimiento Edge (< 100ms inferencia)
- RNF-004: Eficiencia Energética (< 5% batería)
- RF-004B: Selección y Evaluación de Algoritmos ML Locales
- RF-010: Adaptación de Recursos Edge
- Cuantización y compresión de modelos

**Definition of Done:**
- [ ] Inferencia < 100ms en Raspberry Pi 4
- [ ] Consumo batería < 5% por sesión entrenamiento
- [ ] Al menos 5 algoritmos ML disponibles con benchmarking automático
- [ ] Auto-selección de algoritmo óptimo basado en recursos
- [ ] Soporte cuantización INT8/FP16
- [ ] Benchmarks automatizados en CI

---

### **Epic 3: Security & Privacy** 🔒
> **Objetivo:** Garantizar privacidad y seguridad a nivel empresarial
> **Business Value:** Cumplimiento regulatorio y confianza del usuario
> **Duración Estimada:** 3 sprints

**Historias incluidas:**
- RNF-002: Differential Privacy (ε ≤ 1.0)
- RNF-007: Tolerancia Byzantine Failures
- RNF-014: Cumplimiento GDPR/FDA
- Secure Aggregation implementation

**Definition of Done:**
- [ ] DP implementado con presupuesto configurable
- [ ] Resistencia a 30% clientes maliciosos
- [ ] Auditoría de seguridad passed
- [ ] Documentación compliance completa

---

### **Epic 4: Distributed Learning Algorithms** 🧠
> **Objetivo:** Implementar algoritmos federados avanzados
> **Business Value:** Mejor convergencia y adaptabilidad a diferentes escenarios
> **Duración Estimada:** 2 sprints

**Historias incluidas:**
- RF-004: Agregación Federada Inteligente
- Algoritmos: FedAvg, FedProx, FedNova, SCAFFOLD
- RNF-012: Extensibilidad (plugin architecture)

**Definition of Done:**
- [ ] Factory pattern para algoritmos federados
- [ ] Al menos 3 algoritmos implementados
- [ ] Benchmarks comparativos automatizados
- [ ] Plugin API documentada

---

### **Epic 5: Orchestration & Management** 🎭
> **Objetivo:** Proporcionar herramientas de gestión y orquestación
> **Business Value:** Operabilidad y control del sistema en producción
> **Duración Estimada:** 2 sprints

**Historias incluidas:**
- RF-005: Orquestación Inteligente de Rondas
- RF-007: Gestión Avanzada de Clientes
- RF-009: Interfaz Multi-Modal
- Sistema de reputación de clientes

**Definition of Done:**
- [ ] API REST/GraphQL funcional
- [ ] Dashboard web responsive
- [ ] CLI con auto-completado
- [ ] Sistema reputación implementado

---

### **Epic 6: Monitoring & Analytics** 📊
> **Objetivo:** Observabilidad completa del sistema distribuido
> **Business Value:** Debugging, optimización y confiabilidad operacional
> **Duración Estimada:** 2 sprints

**Historias incluidas:**
- RF-006: Observabilidad y Métricas Avanzadas
- RNF-011: Trazabilidad distribuida
- Dashboards Grafana/Prometheus
- Alerting inteligente

**Definition of Done:**
- [ ] OpenTelemetry integrado
- [ ] Dashboards Grafana configurados
- [ ] Alertas automáticas funcionando
- [ ] SLA monitoring activo

---

### **Epic 7: Scalability & Reliability** 🚀
> **Objetivo:** Escalar a miles de clientes con alta disponibilidad
> **Business Value:** Preparación para producción y crecimiento
> **Duración Estimada:** 2 sprints

**Historias incluidas:**
- RNF-005: Escalabilidad (1000+ clientes)
- RNF-006: Disponibilidad (99.9% uptime)
- RF-008: Almacenamiento Distribuido de Checkpoints
- Arquitectura multi-region

**Definition of Done:**
- [ ] Load testing con 1000+ clientes
- [ ] Failover automático configurado
- [ ] Backup/restore automatizado
- [ ] Documentación deployment

---

### **Epic 8: Code Quality & Documentation** 📚
> **Objetivo:** Establecer estándares de calidad y documentación automática
> **Business Value:** Mantenibilidad, onboarding rápido y adopción del framework
> **Duración Estimada:** Transversal a todo el proyecto
> **Milestone:** M1, M3, M7

**Historias incluidas:**
- RNF-017: Calidad de Código PEP8
- RNF-018: Documentación Automática  
- RNF-019: Code Quality Gates
- RF-011: Generación Automática de Documentación
- RF-012: Manual de Usuario y Guías Operacionales
- RNF-020: Developer Experience

**Definition of Done:**
- [ ] Pipeline CI/CD con validación PEP8 automática
- [ ] Code coverage >90% en todos los módulos
- [ ] Documentación API auto-generada y publicada
- [ ] Manuales de usuario completos y actualizados
- [ ] SDK y CLI con experiencia de desarrollo optimizada
- [ ] Quality gates bloquean merges de código de baja calidad

---

### **Epic 9: User Experience & SDK** 🔧
> **Objetivo:** Crear experiencia de usuario excepcional para adopción masiva
> **Business Value:** Facilitar adopción y reducir curva de aprendizaje
> **Duración Estimada:** 2 sprints
> **Milestone:** M5, M7

**Historias incluidas:**
- RF-013: Framework SDK y CLI Avanzado
- RNF-020: Developer Experience
- Templates y quick-start guides
- IDE plugins y tooling

**Definition of Done:**
- [ ] SDK Python con API intuitiva y tipado completo
- [ ] CLI con >20 comandos y auto-completado
- [ ] Setup de desarrollo en <10 minutos
- [ ] Al menos 3 templates de proyectos funcionales
- [ ] Plugin VS Code con funcionalidades completas

---

## 🗓️ Product Backlog Priorizado (Alineado con Milestones)

### **Sprint 1: M1 - Project Foundation** (Semanas 1-2) 
**Milestone:** M1 - Project Kick-off & Specs Final

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RF-001 | Distribución del Modelo Global | 8 | P0 | Core FL Pipeline | M1 |
| RNF-017 | Setup PEP8 y Quality Gates | 5 | P1 | Code Quality | M1 |
| TECH-001 | Repo structure y CI/CD básico | 5 | P0 | Foundation | M1 |
| DOC-001 | Architecture Decision Records setup | 3 | P1 | Documentation | M1 |

**Sprint Goal:** "Fundación sólida del proyecto con estándares de calidad establecidos"

---

### **Sprint 2-3: M2 - Research & Core Implementation** (Semanas 3-6)
**Milestone:** M2 - Research & Feasibility Complete

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RF-002 | Entrenamiento Local Adaptativo | 13 | P0 | Core FL Pipeline | M2 |
| RF-003 | Comunicación Segura End-to-End | 8 | P0 | Security & Privacy | M2 |
| RNF-001 | Implementar TLS 1.3 | 8 | P0 | Security & Privacy | M2 |
| RESEARCH-001 | Algorithm & Dataset Selection | 5 | P0 | Research | M2 |

**Sprint Goal:** "Pipeline federado básico funcionando con comunicación segura"

---

### **Sprint 4: M3 - System Design & Quality** (Semanas 7-8)
**Milestone:** M3 - System Design Freeze

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RNF-018 | Documentación Automática Pipeline | 8 | P1 | Code Quality | M3 |
| RNF-019 | Quality Gates Implementation | 5 | P1 | Code Quality | M3 |
| DESIGN-001 | System Architecture Diagrams | 5 | P0 | System Design | M3 |
| DESIGN-002 | Data Flow & API Specifications | 5 | P0 | System Design | M3 |

**Sprint Goal:** "Arquitectura del sistema finalizada con quality gates operativos"

---

### **Sprint 5-6: M4 - Core MVP Implementation** (Semanas 9-12)
**Milestone:** M4 - Core Components MVP

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RF-004 | Agregación Federada (FedAvg) | 13 | P0 | Distributed Learning | M4 |
| RF-004B | Selección Algoritmos ML Locales | 13 | P1 | Edge Optimization | M4 |
| RNF-003 | Optimización Edge Performance | 8 | P1 | Edge Optimization | M4 |
| TEST-001 | Tests e2e automatizados | 8 | P0 | Foundation | M4 |

**Sprint Goal:** "MVP completo con agregación federada y selección automática de algoritmos ML"

---

### **Sprint 7-10: M5 - Full Feature Implementation** (Semanas 13-20)
**Milestone:** M5 - Full Feature Implementation

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RF-013 | Framework SDK y CLI Avanzado | 21 | P1 | User Experience | M5 |
| RNF-005 | Escalabilidad 1000+ clientes | 13 | P1 | Scalability | M5 |
| RNF-006 | Alta Disponibilidad | 8 | P1 | Scalability | M5 |
| RF-005 | Orquestación de Rondas | 8 | P1 | Orchestration | M5 |
| RF-006 | Monitoring Avanzado | 8 | P1 | Monitoring | M5 |

**Sprint Goal:** "Sistema completo con SDK, alta disponibilidad y herramientas de gestión"

---

### **Sprint 11: M6 - Testing & Hardening** (Semanas 21-24)
**Milestone:** M6 - Testing & Hardening

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RNF-002 | Differential Privacy | 13 | P1 | Security & Privacy | M6 |
| RNF-007 | Byzantine Fault Tolerance | 13 | P1 | Security & Privacy | M6 |
| PERF-001 | Performance Optimization | 8 | P1 | Edge Optimization | M6 |
| SEC-001 | Security Audit | 5 | P1 | Security & Privacy | M6 |

**Sprint Goal:** "Sistema production-ready con seguridad enterprise y performance optimizado"

---

### **Sprint 12: M7 - Documentation & Delivery** (Semanas 25-26)
**Milestone:** M7 - Documentation & Delivery

| ID | Historia | Story Points | Prioridad | Épica | Milestone |
|----|----------|--------------|-----------|-------|-----------|
| RF-011 | Generación Automática Documentación | 8 | P1 | Documentation | M7 |
| RF-012 | Manual Usuario Completo | 8 | P1 | Documentation | M7 |
| RNF-020 | Developer Experience Optimization | 5 | P2 | User Experience | M7 |
| DELIVERY-001 | Final Demos & Handover | 5 | P0 | Delivery | M7 |

**Sprint Goal:** "Documentación completa, demos finales y entrega del proyecto"

---

### **Sprint 3-4: Core Aggregation & ML Selection** (Semanas 5-8)
**Objetivo:** Agregación federada completa y selección de algoritmos ML

| ID | Historia | Story Points | Prioridad | Épica |
|----|----------|--------------|-----------|-------|
| RF-004 | Agregación FedAvg | 8 | P0 | Distributed Learning |
| RF-004B | Selección Algoritmos ML Locales | 8 | P1 | Edge Optimization |
| RF-003 | Comunicación MQTT Segura | 5 | P0 | Core FL Pipeline |
| RNF-003 | Optimización Edge Performance | 8 | P1 | Edge Optimization |
| TEST-001 | Tests e2e automatizados | 5 | P0 | Foundation |

**Sprint Goal:** "Tenemos agregación federada funcionando con selección automática de algoritmos ML óptimos por dispositivo"

---

### **Sprint 5-6: Advanced Features** (Semanas 9-12)
**Objetivo:** Características avanzadas de FL

| ID | Historia | Story Points | Prioridad | Épica |
|----|----------|--------------|-----------|-------|
| RNF-002 | Differential Privacy | 13 | P1 | Security & Privacy |
| RF-005 | Orquestación de Rondas | 8 | P1 | Orchestration |
| RNF-004 | Optimización Energética | 8 | P1 | Edge Optimization |
| ALG-001 | Implementar FedProx | 5 | P2 | Distributed Learning |

**Sprint Goal:** "Sistema con privacidad diferencial y gestión inteligente de rondas"

---

### **Sprint 7-8: Scalability** (Semanas 13-16)
**Objetivo:** Preparación para escala de producción

| ID | Historia | Story Points | Prioridad | Épica |
|----|----------|--------------|-----------|-------|
| RNF-005 | Escalabilidad 1000+ clientes | 13 | P1 | Scalability |
| RNF-006 | Alta Disponibilidad | 8 | P1 | Scalability |
| RF-006 | Monitoring Avanzado | 8 | P1 | Monitoring |
| OPS-001 | Deployment Kubernetes | 5 | P1 | Foundation |

**Sprint Goal:** "Sistema escalable y con observabilidad completa"

---

### **Sprint 9-10: User Experience** (Semanas 17-20)
**Objetivo:** Interfaces de usuario y gestión

| ID | Historia | Story Points | Prioridad | Épica |
|----|----------|--------------|-----------|-------|
| RF-009 | Dashboard Web | 8 | P2 | Orchestration |
| RF-007 | Gestión de Clientes | 5 | P2 | Orchestration |
| RNF-013 | CLI Intuitivo | 5 | P2 | User Experience |
| DOC-001 | Documentación Usuario | 3 | P1 | Foundation |

**Sprint Goal:** "Herramientas completas de gestión y administración"

---

### **Sprint 11-12: Hardening** (Semanas 21-24)
**Objetivo:** Producción-ready y compliance

| ID | Historia | Story Points | Prioridad | Épica |
|----|----------|--------------|-----------|-------|
| RNF-007 | Byzantine Fault Tolerance | 13 | P1 | Security & Privacy |
| RNF-014 | Compliance GDPR/FDA | 8 | P2 | Security & Privacy |
| PERF-001 | Performance Optimization | 8 | P1 | Edge Optimization |
| SEC-001 | Security Audit | 5 | P1 | Security & Privacy |

**Sprint Goal:** "Sistema production-ready con certificaciones de seguridad"

---

## 🔧 Task Breakdown Detallado por Componente

### **1. FL-Client (Edge Agent)** 📱

#### **1.1 Core Client Infrastructure**
- **1.1.1** Implementar cliente MQTT con TLS mutual auth
  - Librerías: `paho-mqtt`, `cryptography`
  - Configuración cert rotation automática
  - **DoD:** Cliente conecta seguro y mantiene conexión estable
  
- **1.1.2** Sistema de configuración jerárquica
  - Config por defecto < environment < archivo < CLI args
  - Validación con `pydantic` schemas
  - **DoD:** Cliente configurable sin recompilación

- **1.1.3** Device profiling y resource monitoring
  - CPU, RAM, storage, battery monitoring en tiempo real
  - Adaptar training config basado en recursos
  - **DoD:** Cliente adapta automáticamente su comportamiento

#### **1.2 Local Training Engine**
- **1.2.1** Motor ML multi-framework
  - Soporte PyTorch, TensorFlow Lite, scikit-learn
  - Factory pattern para algoritmos
  - **DoD:** Plug-and-play de modelos sin código core

- **1.2.2** Data preprocessing pipeline
  - Sliding window para series temporales
  - Feature engineering automático para sensores biométricos
  - **DoD:** Pipeline procesa datos WESAD/SWEET sin intervención

- **1.2.3** Federated optimization
  - Local SGD con gradient compression
  - Adaptive learning rate basado en device capabilities
  - **DoD:** Entrenamiento eficiente en Raspberry Pi

- **1.2.4** Sistema de benchmarking y selección de algoritmos
  - Framework de evaluación automática con métricas estandarizadas
  - Implementación de 5+ algoritmos: CNN, Random Forest, XGBoost, SVM, Logistic Regression
  - Auto-benchmarking al inicializar cliente con profiling de performance
  - API para switching dinámico de algoritmos durante runtime
  - Dashboard local para comparativa de algoritmos en tiempo real
  - **DoD:** Cliente puede auto-seleccionar algoritmo óptimo basado en recursos y datos

- **1.2.5** Performance metrics & analytics
  - Tracking de accuracy, F1-score, precision, recall por algoritmo
  - Métricas de resource utilization (CPU, RAM, battery, latency)
  - Logging estructurado para análisis posterior
  - Integration con sistema de observabilidad distribuida
  - **DoD:** Métricas completas disponibles para decisiones de optimización

#### **1.3 Privacy & Security**
- **1.3.1** Differential Privacy local
  - Gaussian noise injection configurable
  - Privacy budget tracking
  - **DoD:** DP garantizado con ε ≤ 1.0

- **1.3.2** Secure gradient sharing
  - Gradient quantization y compression
  - Homomorphic encryption para agregación
  - **DoD:** Gradientes no revelan datos raw

---

### **2. FL-Broker (Message Router)** 🔄

#### **2.1 Message Routing Infrastructure**
- **2.1.1** MQTT broker con clustering
  - Eclipse Mosquitto con HA setup
  - Topic-based routing optimizado
  - **DoD:** 1000+ clientes concurrentes sin degradación

- **2.1.2** gRPC bidirectional streaming
  - Protocol Buffers para model serialization
  - Streaming para modelos grandes (>100MB)
  - **DoD:** Latencia < 100ms para updates pequeños

#### **2.2 Partial Aggregation**
- **2.2.1** Micro-batch aggregation
  - Agregar gradientes en batches de 10-50 clientes
  - Backpressure management
  - **DoD:** Agregación incremental sin memory leaks

- **2.2.2** Quality-based client selection
  - Scoring basado en data quality, latency, availability
  - Adaptive sampling rates
  - **DoD:** Selección mejora convergencia vs random

#### **2.3 Fault Tolerance**
- **2.3.1** Message persistence & replay
  - Redis Streams para message durability
  - Automatic retry con exponential backoff
  - **DoD:** Zero message loss incluso con broker restart

- **2.3.2** Circuit breaker pattern
  - Fail-fast cuando client/server no responden
  - Graceful degradation modes
  - **DoD:** Sistema estable incluso con 50% failures

---

### **3. FL-Server (Global Aggregator)** 🎯

#### **3.1 Aggregation Algorithms**
- **3.1.1** Multi-algorithm support
  - FedAvg, FedProx, FedNova, SCAFFOLD
  - Plugin architecture para nuevos algoritmos
  - **DoD:** Cambio de algoritmo sin downtime

- **3.1.2** Byzantine-robust aggregation
  - Krum, Trimmed Mean, Median agregación
  - Outlier detection y client reputation
  - **DoD:** Convergencia con 30% Byzantine clients

#### **3.2 Model Lifecycle Management**
- **3.2.1** Model versioning & checkpointing
  - Semantic versioning automático
  - S3-compatible storage con deduplicación
  - **DoD:** Point-in-time recovery para cualquier versión

- **3.2.2** A/B testing infrastructure
  - Parallel model training con diferentes configs
  - Statistical significance testing automático
  - **DoD:** Comparación objetiva de algoritmos federados

#### **3.3 Orchestration API**
- **3.3.1** REST API con OpenAPI spec
  - CRUD operations para rounds, clients, models
  - Authentication con JWT + RBAC
  - **DoD:** API auto-documentada y testeable

- **3.3.2** GraphQL subscription interface
  - Real-time updates de training progress
  - Flexible querying para dashboards
  - **DoD:** Dashboard se actualiza en tiempo real

---

### **4. FL-Common (Shared Libraries)** 📚

#### **4.1 Protocol Definitions**
- **4.1.1** Protocol Buffers schemas
  - Messages para ModelUpdate, AggregatedUpdate, etc.
  - Backward/forward compatibility
  - **DoD:** Schemas soportan rolling updates

- **4.1.2** Crypto primitives
  - TLS certificate management
  - Key derivation functions
  - **DoD:** Implementación crypto review approved

#### **4.2 Utilities & Helpers**
- **4.2.1** Logging & telemetry
  - Structured logging con OpenTelemetry
  - Distributed tracing para request flows
  - **DoD:** Full request traceability across components

- **4.2.2** Testing framework
  - Simulación de redes edge con latencia/drops
  - Chaos engineering para fault injection
  - **DoD:** Tests reproducibles que simulan condiciones reales

---

### **5. FL-ML-Models (Algorithm Hub)** 🧠

#### **5.1 Stress Detection Models**
- **5.1.1** Time-series CNN para señales biométricas
  - 1D convolutions para ECG, GSR, temperature
  - Attention mechanism para features relevantes
  - **DoD:** F1-score > 85% en WESAD dataset

- **5.1.2** Ensemble methods
  - Random Forest + XGBoost para features engineered
  - Voting classifier con confidence weighting
  - **DoD:** Model size < 10MB para mobile deployment

#### **5.2 Model Optimization**
- **5.2.1** Quantization pipeline
  - Post-training quantization INT8
  - Quantization-aware training para mejor accuracy
  - **DoD:** <2% accuracy loss con 4x size reduction

- **5.2.2** Neural Architecture Search
  - AutoML