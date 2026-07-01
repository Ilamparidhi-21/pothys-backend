#!/bin/bash
set -e

echo "=============================="
echo "Running Kubescape"
echo "=============================="

mkdir -p reports

kubescape scan framework nsa \
apps/cms-service/k8s \
--format json \
--output reports/kubescape.json || true

kubescape scan framework nsa \
apps/cms-service/k8s \
--format pretty \
--output reports/kubescape.txt || true

echo "Kubescape completed."

ls -lh reports
