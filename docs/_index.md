# ce-deploy
A set of Ansible roles and wrapper scripts to deploy (web) applications.
## Overview
The "stack" from this repo is to be installed on a "deploy" server/runner, to be used in conjonction with a CI/CD tool (Jenkins, Gitlab, Travis, ...).
It allows the deploy steps for a given app to be easily customizable at will, and to be stored alongside the codebase of the project.
When triggered from a deployment tool, the stack will clone the codebase and "play" a given deploy playbook from there.

<!--TOC-->
## [Install](install/README.md)
The stack only gets tested on Debian Buster, but should run on any Linux distribution, as long as Ansible >=2.9 is present.
You can install either:
- through [ce-provision](https://github.com/codeenigma/ce-provision)
- manually by running a local playbook
- with Docker (soon)

## [Usage](scripts/README.md)
While you can re-use/fork roles or call playbooks directly from your deployment tool, it is recommended to use the provided wrapper scripts, as they will take care of setting up the needed environments.
## [Roles](roles/README.md)
Ansible roles and group of roles that constitute the deploy stack.
### [Config](roles/cache_clear/README.md)
Cache clearing commands.
### [ce-dev](roles/ce_dev/README.md)
Roles that integrate with local dev environments.

### [CLI Tools](roles/cli/README.md)
Roles to install app-specific cli tool and utilities (Drush, ...)
### [Composer](roles/composer/README.md)
Performs a composer install on a freshly deployed codebase.
### [Config](roles/config_generate/README.md)
Generates config files and handles sensitive variables.
### [Cron](roles/cron/README.md)
Roles to generate cron entries.
### [Data backups](roles/database_backup/README.md)
Generate backups for each build.
### [Deploy](roles/deploy_code/README.md)
Step that deploys the codebase.
### ["Meta"](roles/meta/README.md)
Roles that bundles other individual roles together for tackling common use cases.
### [Sync roles](roles/sync/README.md)
Roles that sync data/assets between environments.
## [Contribute](contribute/README.md)

<!--ENDTOC-->
