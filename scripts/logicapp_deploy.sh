#!/bin/bash
# Deploy or update Logic App workflows
set -e

RESOURCE_GROUP=${RESOURCE_GROUP:-atiato-rg}
LOGIC_APP_NAME=${LOGIC_APP_NAME:-translation-logic-app}
WORKFLOW_FILE=logic-apps/translation/sample_workflow.json

az logic workflow create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$LOGIC_APP_NAME" \
  --definition @$WORKFLOW_FILE \
  --location "$(az group show --name $RESOURCE_GROUP --query location -o tsv)"
