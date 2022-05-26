#!/bin/sh

while ! kustomize build manifests/example | kubectl apply -f -; do 
    echo "Retrying to apply resources"
    sleep 10
done

# Path pipelines
kubectl get destinationrules.networking.istio.io -n kubeflow ml-pipeline -o yaml | sed 's/ISTIO_MUTUAL/DISABLE/g' | kubectl replace -f -
kubectl get destinationrules.networking.istio.io -n kubeflow ml-pipeline-ui -o yaml | sed 's/ISTIO_MUTUAL/DISABLE/g' | kubectl replace -f -

