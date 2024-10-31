# NVA cross-account backups

This repository holds IaC resources related to cross-account backups for NVA services, where these resources do not belong to a specific service or environment.

## Development

Example commands for running static analysis tools:

```shell
cfn-lint ./infrastructure/**/*.yml
cfn_nag_scan --input-path ./infrastructure
```
