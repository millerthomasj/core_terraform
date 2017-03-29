# Build EOS Environment

cd global
make
make apply

cd environments
git checkout -b <branch to build>
git pull
make
make apply
make k8screate
make k8sedit
  - This will pull up the kubernetes config in your EDITOR
  - Modify the subnets section like below:
      subnets:
      - cidr: 10.0.101.0/24
        id: subnet-d238b18a
        name: us-west-1a
        egress: nat-08db5580a9d32f480
        type: Private
        zone: us-west-1a
      - cidr: 10.0.102.0/24
        id: subnet-36e09e52
        name: us-west-1b
        egress: nat-00a70468095814249
        type: Private
        zone: us-west-1b
      - cidr: 10.0.1.0/24
        id: subnet-b13bb2e9
        name: utility-us-west-1a
        type: Utility
        zone: us-west-1a
      - cidr: 10.0.2.0/24
        id: subnet-46e29c22
        name: utility-us-west-1b
        type: Utility
        zone: us-west-1b
make k8s
make k8s validate (this will take 5 minutes or so to work properly)
