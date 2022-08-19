# JupyterHub configuration (cloud config)

## Overview

The script(s) here help to get a JupyterHub installation up and running using the TLJH ([The Littlest JupyterHub](https://tljh.jupyter.org/en/latest/)) distribution.

The [jupyterhub_tljh_node_config.sh](jupyterhub_tljh_node_config.sh) script creates a basic hub configuration. In addition, it installs (or provides notes for installing) packages relevant to plant breeding (e.g. R, sommer, rTASSEL, bioconductor).

> **Important**. The core script assumes superuser access to a machine (e.g. VM or physical) for installing TLJH. The TLJH installation will **not work** under Docker due to its depedency on systemd.

### Installation / post installation notes:

* Check if java is operating correctly if not clean the cache and reinstall it.
* For saving / exporting the hub's configuration use the [export_envs.sh](ilci_hub_scripts/export_envs.sh) script or:
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
