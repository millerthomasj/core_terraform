#!/bin/bash

cat >/etc/ecs/ecs.config <<FINISH
ECS_CLUSTER=${clustername}
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
FINISH

yum install -y aws-cli
yum install -y python27-pip
yum update -y ecs-init
yum install -y bind-utils
yum -y update
