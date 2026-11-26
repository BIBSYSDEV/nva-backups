# NVA cross-account backups

This repository holds IaC resources related to cross-account backups for NVA services, where these resources do not belong to a specific service or environment.

## Usage

First-time setup:

0. Create a new GitHub connection in the backup account (must be done by a GitHub organization owner).
1. Ask someone with access to the AWS Organization to create a new AWS account for backups.
    - This account needs both `AWS RAM` and `Cross-account backups` enabled.
2. Manually create a new CloudFormation stack in the backup account with the `templates/pipeline.yml` template.
3. Create the AWS Backup service-linked role in the backup account with `aws iam create-service-linked-role --aws-service-name backup.amazonaws.com`, unless it already exists.
    The deploy role has no IAM permissions, so it cannot create the role when the first vault is deployed.
4. Deploy the new backup vaults from `CodePipeline`.

The pipeline does not deploy `templates/pipeline.yml` itself, so update that stack manually after merging changes to it.

## Pipeline

The pipeline deploys `templates/template.yml` from the merged commit to each environment.
It has no build stage, so no third-party code runs between the commit and the deploy.
The deploy role has no IAM permissions and the deploy actions pass no IAM capability, so `templates/template.yml` cannot declare IAM resources.
The deploy role can only manage backup vaults named after the pipeline stack, and RAM shares of those vaults that do not allow external principals.
Adding another resource type to `templates/template.yml` therefore also needs new permissions on `DeployStackRole` in `templates/pipeline.yml`.

The GitHub workflow in `.github/workflows/lint.yml` lints the templates with cfn-lint on every pull request, before changes reach `main`.

## Development

Run cfn-lint from the repository root.
It reads the templates to lint from `.cfnlintrc.yaml`, so it checks the same files as the workflow.

```shell
cfn-lint
```
