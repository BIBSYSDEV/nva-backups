#!/bin/bash

# Format the files
echo "Formatting..."
rain fmt ./templates/pipeline.yml -w
rain fmt ./templates/stack_test.yml -w

# Check all template files
echo "Running cfn-lint..."
cfn-lint ./templates/**/*.yml
#cfn-lint ./template.yml

echo "Running cfn-nag..."
cfn_nag_scan --input-path ./templates
