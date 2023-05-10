# Overview

Run Jupyter Hub using Docker based on the upstream [JupyterHub base image](https://hub.docker.com/r/jupyterhub/jupyterhub/).

Please note that the packages that are installed as part of ICLI's JupyterHub installation are not included and will need to be added to a Dockerfile, to the `provision.sh` script or installed manually.


## Usage
The hub uses the [nativeauthenticator](https://github.com/jupyterhub/nativeauthenticator) for authentication. The authenticator is installed as part of the `provision.sh` script.
The default user created is `admin`, no password is set for this user. The password can be set by going to http://hostname:8001/hub/signup.

Any new users need to be added in the OS, after they are added they have to setup access by going to signup page (e.g. http://hostname:8001/hub/signup).

<!-- ### Build the image

```bash
docker build -t jupyterhub-custom .
``` -->

### Run the container

```bash
#docker run -p 8000:8000 jupyterhub-custom

docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates jupyterhub/jupyterhub /bin/bash

```
If you want to preserve the data in the container, you can mount a volume to the container. For example, to mount the current directory to the container:

```bash
docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates -v $PWD/data:/data jupyterhub/jupyterhub /bin/bash
```
In addition if you want to preserve the user names created on the hub you need to mount the `/srv/jupyterhub` directory to the container. For example, to mount the current directory to the container:

```bash
docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates -v $PWD/data:/data -v $PWD/srv/jupyterhub:/srv/jupyterhub jupyterhub/jupyterhub /bin/bash
```
Please note that that users will still need to be added to the OS running inside jupyterhub contianer (e.g. `adduser`).
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

