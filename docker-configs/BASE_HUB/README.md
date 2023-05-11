# Overview

Run Jupyter Hub using Docker based on the upstream [JupyterHub base image](https://hub.docker.com/r/jupyterhub/jupyterhub/).

Please note that the packages that are installed as part of ICLI's JupyterHub installation are not included and will need to be added to a Dockerfile, to the `provision.sh` script or installed manually.

>**Note:** The steps here can be used to create a Dockerfile for a customized JupyterHub image that is based on the upstream JupyterHub image. For now, the Dockerfile creation is left as an exercise for the reader.

## Usage
The hub uses the [nativeauthenticator](https://github.com/jupyterhub/nativeauthenticator) for authentication. The authenticator is installed as part of the `provision.sh` script.
The default user created is `admin`, no password is set for this user. The password can be set by going to http://hostname:8001/hub/signup.

Please note that new users need to be created using the OS's user management tools e.g. `adduser`. After user creation, the setup is completed by visiting the signup page (e.g. http://hostname:8001/hub/signup) to set up a password.

<!-- ### Build the image

```bash
docker build -t jupyterhub-custom .
``` -->

### Run the container

```bash
# docker run -p 8000:8000 jupyterhub-custom

docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates jupyterhub/jupyterhub /bin/bash

```
If you want to preserve the data in the container, you can mount a volume to the container. For example, to mount the current directory to the container:

```bash
docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates -v $PWD/data:/data jupyterhub/jupyterhub /bin/bash
```
In addition if you want to preserve the user names created on the hub you need to mount the `/srv/jupyterhub` directory to the container, for instance:

```bash
docker run -it --rm -p8000:8000 --name jupyterhub --hostname hub01 -v $PWD:/config -v $PWD/native_authenticator_templates/templates:/templates -v $PWD/data:/data -v $PWD/srv/jupyterhub:/srv/jupyterhub jupyterhub/jupyterhub /bin/bash
```
Please note that users still need to be created inside to the OS running inside jupyterhub contianer, this can be done with or without a password:

```bash
# create user without password
adduser $USER_NAME --disabled-password --gecos ""

# if password is needed it can be added programatically
chpasswd <<<"$USER_NAME:$USER_PASS"
```
Check the [create_users.sh](create_users.sh) script for an example.


### Install basic dependencies

```bash
/config/provision.sh
```

### Launch JupyterHub

```bash
/config/run_hub.sh

```
### Connect to JupyterHub

Create a password for the admin user by going to:
http://hostname:8001/hub/signup

### Note
Please note that the commands above are for testing purposes only. For production use a  JupyterHub distribution.