NAME = aws-lambda-docker-node
AWS_REGION = sa-east-1
VERSION ?= dev

deploy-infrastructure:
	@ aws cloudformation deploy \
		--template-file ./aws/infrastructure.yml \
		--capabilities CAPABILITY_IAM \
		--region $(AWS_REGION) \
		--stack-name $(NAME)-infrastructure \
		--force-upload \
		--parameter-overrides \
			Name=$(NAME)

describe-infrastructure:
	@ aws cloudformation describe-stacks --stack-name $(NAME)-infrastructure \
		--region $(AWS_REGION) \
		$(if $(value QUERY), --query "$(QUERY)",) \
		$(if $(value FORMAT), --output "$(FORMAT)",)

outputs-%:
	@ QUERY="(Stacks[0].Outputs[?OutputKey=='$*'].OutputValue)[0]" \
		FORMAT=text \
		$(MAKE) describe-infrastructure

login: REPOSITORY_HOST=`make outputs-RepositoryHost`
login:
	@ aws ecr get-login-password --region sa-east-1 | docker login -u "AWS" --password-stdin "$(REPOSITORY_HOST)"

build: REPOSITORY_NAME=`make outputs-RepositoryName`
build: REPOSITORY_HOST=`make outputs-RepositoryHost`
build:
	@ docker build . -t $(REPOSITORY_NAME):$(VERSION)
	@ docker tag $(REPOSITORY_NAME):$(VERSION) $(REPOSITORY_HOST)/$(REPOSITORY_NAME):$(VERSION)
	@ docker push $(REPOSITORY_HOST)/$(REPOSITORY_NAME):$(VERSION)
