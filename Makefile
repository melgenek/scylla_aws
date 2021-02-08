SHELL = /bin/sh

UID := $(shell id -u)
GID := $(shell id -g)

prepare_docker:
	docker build -t eks_scylla_deployer -f Dockerfile .

run_terraform:
	docker run -it \
		-e AWS_PROFILE="$(aws_profile)" \
 		-u ${UID}:${GID} \
 		-w /home/${USER} \
		-v ~/.aws/:/home/${USER}/.aws:ro \
		-v ~/.ssh/:/home/${USER}/.ssh:ro \
	   	-v /etc/group:/etc/group:ro \
		-v /etc/passwd:/etc/passwd:ro \
		-v /etc/shadow:/etc/shadow:ro \
		-v `pwd`:/home/${USER} \
		--rm --entrypoint /bin/sh eks_scylla_deployer -c "$(command)"

init: command=cd cluster && terraform init
init: aws_profile=default
init: run_terraform

create_cluster: command=cd cluster && terraform apply
create_cluster: aws_profile=default
create_cluster: run_terraform

destroy_cluster: command=cd cluster && terraform destroy
destroy_cluster: aws_profile=default
destroy_cluster: run_terraform
