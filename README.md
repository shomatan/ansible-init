# Ansible role: init


### Requirements
None.

### Role variables
|Key|Type|Description|Default|
|:--|:---|:----------|:------|
|init_networkmanager_enabled|Bool|NetworkManager enabled.|false|
|init_cron_managed|Bool|Manage cron.|true|
|init_repositories_installed|Bool|Install repositories.|true|
|init_repositories|Array|Install repositories.|See `defaults/main.yml`|

### Dependencies
None.
