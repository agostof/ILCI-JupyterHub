#!/bin/bash

HUB=$1
# ignore $1 after this 
shift

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
Rscript $(dirname $0)/save_installed_R_packages_to_list.R user-r-packages-${HUB}.txt

echo "Export conda base env..."
conda env export --name=base > user-condaenv-${HUB}.yml
conda deactivate
