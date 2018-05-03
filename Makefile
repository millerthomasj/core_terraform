ifndef ENV
    $(error ENV is undefined, options: scratch, dev, engprod, stage, prod)
endif


init:
	terraform init -backend-config=env/$(ENV).tfvars

plan:
	terraform plan -var-file='env/$(ENV).tfvars' -var-file='env/$(ENV)-params.tfvars' -out=$(ENV).plan

apply:
	terraform apply $(ENV).plan

clean:
	rm -Rf *.plan
	rm -Rf .terraform

