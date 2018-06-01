ifndef ENV
    $(error ENV is undefined, options: dev, uat, qa, engprod, stage, prod)
endif

%-plan: .terraform/terraform.tfstate
	terraform plan \
		-var-file=backend/$(ENV).tfvars \
		-var-file=env/$(ENV).tfvars \
		-out $(*).plan

%-apply: %.plan
	terraform apply $(*).plan

%-plandestroy: .terraform/terraform.tfstate
	terraform plan \
		-var-file=backend/$(ENV).tfvars \
		-var-file=env/$(ENV).tfvars \
		-destroy -out $(*)-destroy.plan

%-destroy: %-destroy.plan
	terraform apply $(*)-destroy.plan

plan: $(ENV)-plan

apply: $(ENV)-apply

plandestroy: $(ENV)-plandestroy

destroy: $(ENV)-destroy clean

.terraform:
	mkdir .terraform
	tfenv install
	terraform get

.terraform/terraform.tfstate: .terraform
	terraform init \
		-backend-config=backend/$(ENV).tfvars \
		-var-file=env/$(ENV).tfvars

clean:
	rm -f *.plan
	rm -rf .terraform

.PHONY: clean %-apply
