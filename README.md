# Example for AWS Lambda w/ Docker

## Workflows

### Semantic Releases

Using GitHub Actions, every push on `main` branch will trigger the configured action in `semantic-release.yml` and create a new `git tag` or [GitHub Release](releases) based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Deploy Docker Images

Using GitHub Actions, every new [GitHub Release](releases) will trigger the configured action in `deployment.yml` to build and tag the current Docker image. The image will be tagged with the current release and pushed to the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/).

## Infrastructure

First, create a repository using the [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/). A \*\*CloudFormation Template` is included with all needed resources.

```bash
# Create and ECR repository
$ > make deploy-infrastructure
```
