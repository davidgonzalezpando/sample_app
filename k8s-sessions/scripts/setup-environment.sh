#!/bin/bash

# Script para configurar el entorno de Kubernetes
# Autor: Sesiones Didácticas de K8s
# Versión: 1.0

set -e

echo "🚀 Configurando entorno de Kubernetes..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar si kubectl está instalado
check_kubectl() {
    if command -v kubectl &> /dev/null; then
        print_success "kubectl ya está instalado"
        kubectl version --client
    else
        print_warning "kubectl no está instalado. Instalando..."
        install_kubectl
    fi
}

# Instalar kubectl
install_kubectl() {
    print_status "Instalando kubectl..."
    
    # Detectar sistema operativo
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        chmod +x kubectl
        sudo mv kubectl /usr/local/bin/
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install kubectl
        else
            print_error "Homebrew no está instalado. Por favor instala Homebrew primero."
            exit 1
        fi
    else
        print_error "Sistema operativo no soportado"
        exit 1
    fi
    
    print_success "kubectl instalado correctamente"
}

# Verificar si minikube está instalado
check_minikube() {
    if command -v minikube &> /dev/null; then
        print_success "minikube ya está instalado"
    else
        print_warning "minikube no está instalado. Instalando..."
        install_minikube
    fi
}

# Instalar minikube
install_minikube() {
    print_status "Instalando minikube..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        rm minikube-linux-amd64
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install minikube
        else
            print_error "Homebrew no está instalado. Por favor instala Homebrew primero."
            exit 1
        fi
    fi
    
    print_success "minikube instalado correctamente"
}

# Iniciar cluster
start_cluster() {
    print_status "Iniciando cluster de Kubernetes..."
    
    if minikube status | grep -q "Running"; then
        print_success "Cluster ya está ejecutándose"
    else
        minikube start --driver=docker
        print_success "Cluster iniciado correctamente"
    fi
    
    # Verificar estado
    kubectl cluster-info
    kubectl get nodes
}

# Configurar alias útiles
setup_aliases() {
    print_status "Configurando alias útiles..."
    
    # Crear archivo de alias si no existe
    if [ ! -f ~/.k8s-aliases ]; then
        cat > ~/.k8s-aliases << 'EOF'
# Alias útiles para Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kctx='kubectl config current-context'
alias kctxs='kubectl config get-contexts'
alias kuse='kubectl config use-context'
alias ktop='kubectl top nodes'
alias ktp='kubectl top pods'
EOF
        print_success "Alias creados en ~/.k8s-aliases"
        print_warning "Para usar los alias, ejecuta: source ~/.k8s-aliases"
    else
        print_success "Alias ya existen"
    fi
}

# Instalar herramientas adicionales
install_tools() {
    print_status "Instalando herramientas adicionales..."
    
    # Verificar si helm está instalado
    if ! command -v helm &> /dev/null; then
        print_warning "Instalando Helm..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install helm
        fi
    fi
    
    # Verificar si kubectx está instalado
    if ! command -v kubectx &> /dev/null; then
        print_warning "Instalando kubectx..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
            sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
            sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install kubectx
        fi
    fi
}

# Función principal
main() {
    echo "🔧 Iniciando configuración del entorno de Kubernetes..."
    
    check_kubectl
    check_minikube
    start_cluster
    setup_aliases
    install_tools
    
    echo ""
    print_success "✅ Entorno configurado correctamente!"
    echo ""
    echo "📋 Próximos pasos:"
    echo "1. Ejecuta: source ~/.k8s-aliases"
    echo "2. Verifica el cluster: kubectl get nodes"
    echo "3. Abre el dashboard: minikube dashboard"
    echo "4. Comienza con las sesiones didácticas"
    echo ""
    echo "🎯 ¡Listo para aprender Kubernetes!"
}

# Ejecutar función principal
main "$@"