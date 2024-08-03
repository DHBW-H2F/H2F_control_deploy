

# Usage
## Remote preparation 
> This playbook as been tested on debian 12 but should work on any derivatives without too much modifications.

You should have access to the server via ssh, for security and convenience it is recommanded to setup key-based authentification.
> Your user should have superuser access via sudo (for doas add `--become-method=doas` when invoking ansible)

## Setup
Add the remote to the `inventory/hosts` file : 
`remote_name ansible_host=<remote_url> ansible_ssh_user=<username> ansible_ssh_pipelining=False`

Create configuration for the remote in the file `inventory/host_vars/<remote_name>/vars.yml` setting variables (see the example for help).

## Running
Run the playbook, this will install and setup all service. And can take a few minutes (30 mins) to finish : 
`ansible-playbook -v -i inventory/hosts playbook.yaml`

If everything went correctly you should now be able to access the services : 
- Grafana at http://<remote_url>:3000
- InfluxDB at http://<remote_url>:8086
- The webUI at http://<remote_url>:8000

# Maintenance
For compatibility this playbook use docker-compose as a service manager.
Services configurations can be found in the user home in the folder defined by the `folder` variable (default `/home/<user>/station_control`). With a folder for each service.
Log can be viewed with `docker-compose logs` while in the service folder.
Started services can be viewed with `docker ps`.
Services can be started/stopped with `docker-compose up`/`docker-compose down`.
