#!/bin/bash
set -e

echo "=============================="
echo "Running Trivy"
echo "=============================="

mkdir -p reports

trivy image \
    --format json \
    -o reports/trivy-report.json \
    $ECR_REPO:$IMAGE_TAG || true

trivy image \
    --format table \
    -o reports/trivy-report.txt \
    $ECR_REPO:$IMAGE_TAG || true

echo "Trivy scan completed."

ls -lh reports
