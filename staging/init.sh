#!/bin/bash

BACKEND="s3"
BUCKET="eos-terraform-state"
ENV="staging"

echo "Setting remote config for $ENV."
terraform remote config \
    -backend=$BACKEND \
    -backend-config="bucket=$BUCKET" \
    -backend-config="key=$ENV.tfstate" \
    -backend-config="profile=$ENV"
