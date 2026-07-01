#!/bin/bash
set -e

echo "Building Docker Image..."

docker build \
-f apps/cms-service/Dockerfile \
-t $ECR_REPO:$IMAGE_TAG .

echo "Docker build completed."
