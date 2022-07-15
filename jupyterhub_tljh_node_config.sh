#!/bin/bash

# Start the droplet with additional data
# and paste this script
# Change admin suer name if needed
ADMIN_USER_NAME=admin

#jupyterhub-base-ubuntu-20
# sudo apt-get update -y
# sudo apt-get upgrade -y

### DISABLE AND REMOVE SNAPD
sudo snap remove lxd
sudo snap remove core20
sudo snap remove snapd

sudo systemctl disable --now snapd
sudo systemctl disable --now snapd.socket
sudo systemctl disable --now snapd.seeded

sudo apt -y purge snapd
rmdir /root/snap

apt install docker.io -y

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# useradd $ADMIN_USER_NAME --group docker,sudo --shell /bin/bash
adduser --disabled-password --gecos "" ${ADMIN_USER_NAME}
usermod -G docker,sudo ${ADMIN_USER_NAME}


#### JUPYTER Installation

mkdir -pv /opt/shared/data
mkdir -pv /opt/shared/notebooks
ln -s /opt/shared /etc/skel/shared

# Jupyter Installation (TLJH)
curl -L https://tljh.jupyter.org/bootstrap.py \
  | sudo python3 - \
    --admin $ADMIN_USER_NAME

# To make any changes to HUB environment
# . /opt/tljh/hub/bin/activate 
# Once changes are done
# conda deactivate

# activate user environment
. /opt/tljh/user/bin/activate
# mamba is already installed
#conda install -c conda-forge mamba

# JAVA SUPPORT 
mamba install -c conda-forge openjdk

# Install Jupyter Lab (already installed by TLJH)
# maybe change to use pip instead of conta
# mamba install -c conda-forge jupyterlab
# sudo -E pip install jupyterlab


# to enable JupyterLab By default

#tljh-config set user_environment.default_app jupyterlab
#tljh-config reload hub
# to restart proxy
# tljh-config reload proxy (calls systemctl restart traefik in the back)
# tljh-config reload hub (calls systemctl restart jupyterhub in the back)

# For notes on how to install packages go here:
#  https://tljh.jupyter.org/en/latest/howto/env/user-environment.html
# TL;DR;
#  conda/mamba packages
#   sudo -E mamba install -c conda-forge gdal

# INSTALL_SCIPY_STACK
pip install numpy pandas matplotlib
# sudo -E pip install sympy
# sudo -E pip install scipy
# sudo -E pip install scikit-learn
# sudo -E pip install statsmodels

# INSTALL_PLOT_AND_UI_LIBS
pip install plotly==5.4.0
pip install jupyter-dash
pip install ipyvuetify

# NOTEBOOK UTILS
pip install nbconvert
pip install ipynb-py-convert
pip install jupytext

# UI SUPPORT

pip install pydantic==1.8.2
pip install fastapi


# ====== JUPYTER LAB EXTENSIONS ===========

# Voila 
# Note: Do we need to install voila into the server environment as well?
# sudo -E pip install voila

# Git Integration
pip install jupyterlab-git

# Variable Inspector
pip install lckr-jupyterlab-variableinspector

# Matplotlib Widgets
pip install ipympl

# SpreadSheet Editor
# source: https://github.com/jupyterlab-contrib/jupyterlab-spreadsheet-editor
pip install jupyterlab-spreadsheet-editor
#
# SpreadSheet Viewer (no need to intall since the editor is present)
# https://github.com/quigleyj97/jupyterlab-spreadsheet
# sudo -E pip install jupyterlab-spreadsheet

# Language Server Protocol(LSP) 
# sudo -E pip install jupyterlab-lsp
# sudo -E pip install 'python-lsp-server[all]'

# Code Formatter
# sudo -E pip install jupyterlab_code_formatter
# sudo -E pip install install black isort

# only use for developers
# sudo -E pip install jupyterlab-js-logs

# sudo -E pip install jupyterlab-drawio
# sudo -E pip install jupyterlab-execute-time


# ADDING ADMIN USERS
# tljh-config add-item users.admin SOME_OTHER_USER
# sudo tljh-config reload


# UPDRAGE JupyterHub to v2.0
# Upgrade Notes here https://jupyterhub.readthedocs.io/en/stable/admin/upgrading.html

# . /opt/tljh/hub/bin/activate
# pip install -U jupyterhub
# deactivate 

# Update in the user environment? It seems to be installed as well.
# . /opt/tljh/user/bin/activate
# pip install -U jupyterhub
# deactivate

# List Sever and Lab extensions 
# jupyter serverextension list
# jupyter labextension list

# ENABLE JupyterLab As Default
tljh-config set user_environment.default_app jupyterlab
tljh-config reload

# For performance tunning and other useful settings
#  check: https://tljh.jupyter.org/en/latest/topic/idle-culler.html
# set IDLE time culler
tljh-config set services.cull.timeout 3600
tljh-config reload

