#!/bin/bash

## disable these extensions on workshop hub
sudo -E jupyter-labextension disable jupyter-vuetify
sudo -E jupyter-labextension disable @jupyterlab/git
sudo -E jupyter-labextension disable @lckr/jupyterlab_variableinspector
sudo -E jupyter-labextension disable jupyterlab-plotly
sudo -E jupyter-labextension disable @voila-dashboards/jupyterlab-preview
sudo -E jupyter-labextension disable jupyterlab-dash
sudo -E jupyter-labextension disable jupyter-vue
#find default core pluggins (extensions)  names under /opt/tljh/user/share/jupyter/lab/schemas/@jupyterlab
sudo -E jupyter labextension disable @jupyterlab/extensionmanager-extension
sudo -E jupyter labextension enable @jupyterlab/inspector-extension
sudo -E jupyter labextension disable @jupyterlab/inspector-extensionjupyter
sudo -E jupyter labextension enable @jupyterlab/toc-extension

sudo -E jupyter-labextension disable @lckr/jupyterlab-variableinspector:consoles
sudo -E jupyter-labextension disable jupyterlab_extension/variableinspector:IVariableInspectorManager
sudo -E jupyter-labextension disable @lckr/jupyterlab-variableinspector:notebooks
sudo -E jupyter-labextension disable jupyterlab_extension/variableinspector:IVariableInspectorManager

