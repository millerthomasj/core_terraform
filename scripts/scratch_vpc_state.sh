#!/bin/bash

terraform remote config -backend=s3 -backend-config="bucket=eos-terraform-state" -backend-config="key=scratch.vpc.tfstate" -backend-config="region=us-west-1" -backend-config="profile=scratch"
