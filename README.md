# JupyterHub configuration (cloud config)

## Overview

ILCI's JupyterHub installation is based on the [The Littlest JupyterHub](https://tljh.jupyter.org/en/latest/) (TLJH) distribution.

The script(s) in this repository help get a JupyterHub installation up and running using *TLJH*.

The [jupyterhub_tljh_node_config.sh](jupyterhub_tljh_node_config.sh) script creates a basic hub configuration. In addition, it installs (or provides notes for installing) packages relevant to plant breeding (e.g. R, sommer, rTASSEL, bioconductor).

> **Important**. The core script assumes superuser access to a machine (e.g. VM or physical) for installing TLJH. The TLJH installation will **not work** under Docker due to its dependency on systemd.

### Installation / post installation notes:

* Check if Java is operating correctly; if not, clean the cache and reinstall it.
* For saving / exporting the hub's configuration, use the [export_envs.sh](ilci_hub_scripts/export_envs.sh) script or:

```bash
# #======= SAVE environment settings
# save hub env
. /opt/tljh/hub/bin/activate
pip freeze > hub-requirements.txt
deactivate

# # save user env
. /opt/tljh/user/bin/activate
pip freeze > user-requirements.txt
conda env export > user-condaenv.yml
conda deactivate
```

**TLJH** will not work as a Docker container, it assumes full access to a physical machine or a virtual machine instance (VM). If you wish to use Docker for JupyterHub, the are other options available like [Zero to JupyterHub with Kubernetes](https://z2jh.jupyter.org/en/latest/index.html) or rolling out your own *not recommended for beginners*) based on the [JupyterHub base image](https://hub.docker.com/r/jupyterhub/jupyterhub/). For reference, some of the steps for running JupyterHub as a Docker container are included [here](docker-configs/BASE_HUB/README.md). 

