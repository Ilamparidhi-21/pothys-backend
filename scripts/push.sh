#!/bin/bash
set -e

echo "Logging into ECR..."

aws ecr get-login-password --region $AWS_REGION | \
docker login --username AWS --password-stdin $ECR_REPO

echo "Building image..."

docker build -t $ECR_REPO:$IMAGE_TAG .

echo "Pushing image..."

docker push $ECR_REPO:$IMAGE_TAG

echo "Image pushed successfully."
