#!/bin/bash

# Usage: ./init.sh once to initialize remote storage for this environment.
# Subsequent tf actions in this environment don't require re-initialization, 
# unless you have completely cleared your .terraform cache.
#
# terraform plan  -var-file=./production.tfvars 
# terraform apply -var-file=./production.tfvars 

tf_env="development"
region="us-west-1"

terraform remote config -backend=s3 \
                        -backend-config="bucket=hound-terraform-state" \
                        -backend-config="key=$tf_env.tfstate" \
                        -backend-config="region=$region"

echo "set remote s3 state to $tf_env.tfstate"
