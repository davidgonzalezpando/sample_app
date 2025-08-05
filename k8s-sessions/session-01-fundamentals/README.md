# Sesión 1: Fundamentos de Kubernetes

## 🎯 Objetivos de esta Sesión
- Comprender qué son los contenedores y por qué los necesitamos
- Entender la arquitectura de Kubernetes
- Conocer los componentes principales
- Aprender los conceptos básicos: Pods, Services, Deployments

## 📚 Contenido

### 1. Introducción a Contenedores y Docker

#### ¿Qué son los contenedores?
Los contenedores son unidades de software que empaquetan código y todas sus dependencias para que la aplicación se ejecute de manera rápida y confiable de un entorno informático a otro.

**Ventajas de los contenedores:**
- **Portabilidad**: Funciona igual en cualquier entorno
- **Eficiencia**: Menor uso de recursos que VMs
- **Aislamiento**: Cada contenedor es independiente
- **Escalabilidad**: Fácil de replicar y escalar

#### Docker Básico
```bash
# Crear una imagen
docker build -t mi-aplicacion .

# Ejecutar un contenedor
docker run -d -p 8080:80 mi-aplicacion

# Ver contenedores en ejecución
docker ps

# Ver logs
docker logs <container-id>
```

### 2. Arquitectura de Kubernetes

#### Componentes del Master Node
- **API Server**: Punto de entrada para todas las operaciones
- **etcd**: Base de datos distribuida que almacena toda la información del cluster
- **Scheduler**: Asigna pods a nodos
- **Controller Manager**: Mantiene el estado deseado del cluster

#### Componentes del Worker Node
- **kubelet**: Agente que se ejecuta en cada nodo
- **kube-proxy**: Maneja la comunicación de red
- **Container Runtime**: Docker, containerd, etc.

### 3. Conceptos Básicos

#### Pods
Un Pod es la unidad más pequeña en Kubernetes. Puede contener uno o más contenedores.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mi-pod
spec:
  containers:
  - name: mi-contenedor
    image: nginx:latest
    ports:
    - containerPort: 80
```

#### Services
Un Service expone una aplicación que se ejecuta en un conjunto de Pods.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mi-service
spec:
  selector:
    app: mi-aplicacion
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: ClusterIP
```

#### Deployments
Un Deployment proporciona actualizaciones declarativas para Pods y ReplicaSets.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mi-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mi-aplicacion
  template:
    metadata:
      labels:
        app: mi-aplicacion
    spec:
      containers:
      - name: mi-contenedor
        image: nginx:latest
        ports:
        - containerPort: 80
```

## 🛠️ Ejercicios Prácticos

### Ejercicio 1: Crear tu primer Pod
1. Crea un archivo `mi-primer-pod.yaml` con el contenido del ejemplo de Pod
2. Aplica el archivo: `kubectl apply -f mi-primer-pod.yaml`
3. Verifica que el Pod esté ejecutándose: `kubectl get pods`
4. Accede al Pod: `kubectl port-forward mi-pod 8080:80`

### Ejercicio 2: Crear un Deployment
1. Crea un archivo `mi-deployment.yaml` con el contenido del ejemplo de Deployment
2. Aplica el archivo: `kubectl apply -f mi-deployment.yaml`
3. Verifica el estado: `kubectl get deployments`
4. Escala el deployment: `kubectl scale deployment mi-deployment --replicas=5`

### Ejercicio 3: Crear un Service
1. Crea un archivo `mi-service.yaml` con el contenido del ejemplo de Service
2. Aplica el archivo: `kubectl apply -f mi-service.yaml`
3. Verifica el service: `kubectl get services`
4. Accede al service: `kubectl port-forward service/mi-service 8080:80`

## 📝 Comandos Útiles

```bash
# Ver todos los recursos
kubectl get all

# Ver logs de un pod
kubectl logs <pod-name>

# Ejecutar comandos en un pod
kubectl exec -it <pod-name> -- /bin/bash

# Describir un recurso
kubectl describe pod <pod-name>

# Ver eventos
kubectl get events

# Eliminar recursos
kubectl delete -f <archivo.yaml>
```

## 🎯 Próximos Pasos
En la siguiente sesión aprenderemos:
- Instalación y configuración de kubectl
- Configuración de un cluster local
- Comandos básicos de kubectl
- Primer deployment completo

## 📚 Recursos Adicionales
- [Documentación oficial de Kubernetes](https://kubernetes.io/docs/)
- [Kubernetes by Example](https://kubernetesbyexample.com/)
- [Play with Kubernetes](https://labs.play-with-k8s.com/)