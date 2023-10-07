# [`build-push-image.yaml`](.github/workflows/build-push-image.yaml)

GitHub Actions workflow to build and push Docker image to AWS ECR and Quay.

## Requirements

If using AWS ECR, the repository need to exist prior to pushing.
If it doesn't, the workflow will fail, in this case, run the following command from some adminVM in `cdistest`:

```bash
aws ecr create-repository --repository-name "<repo name>"
```

## Inputs

The inputs are described in the [workflow definition](.github/workflows/build-push-image.yaml).

## Usage

Usage is straightforward, here is an example workflow that can be used in most repositories without any modification (outside of `DOCKER_IMAGE_NAME` and `DOCKERFILE_LOCATION`, if needed).

```yaml
name: Build Image and Push to Quay

on: push

jobs:
  ci:
    name: Build Image and Push to Quay
    uses: uc-cdis/.github/.github/workflows/build-push-image.yaml@fix/new-version
    with:
      DOCKER_IMAGE_PLACE: "/gen3/"
      USE_QUAY: false
    secrets: inherit
```

## Difference to old worflow

The old workflow is actively used, but have limited maintability and configuration.

This is a refactoring of an old workflow, that will ease the migration and usage in the future.

Nice new things:

* More streamlined configuration, everything is defined and configured in one step "Set Environmental Variables" and all other steps will reuse environmental variables from it.
* More configuration, now it supports publishing to either AWS ECR, Quay, both or neither, and extending to support extra container registries is trivial and will require only login step and extending `TAGS` to include that registry.
* Better support for AWS ECR in terms of structuring, old workflow only supported pushing into `/gen3/` which is not the best structure for Docker images.
* Cleaner & shorter code with minimal dependencies between steps.
* Clear migration path: just define a new workflow in the repository and disable old one.
* Clear migration path to AWS ECR only, the old workflow required a lot of code to support both use cases (AWS ECR only and backward compatibility).
