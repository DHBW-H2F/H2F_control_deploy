# Running on docker
To provide an easier way to run the playbook on Windows a docker container is provided.
To install docker see https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers.

## Add authentification to the server
The playbook will be run in a container, the content of this folder will be mounted however any other files will not be available (ex: ~/.ssh). You then have two option : 
- Use password authentification, simply add `ansible_ssh_pass=<password>` to inventory/hosts
- Use a private key : 
  - Copy the key to this folder (recommanded as "ssh_key" because it is automaticcaled ignored in the .gitignore)
  - Add `ansible_ssh_private_key_file=ssh_key` to the inverntory/hosts

## Build the container
Simply run docker-compose on the playbook folder :
```bash
docker compose build
```

## Run
Run the ansible commands as usual, simply prepend it with the docker compose invocation. Ex : 
```
docker compose run ansible ansible-playbook -v -i inventory/hosts playbook.yaml --tags "install-all"
```
