# install jupyterlab
pip install jupyterlab jupyterhub-nativeauthenticator

cp -v /templates/*html /usr/local/lib/python3.10/dist-packages/nativeauthenticator/templates/
 
UNAME=admin
adduser ${UNAME} --disabled-password --gecos ""
