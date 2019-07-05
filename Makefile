ifndef ENV
  $(error ENV is undefined, options: dev, uat, qa, engprod, stage, prod)
endif

plan: $(ENV)-plan

refresh: $(ENV)-refresh

apply: $(ENV)-apply

plandestroy: $(ENV)-plandestroy

destroy: $(ENV)-destroy clean

%-plan: .terraform/terraform.tfstate
ifneq (,$(filter stage prod,$(ENV)))
	[[ -e bastion.tf ]] && mv bastion.tf bastion.no
endif
	terraform plan \
		-var-file=backend/$(*).tfvars \
		-var-file=env/$(*).tfvars \
		-out $(*).plan

%-refresh:
	terraform refresh \
		-var-file=backend/$(*).tfvars \
		-var-file=env/$(*).tfvars

%-apply: %.plan
	terraform apply $(*).plan

%-plandestroy: .terraform/terraform.tfstate
	terraform plan \
		-var-file=backend/$(*).tfvars \
		-var-file=env/$(*).tfvars \
		-destroy -out $(*)-destroy.plan

%-destroy: %-destroy.plan
	terraform apply $(*)-destroy.plan

.terraform/terraform.tfstate: .terraform
ifeq ($(ENV),prod)
	vault login -address=https://vault.portals.$(ENV).local -method=aws header_value=portals.spectrum.net role=jenkins_jnlp_slave
else
	vault login -address=https://vault.portals.$(ENV).local -method=aws header_value=portals.$(ENV)-spectrum.net role=jenkins_jnlp_slave
endif
	
	terraform init \
		-backend-config=backend/$(ENV).tfvars \
		-var-file=env/$(ENV).tfvars

.terraform:
	mkdir .terraform
	tfenv install
	terraform get

clean:
ifneq (,$(filter stage prod,$(ENV)))
	rm -f bastion.no
	git checkout -- bastion.tf
endif
	rm -f *.plan
	rm -f *.backup
	rm -rf .terraform

.PHONY: clean %-apply
