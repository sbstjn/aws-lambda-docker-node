# Example CI/CD for AWS Lambda w/ Docker

> Build a **Continuous Integration** and **Continuous Deployment** setup for **AWS Lambda** functions with **Docker** images using **GitHub Actions**. Together with [Semantic Releases](https://semver.org/) and [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), you can focus on writing your code. Automation takes care everything else.

## Configuration

You need to configure these environment variables as GitHub secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `CUSTOM_GITHUB_TOKEN`

## Workflows

Everything runs with [GitHub Actions](https://github.com/features/actions).

### Semantic Version

> on: push: branches: ["main"]

Every push on `main` branch triggers the [GitHub Action](https://github.com/sbstjn/aws-lambda-docker-node/actions) in [`version.yml`](.github/workflows/version.yml) to create a new [GitHub Release](https://github.com/sbstjn/aws-lambda-docker-node/releases) based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Deployment

> on: release: types: ['created']

Every new [GitHub Release](https://github.com/sbstjn/aws-lambda-docker-node/releases) triggers the [GitHub Action](https://github.com/sbstjn/aws-lambda-docker-node/actions) in [`deployment.yml`](.github/workflows/deployment.yml) to build the Docker image and upload the tagged image to the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/). Afterwards, a new [GitHub Deployment](https://github.com/sbstjn/aws-lambda-docker-node/deployments) is created.

### Release

> on: deployment_status

Using [GitHub Deployments](https://github.com/sbstjn/aws-lambda-docker-node/deployments), the [GitHub Action](https://github.com/sbstjn/aws-lambda-docker-node/actions) in [`release.yml`](.github/workflows/release.yml) updates the AWS Lambda function to use the updated Docker image.

## Infrastructure

First, create a new repository using the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/). The CloudFormation template in [`infrastructure.yml`](aws/infrastructure.yml) includes all needed resources.

```bash
# Configure Amazon Elastic Container Registry

$ > AWS_REGION=eu-central-1 \
    make deploy-infrastructure
```

## Notes

Per default, GitHub configures an access token for every action run. When using the default token, an action cannot trigger any other actions. Therefore, a custom GitHub Token is needed for using the GitHub API.
