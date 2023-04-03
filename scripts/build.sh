#!/usr/bin/env bash

set -e

# Define colors
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'
NC='\033[0m' # No Color


echo "Running ${BLUE}terraform init${NC}"
terraform init
echo "Running ${BLUE}terraform plan${NC}"
terraform plan -out=plan.out