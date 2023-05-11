# install jupyterlab
# we move the jupyterLab installation to the conda-env
# pip install jupyterlab
pip install jupyterhub-nativeauthenticator

cp -v /templates/*html /usr/local/lib/python3.10/dist-packages/nativeauthenticator/templates/

UNAME=admin
adduser ${UNAME} --disabled-password --gecos ""

# ================= CONDA PROVISIONING =====================
curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/ilci/user
. /opt/ilci/user/bin/activate 
conda install -y mamba -n base -c conda-forge
conda install -y -n base conda-libmamba-solver
conda config --set solver libmamba

conda update -y -n base conda mamba
#conda install -y -n base conda-libmamba-solver
#conda config --set solver.libmamba true
#conda config --set solver libmamba

pip install -U pip
pip install jupyterlab jupyterhub

# mkdir -pv /opt/ilci/hub/bin

# create update script
cat >  /opt/ilci/user/bin/user-hub <<"EOF"
#!/bin/bash

echo "Activating User Env"
. /opt/ilci/user/bin/activate

# source /opt/ilci/user/bin/activate

JHUB_SINGLE_USER=`which jupyterhub-singleuser`

echo "Starting HUB from ${JHUB_SINGLE_USER}"
#/opt/ilci/user/bin/jupyterhub-singleuser "$@"
${JHUB_SINGLE_USER} "$@"

EOF

chmod +x /opt/ilci/user/bin/user-hub

# ================= END CONDA PROVISIONING =====================

