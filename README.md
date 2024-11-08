# NVA cross-account backups

This repository holds IaC resources related to cross-account backups for NVA services, where these resources do not belong to a specific service or environment.

## Usage

First-time setup:

0. Create a new GitHub connection in the backup account (must be done by a GitHub organization owner).
1. Ask someone with access to the AWS Organization to create a new AWS account for backups.
    - This account needs both `AWS RAM` and `Cross-account backups` enabled.
2. Manually create a new CloudFormation stack in the backup account with the `infrastructure/pipeline.yml` template.
3. Deploy the new backup vaults from `CodePipeline`.

## Development

Example commands for running static analysis tools:

```shell
cfn-lint ./infrastructure/**/*.yml
cfn_nag_scan --input-path ./infrastructure
rain fmt ./infrastructure/pipeline.yml -w
```
