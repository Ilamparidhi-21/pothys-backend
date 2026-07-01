#!/bin/bash
set -e

echo "Logging into ECR..."

: "${AWS_REGION:?AWS_REGION is NOT set}"
: "${ECR_REPO:?ECR_REPO is NOT set}"
: "${IMAGE_TAG:?IMAGE_TAG is NOT set}"

echo "Using ECR_REPO=$ECR_REPO"
echo "Using IMAGE_TAG=$IMAGE_TAG"

aws ecr get-login-password --region "$AWS_REGION" | \
docker login --username AWS --password-stdin "$ECR_REPO"

echo "Building image..."

docker build -t "$ECR_REPO:$IMAGE_TAG" .

echo "Pushing image..."

docker push "$ECR_REPO:$IMAGE_TAG"

echo "Image pushed successfully."
