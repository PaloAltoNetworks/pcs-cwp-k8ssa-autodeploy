#!/usr/bin/bash
#Generate Console TOKEN
CONSOLE_TOKEN=$(curl -k ${COMPUTE_API_ENDPOINT}/api/v1/authenticate -X POST -H "Content-Type: application/json" -d '{
  "username":"'"$PRISMA_USERNAME"'",
  "password":"'"$PRISMA_PASSWORD"'"
  }'  | grep -Po '"'"token"'"\s*:\s*"\K([^"]*)')

#Deploy defender
curl -k ${CONSOLE_URL}/api/v1/deployment/daemonsets/deploy -H 'Content-Type: application/json' -H "Authorization: Bearer $CONSOLE_TOKEN" -d '{
  "consoleAddr":"'"$CONSOLE_ADDRESS"'",
  "namespace": "'"$NAMESPACE"'", 
  "containerRuntime": "containerd",
  "orchestration": "kubernetes",
  "credentialID": "'"$CREDENTIAL_ID"'",
  "privileged": false, 
  "serviceAccounts": true, 
  "istio": false, 
  "collectPodLabels": true, 
  "proxy": null, 
  "taskName": null
}'
