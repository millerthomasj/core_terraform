ENVIRONMENT = $(shell git rev-parse --abbrev-ref HEAD)
REGION = $(shell grep region $(ENVIRONMENT).tfvars | cut -d'=' -f2 | sed -e 's/"//g' -e 's/ //g')
STACK := core

include $(CURDIR)/../base.mk
