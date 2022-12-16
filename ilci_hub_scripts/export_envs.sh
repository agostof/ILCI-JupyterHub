#!/bin/bash

#set hub name prefix
HUB=$1

usage()
{
cat<<EOF
usage:
   $(basename $0) HUB_NAME
e.g.
   $(basename $0) jupyter-sandbox
EOF
}


if [ "${HUB}" = "" ]
then
  usage
  exit 0
fi

set -u
# use hub name as output directory 
OUT_DIR=$HUB

SCRIPT_DIR=$(dirname $(readlink -e $0))
echo "Exporting environment for: ${HUB}"
echo "Files will be saved to: ${OUT_DIR}"
if [ ! -d ${OUT_DIR} ]
then
  mkdir -v ${OUT_DIR}
fi
pushd ${OUT_DIR}

# ignore $1 after this
shift

create_readme(){
# create basic README file 
cat << EOF > README.md
# TLJH Configuration for ${HUB}

## Overview

The files on this directory contain information about the **${HUB}** JupyterHub environment created with TLJH. In addition to the TLJH \`base\` and \`hub\` environments the individual package listing for both R and Python are stored.

## Environment Files
\`\`\`
${HUB}
├── hub-requirements-${HUB}.txt   <- TLJH "hub" python venv packages.
├── user-condaenv-${HUB}.yml      <- Conda packages installed.
├── user-requirements-${HUB}.txt  <- TLJH "user" conda-env python packages.
├── user-r-packages-${HUB}.txt    <- R packages names only
└── user-r-packages-${HUB}.w_version.tsv  <- R packages with versions.
\`\`\`
EOF
}


# #======= SAVE environment settings
# save hub env
echo "Activating HUB venv."
. /opt/tljh/hub/bin/activate
echo "Saving package list on venv..."
pip freeze > hub-requirements-${HUB}.txt
echo "Deactivating HUB venv."
deactivate

# # save user env
echo "Activating TLH user (base) env."
. /opt/tljh/user/bin/activate
echo "Saving Python package list..."
pip freeze > user-requirements-${HUB}.txt

echo "Saving R package list..."
Rscript ${SCRIPT_DIR}/save_installed_R_packages_to_list.R user-r-packages-${HUB}.txt

echo "Export conda base env..."
conda env export --name=base --from-history > user-condaenv-${HUB}.yml
conda deactivate

# create README.md
create_readme