# configurator https://tljh.jupyter.org/en/latest/topic/jupyterhub-configurator.html
tljh-config set services.configurator.enabled False
tljh-config reload


# ========= R Language Support
sudo -E pip install jupyter-shiny-proxy
sudo -E pip install jupyter-rsession-proxy

# Install Base R packages + essentials
mamba install r-base r-essentials r-irkernel -y

# Enable useful bioconductor packages
mamba install -c bioconda bioconductor-ggbio bioconductor-genomicranges

# Support for Java in R
mamba install -c r r-rjava -y

# Support for R Devtools
mamba install -c r r-devtools -y

# Install Sommer 
### note: if the conda r-sommer install below does not work use:
#       devtools::install_github('covaruber/sommer')
#        or install.packages('sommer')
## mamba install -c r r-sommer -y
# install sommer with devtools
# 
mamba install -c r r-arrow -y
# install rTASSEL
# mamba install -c bioconda bioconductor-biocstyle
# mamba install -c bioconda bioconductor-summarizedexperiment
# devtools::install_bitbucket(repo = "bucklerlab/rtassel", ref = "master", build_vignettes = TRUE)

# ==== RSTUDIO script
# ilci_hub_scripts/install_rstudio_and_shiny.sh

# === KOTLIN support INSTALLATION
mamba install -c jetbrains kotlin-jupyter-kernel


# ### LETS ENCRYPT CONFIGURATION
# details here: https://tljh.jupyter.org/en/latest/howto/admin/https.html#howto-
# sudo tljh-config set https.enabled true
# sudo tljh-config set https.letsencrypt.email ACCOUNT@DOMAIN.com
# sudo tljh-config add-item https.letsencrypt.domains jupyterhub-workshop-01.ilc

# reload proxy and hub for new changes to take effect
tljh-config reload proxy
tljh-config reload hub  

echo "INSTALLATION DONE" > ~/provision_status.txt


#Notes:
# should remove!!!
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCt8rTQbM/UpUdt3g94eZNB09hWo+903SSx+/57CxBZboN48yePfB1JZUiJ6ndVxOfeeXHhlAlhzeuo6uu4DPnAMU3BSC23Mz5d0BV5MGBVL7gY8/WUiejKkRlDwHPeYpp/HfknbIQuRdTUg9ZhOQ8LmzZAEWMzOEvhdH9/XsgjecJHhH7DXasNfsOCWpep8VomVznIG7j+Tqq0WqSCbVS8IJftOBe/aPd14/fvKReRSOCsgixRgzSajnLDPVB7mPYOlqBU1KhQWh+kQ/prGRnHg0B4fDTqcnlajPDYaTtUU/b6+tOofzoZOxLMi2M+gHQFqMo+DLuYsYdmGw7/1/5vOhfRgxbMFg2aWjgdRKiHg5RCBjo+RBnjgvQROXmTzpFtxwod+SSf6jJRpS16E32iAexCC6Ab/o+/DlugGq7X4zsX7wupz6CSJ8MZJ4+Wjxs/Gc7gkjM7NyvlKwJxiTnccU63c9V9jwKjfyARUkL8gIyoBJZcwoVZ190bBNGmB4k= admin@ubuntu
#


### ================ ILCI-specific
### add GROUPS
for G in ilci_{staff,cifms,caccia,ciciesa,ciwa};do addgroup $G;done

#### JUPYTER Installation
#mkdir -pv /opt/shared/data
#mkdir -pv /opt/shared/notebooks
mkdir -pv /opt/shared/commons/{data,notebooks,src}
ln -s /opt/shared /etc/skel/shared

# add a shared link at root
ln -s /opt/shared/ /shared
### 


# Install rookit checkers (maybe in post install since it ask for mailer configuration):
apt install rkhunter chkrootkit
cat >  /etc/rkhunter.conf.local <<EOF
PKGMGR=DPKG
# if root users are allowed add
ALLOW_SSH_ROOT_USER=YES

MIRRORS_MODE=0
UPDATE_MIRRORS=1
WEB_CMD=""
EOF

# run checks with 
# sudo rkhunter --update --propupd --check


# sudo apt install bcftools
# sudo apt install tabix
mamba install -y -c bioconda bcftools tabix samtools
mamba install -y -c bioconda r-dartr

# add LATEX support
apt install -y --no-install-recommends texlive texlive-xetex texlive-fonts-recommended texlive-plain-generic

## apt install -y unzip

### EXTRA libraries  might not be needed
## sudo apt install -y datamash
## sudo apt install gdal-config
## sudo apt install libgdal-dev libproj-dev
## sudo apt-get install gdal-bin

# clean cache
apt-get clean

# clean conda
conda clean -ay --force-pkgs-dirs

## disable these extensions on workshop hub
ilci_hub_scripts/disable_extensions_workshop.sh

