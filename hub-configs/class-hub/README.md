# TLJH Configuration for class-hub

## Overview

The files on this directory contain informatino about the **class-hub** JupyterHub environment created with TLJH. In addition to the TLJH `base` and `hub` environments the individual package listing for both R and Python are stored.

## Environment Files
```
class-hub
├── hub-requirements-class-hub.txt   <- TLJH "hub" python venv packages.
├── user-condaenv-class-hub.yml      <- Conda packages installed.
├── user-requirements-class-hub.txt  <- TLJH "user" conda-env python packages.
├── user-r-packages-class-hub.txt    <- R packages names only
└── user-r-packages-class-hub.w_version.tsv  <- R packages with versions.
```
