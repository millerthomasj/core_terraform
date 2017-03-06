#!/bin/bash

# Usage: ./init.sh once to initialize remote storage for this environment.
# Subsequent tf actions in this environment don't require re-initialization, 
# unless you have completely cleared your .terraform cache.
#
# terraform plan  -var-file=./production.tfvars 
# terraform apply -var-file=./production.tfvars 

tf_env=$(printenv | grep ENVIRONMENT)

if [ $? -ne 0 ] ; then
   echo "The environment variable ENVIRONMENT is not set as one of the following:"
   echo "   - scratch"
   echo "   - development"
   echo "   - staging"
   echo "   - production"
   exit 1
fi

region="us-west-1"


terraform remote config -backend=s3 \
                        -backend-config="bucket=eos-terraform-state" \
                        -backend-config="key=$tf_env.tfstate" \
                        -backend-config="region=$region"

echo "set remote s3 state to $tf_env.tfstate"
