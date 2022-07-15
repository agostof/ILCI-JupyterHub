#JupyterHub configuration (cloud config)

##Overview

The script(s) here help to get a JupyterHub installation up and running using the TLJH distribution. In addition to the basic hub configuration, it installs (or provides notes for installing) packages relevant to plant breeding (e.g. R, sommer, rTASSEL, bioconductor). 
**Important**. The core script assumes access to a machine (either VM or physical). It will not work under Docker due to its depedency on systemd.

### Installation / post installation notes:

* Check if java is operating correctly if not clean the cache and reinstall it
* Saving Hub configuration
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
