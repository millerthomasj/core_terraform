ifndef ENV
    $(error ENV is undefined, options: dev, enguat, engqa, engprod, stage, prod)
endif


init:
	sed -e 's/ENV/$(ENV)/' provider.tpl > provider.tf
	terraform init -backend-config=backends/$(ENV).tfvars

plan:
	terraform plan -var-file=env/$(ENV).tfvars -out=$(ENV).plan

apply:
	terraform apply $(ENV).plan

destroy:
	terraform destroy -var-file=env/$(ENV).tfvars

clean:
	rm -Rf *.plan
	rm -Rf .terraform

