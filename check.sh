#!/bin/bash

# Format the files
echo "Formatting..."
rain fmt ./infrastructure/pipeline.yml -w
rain fmt ./template.yml -w

# Check all template files
echo "Running cfn-lint..."
cfn-lint ./infrastructure/**/*.yml
cfn-lint ./template.yml

echo "Running cfn-nag..."
cfn_nag_scan --input-path ./infrastructure
cfn_nag_scan --input-path ./template.yml
