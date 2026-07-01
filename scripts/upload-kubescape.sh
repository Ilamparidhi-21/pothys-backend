#!/bin/bash
set -e

curl -X POST \
"$DEFECTDOJO_URL/api/v2/import-scan/" \
-H "Authorization: Token $DD_TOKEN" \
-F "scan_type=Kubescape" \
-F "engagement=$ENGAGEMENT_ID" \
-F "active=true" \
-F "verified=false" \
-F "file=@reports/kubescape.json"

echo "Kubescape report uploaded."
