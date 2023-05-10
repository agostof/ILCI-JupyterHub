# Overview

Run Jupyter Hub using Docker based on the upstream [JupyterHub base image](https://hub.docker.com/r/jupyterhub/jupyterhub/).

Please note that the packages that are installed as part of ICLI's JupyterHub installation are not included and will need to be added to a Dockerfile, to the `provision.sh` script or installed manually.


## Usage

<!-- ### Build the image

```bash
docker build -t jupyterhub-custom .
``` -->

### Run the container

```bash
#docker run -p 8000:8000 jupyterhub-custom

docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates jupyterhub/jupyterhub /bin/bash

```

### Install basic dependencies

```bash
/config/provision.sh
```

### Launch JupyterHub

```bash
#jupyterhub --ip 0.0.0.0 --port 8000 -f /config/jupyterhub_configV3.py
/config/run_hub.sh

```
### Connect to JupyterHub

Create a password for the admin user by going to:
http://hostname:8001/hub/signup

