#!/bin/bash
set -e

echo "=============================="
echo "Running SonarQube Scan"
echo "=============================="

mkdir -p reports

sonar-scanner \
  -Dsonar.projectKey=pothys-backend \
  -Dsonar.projectName=pothys-backend \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=$SONAR_TOKEN

echo "SonarQube scan completed."
