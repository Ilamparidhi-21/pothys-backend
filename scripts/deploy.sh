#!/bin/bash
set -e

kubectl create namespace staging \
--dry-run=client -o yaml | kubectl apply -f -

sed -i "s|image: .*cms-service.*|image: $ECR_REPO:$IMAGE_TAG|g" \
apps/cms-service/k8s/deployment.yaml

kubectl apply \
-f apps/cms-service/k8s \
-n staging

echo "Deployment completed."
