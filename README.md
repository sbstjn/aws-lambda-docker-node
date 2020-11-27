# Example for AWS Lambda w/ Docker

## Workflows

### Semantic Releases

Every push on `main` branch will trigger the **GitHub Action** in `semantic-release.yml` and create a new `git tag` and [GitHub Release](/sbstjn/aws-lambda-docker-node/releases) based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Deployment

Every new [GitHub Release](/sbstjn/aws-lambda-docker-node/releases) will trigger the GitHub Action in `deployment.yml` to build and tag the current Docker image. The image will pushed to the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/).

### Release

After the tagged image is pushed to [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/), the AWS Lambda function is updated.

## Infrastructure

First, create a repository using the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/). A \*\*CloudFormation Template` is included with all needed resources.

```bash
# Create and ECR repository
$ > make deploy-infrastructure
```
