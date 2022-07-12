#!/bin/bash

# Start the droplet with additional data
# and paste this script
ADMIN_USER_NAME=fja32

apt-get update -y
apt-get upgrade -y

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
conda install -c conda-forge mamba

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


# ========= R Language Support
sudo -E pip install jupyter-shiny-proxy
sudo -E pip install jupyter-rsession-proxy

# Install Base R packages + essentials
mamba install r-base r-essentials r-irkernel -y


# RSTUDIO installation

# check logs
# journalctl -u rstudio-server


# KOTLIN support INSTALLATIOB
# sudo -E mamba install -c jetbrains kotlin-jupyter-kernel


# reload proxy and hub for new changes to take effect
# tljh-config reload proxy
# tljh-config reload hub  

echo "INSTALLATION DONE" > ~/provision_status.txt

