# Example for AWS Lambda w/ Docker

> Build a **Continuous Integration** and **Continuous Deployment** setup for **AWS Lambda with Docker** images using **GitHub Actions**. Together with [Semantic Releases](https://semver.org/) and [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), you can focus on writing your code.

## Workflows

Everything runs with [GitHub Actions](https://github.com/features/actions).

### Semantic Version

Every push on `main` branch will trigger the **GitHub Action** in `version.yml` to create a new `git tag` and [GitHub Release](/sbstjn/aws-lambda-docker-node/releases) based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Deployment

Every new [GitHub Release](/sbstjn/aws-lambda-docker-node/releases) will trigger the GitHub Action in `deployment.yml` to build and tag the current Docker image. The image will pushed to the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/).

### Release

Using [GitHub Deployments](/sbstjn/aws-lambda-docker-node/deployments), the AWS Lambda function is updated using **GitHub Action** in `release.yml` after a new image is pushed to the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/).

## Infrastructure

First, create a repository using the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/). A \*\*CloudFormation Template` is included with all needed resources.

```bash
# Create and ECR repository
$ > make deploy-infrastructure
```
