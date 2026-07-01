#!/bin/bash
set -e

kubectl rollout status deployment/cms-service \
-n staging \
--timeout=180s

echo

kubectl get pods -n staging

echo

kubectl get svc -n staging
