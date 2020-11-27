NAME = aws-lambda-docker-node
AWS_REGION = sa-east-1

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