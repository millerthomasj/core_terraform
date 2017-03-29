ENVIRONMENT ?= production
BUCKET ?= eos-terraform-state
REGION ?= us-west-1
STACK ?= core
ENV := $(shell git rev-parse --abbrev-ref HEAD)

%-plan: *.tfvars .terraform/terraform.tfstate
	terraform plan -var-file=$(ENV).tfvars -out $(*).plan

%-apply: %.plan
	terraform apply $(*).plan

%-destroy: *.tfvars .terraform
	terraform plan -destroy -var-file=$(ENV).tfvars -out $(*).plan
	terraform apply $(*).plan

plan: $(ENVIRONMENT)-plan

apply: $(ENVIRONMENT)-apply

destroy: $(ENVIRONMENT)-destroy clean

.terraform:
	mkdir .terraform
	terraform get

.terraform/terraform.tfstate: .terraform
	terraform remote config -backend=s3 -backend-config="bucket=$(BUCKET)" -backend-config="key=$(STACK)/$(ENVIRONMENT).tfstate" -backend-config="region=$(REGION)"

k8sdestroy:
	kops delete cluster \
           --name $(shell terraform output k8s_cluster_name) \
           --state $(shell terraform output k8s_state_store) \
           --yes

k8sedit:
	kops edit cluster \
           --name $(shell terraform output k8s_cluster_name) \
           --state $(shell terraform output k8s_state_store) \

k8svalidate:
	kops validate cluster \
           --name $(shell terraform output k8s_cluster_name) \
           --state $(shell terraform output k8s_state_store) \

k8screate:
	kops create cluster \
           --zones $(shell terraform output availability_zones) \
           --master-zones $(shell terraform output k8s_master_zone) \
           --node-count $(shell terraform output k8s_node_count) \
           --node-size $(shell terraform output k8s_node_size) \
           --master-size $(shell terraform output k8s_master_size) \
           --dns-zone $(shell terraform output dns_zone) \
           --name $(shell terraform output k8s_cluster_name) \
           --state $(shell terraform output k8s_state_store) \
           --vpc $(shell terraform output vpc_id) \
           --kubernetes-version $(shell terraform output k8s_version) \
           --topology private \
           --networking weave \
           --cloud-labels "Project=EOS" \
           --bastion \

k8s:
	kops update cluster \
           --name $(shell terraform output k8s_cluster_name) \
           --state $(shell terraform output k8s_state_store) \
           --yes

clean:
	rm -f *.plan
	rm -rf .terraform

.PHONY: clean %-apply
