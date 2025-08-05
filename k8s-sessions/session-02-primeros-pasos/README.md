# Sesión 2: Primeros Pasos con Kubernetes

## 🎯 Objetivos de esta Sesión
- Instalar y configurar kubectl
- Configurar un cluster local (minikube/kind)
- Aprender comandos básicos de kubectl
- Realizar tu primer deployment completo

## 📚 Contenido

### 1. Instalación de kubectl

#### En Linux:
```bash
# Descargar kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Hacer ejecutable
chmod +x kubectl

# Mover a PATH
sudo mv kubectl /usr/local/bin/

# Verificar instalación
kubectl version --client
```

#### En macOS:
```bash
# Con Homebrew
brew install kubectl

# Verificar instalación
kubectl version --client
```

#### En Windows:
```powershell
# Con Chocolatey
choco install kubernetes-cli

# O descargar desde la web oficial
# https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
```

### 2. Configuración de Cluster Local

#### Opción 1: Minikube
```bash
# Instalar minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Iniciar cluster
minikube start

# Verificar estado
minikube status

# Abrir dashboard
minikube dashboard
```

#### Opción 2: Kind (Kubernetes in Docker)
```bash
# Instalar kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Crear cluster
kind create cluster

# Verificar
kubectl cluster-info
```

### 3. Comandos Básicos de kubectl

#### Información del Cluster
```bash
# Ver información del cluster
kubectl cluster-info

# Ver nodos
kubectl get nodes

# Ver todos los recursos
kubectl get all

# Ver recursos en un namespace específico
kubectl get all -n kube-system
```

#### Gestión de Recursos
```bash
# Crear recursos desde archivo YAML
kubectl apply -f archivo.yaml

# Ver recursos
kubectl get pods
kubectl get services
kubectl get deployments

# Describir un recurso
kubectl describe pod <nombre-pod>

# Ver logs
kubectl logs <nombre-pod>

# Ejecutar comandos en un pod
kubectl exec -it <nombre-pod> -- /bin/bash
```

#### Escalado y Actualizaciones
```bash
# Escalar un deployment
kubectl scale deployment <nombre> --replicas=5

# Actualizar imagen
kubectl set image deployment/<nombre> <contenedor>=<nueva-imagen>

# Ver historial de rollout
kubectl rollout history deployment/<nombre>

# Revertir a versión anterior
kubectl rollout undo deployment/<nombre>
```

### 4. Primer Deployment Completo

Vamos a crear una aplicación web completa con frontend y backend.

## 🛠️ Ejercicios Prácticos

### Ejercicio 1: Configurar tu entorno
1. Instala kubectl según tu sistema operativo
2. Instala minikube o kind
3. Inicia un cluster local
4. Verifica que todo funcione: `kubectl get nodes`

### Ejercicio 2: Aplicación Web Completa
1. Crea los archivos YAML para una aplicación web
2. Despliega la aplicación
3. Configura un service para acceder
4. Escala la aplicación
5. Actualiza la aplicación

### Ejercicio 3: Troubleshooting
1. Identifica problemas comunes
2. Usa comandos de debugging
3. Resuelve errores típicos

## 📝 Comandos Útiles

```bash
# Ver configuración actual
kubectl config current-context

# Cambiar contexto
kubectl config use-context <contexto>

# Ver todos los contextos
kubectl config get-contexts

# Ver configuración completa
kubectl config view

# Autocompletado (añadir a .bashrc)
source <(kubectl completion bash)
```

## 🎯 Próximos Pasos
En la siguiente sesión aprenderemos:
- Gestión avanzada de recursos
- ConfigMaps y Secrets
- Networking y Services
- Persistencia de datos

## 📚 Recursos Adicionales
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Kind Documentation](https://kind.sigs.k8s.io/)