REGION_scratch = us-west-1
REGION_dev = us-west-2
DNS_scratch = scratch-charter.net
DNS_dev = dev-charter.net
BUCKET = eos.terraform.state
ENV := $(shell git rev-parse --abbrev-ref HEAD)

%-plan: .terraform/terraform.tfstate
	terraform plan \
          -var-file=$(ENV).tfvars \
          -out $(*).plan
	@echo
	@echo "Run the following to set your kubectl environment properly."
	@echo "export KUBECONFIG=~/.kube/config-$(ENV)"

%-apply: %.plan
	terraform apply $(*).plan

%-destroy: .terraform
	terraform plan \
          -var-file=$(ENV).tfvars \
          -destroy -out $(*).plan
	terraform apply $(*).plan

plan: $(ENV)-plan

apply: $(ENV)-apply

destroy: $(ENV)-destroy clean

.terraform:
	mkdir .terraform
	terraform get

.terraform/terraform.tfstate: .terraform
	terraform init \
          -backend-config="profile=$(ENV)" \
          -backend-config="region=$(REGION_$(ENV))" \
          -backend-config="bucket=$(BUCKET)"

clean:
	rm -f *.plan
	rm -rf .terraform

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

.PHONY: clean %-apply
