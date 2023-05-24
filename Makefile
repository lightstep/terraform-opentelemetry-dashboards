
ready: fmt gen

# generate the root module: main.tf, variables.tf, outputs.tf and README.md
gen:
	go run tools/generaterootmod.go

fmt:
	terraform fmt -recursive
	gofmt -w -s ./tools

check:
	terraform fmt -check -recursive
	tflint --config .tflint.hcl --recursive

# warning - this will destroy you terraform state file
clean:
	rm -rf .terraform*

init:
	terraform init

apply:
	terraform apply \
		-var="lightstep_organization=LightStep" \
		-var="lightstep_env=staging" \
		-var="lightstep_project=dev-integrations" \
		-var="lightstep_api_key_env_var=LIGHTSTEP_API_KEY"

fresh: destroy clean init apply

destroy:
	terraform destroy \
		-var="lightstep_organization=LightStep" \
		-var="lightstep_env=staging" \
		-var="lightstep_project=dev-integrations" \
		-var="lightstep_api_key_env_var=LIGHTSTEP_API_KEY"


