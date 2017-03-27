kops create cluster \
  --name=kubernetes.scratch.eos.local \
  --state=s3://eos-terraform-state/core/kubernetes \
  --dns-zone=scratch-charter.net \
  --zones=us-west-1a \
  --out=. \
  --target=terraform

#kops delete cluster \
#  --name=kubernetes.scratch.eos.local \
#  --state=s3://eos-terraform-state/core/kubernetes \
#  --yes
