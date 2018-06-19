ifndef ENV
    $(error ENV is undefined, options: dev, uat, qa, engprod, stage, prod)
endif

%-plan: $(ENV).tfstate
	terraform plan \
		-var-file=../env/$(ENV).tfvars \
		-state=$(ENV).tfstate

%-apply: %-plan
	terraform apply -auto-approve \
		-var-file=../env/$(ENV).tfvars \
 		-state=$(ENV).tfstate

%-plandestroy: %-init
	terraform plan -destroy \
		-var-file=../env/$(ENV).tfvars \
		-state=$(ENV).tfstate

%-destroy: %-plandestroy
	terraform destroy -auto-approve \
		-var-file=../env/$(ENV).tfvars \
		-state=$(ENV).tfstate

%-init: .terraform %.tfstate
	terraform init \
		-var-file=../env/$(ENV).tfvars \
		-backend-config=$(ENV).tfstate

init: $(ENV)-init

plan: $(ENV)-plan

apply: $(ENV)-apply

plandestroy: $(ENV)-plandestroy

destroy: $(ENV)-destroy clean

.terraform:
	mkdir .terraform
	tfenv install
	terraform get

%.tfstate: .terraform
	terraform init \
		-var-file=../env/$(ENV).tfvars

clean:
	rm -rf .terraform

.PHONY: clean %-apply
