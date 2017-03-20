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

clean:
	rm -f *.plan
	rm -rf .terraform

.PHONY: clean %-apply
