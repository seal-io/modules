
# Module `server`

Provider Requirements:
* **ssh:** (any version)

## Input Variables
* `host` (required): SSH host
* `password` (required): SSH password
* `port` (default `22`): SSH port
* `user` (default `"root"`): SSH user

## Output Values
* `host`: SSH host
* `password`: SSH password
* `port`: SSH port
* `user`: SSH user

## Managed Resources
* `ssh_resource.server` from `ssh`

