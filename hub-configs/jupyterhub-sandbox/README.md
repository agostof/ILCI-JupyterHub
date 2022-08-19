# TLJH Configuration for jupyterhub-sandbox

## Overview

The files on this directory contain information about the **jupyterhub-sandbox** JupyterHub environment created with TLJH. In addition to the TLJH `base` and `hub` environments the individual package listing for both R and Python are stored.

## Environment Files
```
jupyterhub-sandbox
├── hub-requirements-jupyterhub-sandbox.txt   <- TLJH "hub" python venv packages.
├── user-condaenv-jupyterhub-sandbox.yml      <- Conda packages installed.
├── user-requirements-jupyterhub-sandbox.txt  <- TLJH "user" conda-env python packages.
├── user-r-packages-jupyterhub-sandbox.txt    <- R packages names only
└── user-r-packages-jupyterhub-sandbox.w_version.tsv  <- R packages with versions.
```
