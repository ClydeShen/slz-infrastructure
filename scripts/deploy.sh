#!/usr/bin/env bash

set -e
BLUE='\033[34m'
NC='\033[0m' # No Color

echo "Running ${BLUE}terraform init${NC}"
terraform init -var-file=terraform.tfvars

echo "Running ${BLUE}terraform plan${NC}"
terraform plan -var-file=terraform.tfvars -out=plan.out

echo "Running ${BLUE}terraform apply${NC}"
terraform apply "plan.out"