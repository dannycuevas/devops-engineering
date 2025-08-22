
Kubernetes is a perfect “visual guide” for application architecture. Here’s a simple mapping from **architecture concepts** to **K8s primitives**, plus a tiny end-to-end example.

# Map: Architecture → Kubernetes

| Architecture concept                             | What it means                                             | Kubernetes “equivalent” (most useful mental model)                                                                                                                             |
| ------------------------------------------------ | --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Object (class/instance)**                      | Code-level building blocks                                | **Container process** inside a **Pod**                                                                                                                                         |
| **Component**                                    | Encapsulated, replaceable unit you can deploy             | **Deployment** (manages identical Pods) + its **Container Image** + Pod spec (optionally a **StatefulSet** for stateful components, or **DaemonSet** for node-wide components) |
| **Component interface (API)**                    | Contract other parts call                                 | **Kubernetes Service (ClusterIP)** as the stable DNS name + the app’s HTTP/gRPC API exposed by Pods                                                                            |
| **Service (business capability / microservice)** | Independently deployable unit that solves a business need | A **bundle**: _Deployment/StatefulSet_ + **Service** (stable address) + **ConfigMap/Secret** + **HPA** + (optionally) **Ingress/Gateway**, **PVC** (if it owns data)           |
| **Service discovery & load-balancing**           | How callers find healthy instances                        | **Service** (L4 VIP + kube-proxy) + cluster DNS (`svc-name.namespace.svc.cluster.local`)                                                                                       |
| **Edge routing / API gateway**                   | Route external traffic to internal services               | **Ingress** (with an Ingress Controller) or **Gateway API**                                                                                                                    |
| **Configuration**                                | Externalized settings                                     | **ConfigMap** (non-secret) and **Secret** (sensitive) mounted/env-injected into Pods                                                                                           |
| **Persistence / Backing service**                | Databases, queues, etc.                                   | **StatefulSet + PVC** (state **inside** cluster) or **External Service** (managed DB/queue) referenced by **Secret/ConfigMap**                                                 |
| **Scaling**                                      | Match capacity to demand                                  | **HPA** (pods), **VPA** (resources), **Cluster Autoscaler** (nodes)                                                                                                            |
| **Resilience**                                   | Health checks, self-healing                               | Pod `liveness`/`readiness`/`startup` probes, **Deployment** rollouts, **PodDisruptionBudget**, retries/timeouts at app or **service mesh** level                               |
| **Observability**                                | Logs, metrics, traces                                     | **DaemonSet** (e.g., Fluent Bit) for logs, **ServiceMonitor/PodMonitor** (Prometheus), **OpenTelemetry** sidecars/agents                                                       |
| **Composition / release unit**                   | How you ship and wire components                          | **Helm chart** / **Kustomize overlay** / **Operator (CRDs + controller)**                                                                                                      |
| **Bounded context / team boundary**              | Scope & policy boundary                                   | **Namespace** (+ **RBAC**, **NetworkPolicy**, **ResourceQuota**)                                                                                                               |

⚠️ Note: **Kubernetes Service** (network primitive) ≠ **Business Service** (microservice). In this guide, a _microservice_ is typically: **Deployment + Service + config + policies**.

# Tiny end-to-end example: “credit-check” service (microservice)

- **Component (runtime):**
    
    - **Deployment** `credit-check` → runs 3 Pods of the `company/credit-check:1.4.2` image
        
    - **Liveness/Readiness** probes on `/healthz`
        
- **Stable interface:**
    
    - **Service** `credit-check` (ClusterIP) → `credit-check.default.svc.cluster.local:8080`
        
- **External access (optional):**
    
    - **Ingress** routes `https://api.example.com/credit` → Service `credit-check:8080`
        
- **Config & secrets:**
    
    - **ConfigMap** `credit-check-config` (timeouts, feature flags)
        
    - **Secret** `credit-check-creds` (API key to external bureau)
        
- **Scaling:**
    
    - **HPA** targets 50% CPU, min 3, max 10 replicas
        
- **Persistence (if needed):**
    
    - **StatefulSet + PVC** for its own store (or just connect to a managed DB via Secret)
        
- **Observability:**
    
    - Logs via Fluent Bit **DaemonSet**, metrics scraped by Prometheus **ServiceMonitor**
        

Inspect it quickly:
```bash
kubectl get deploy,svc,hpa,ingress,configmap,secret -l app=credit-check
```

# Quick “what should I use?” cheats

- **Stateless component** → **Deployment** + **Service**
    
- **Needs stable identity/storage** → **StatefulSet** + **PVC**
    
- **Expose to other services** → **Service (ClusterIP)**
    
- **Expose to internet** → **Ingress / Gateway**
    
- **Auto-scale** → **HPA** (pods), **Cluster Autoscaler** (nodes)
    
- **Team boundary / policies** → **Namespace + RBAC + NetworkPolicy**
    
- **Package & promote** → **Helm/Kustomize**
    
- **Custom domain logic as API** → consider a **CRD + Operator** (controller) to make it declarative

