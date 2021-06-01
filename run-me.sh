#!/bin/bash

#just good practise
set -euo pipefail

tools=(
    "minikube"
    "docker"
    "kubectl"
)

is_tools_installed() {
    for t in "${tools[@]}"; do
        if [ -x "$(command -v ${t})" ]; then
            echo "==${t} installed=="
        else
            echo "==${t} is not installed, it should be=="
            echo "==exiting"
            exit 1
        fi
    done

}

is_minikube_up() {
    if [[ $(minikube status) =~ Running ]]; then
        echo "==minikube up and running, I hope so..=="
    elif [[ $(minikube status) =~ Stopped ]]; then
        echo "==minikube stoped, maybe we need to start it=="
        minikube start || exit 1
    else
        echo "==smth wrong, exiting=="
        exit 1
    fi
}

lets_build_image() {
    #point to local docker env
    eval "$(minikube docker-env)"
    docker build -t sawasy-http-server-tbd . || exit 1
}

deploy_manifest() {
    kubectl apply -f all-in-one-manifest.yml
}

cleanup() {
    kubectl delete -f all-in-one-manifest.yml
    docker rmi sawasy-http-server-tbd
    
}

main() {
    case "${1:-}" in
      deploy)
        is_tools_installed
        is_minikube_up
        lets_build_image
        deploy_manifest
        ;;
      cleanup)
        cleanup
        ;;
      *)
        echo "Unsupported command: $*. Use deploy or cleanup" >&2
        exit 1
      ;;
    esac
    exit 0
}

main "$@"
