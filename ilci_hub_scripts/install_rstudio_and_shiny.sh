# RSTUDIO
# =====================    RSTUDIO   ================================
# RSTUDIO installation
sudo apt-get install gdebi-core
wget wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.12.1-402-amd64.deb
gdebi --non-interactive rstudio-server-2023.12.1-402-amd64.deb 
# check logs
# journalctl -u rstudio-server

# The configuration below moves the Rstudio server to port 82
# so that it does not conflict with the jupyterhub proxy.
# The `rsession-ld-library-path` and `rsession-which-r` 
# are not needed in most cases, if the connections are managed by 
# the jupyterhub proxy.

# create configration
cat > /etc/rstudio/rserver.conf <<EOF
# add RServer config here
# Server Configuration File
#server-user=root
#server-user=rstudio-server
rsession-ld-library-path=/opt/tljh/user/lib:/opt/tljh/user/lib/R/lib
#rsession-which-r=/opt/tljh/user/bin/R
rsession-which-r=/opt/tljh/user/lib/R/bin/R
#auth-required-user-group=rstudio_users
#
www-port=82
# www-address=127.0.0.1
#server-app-armor-enabled=0
#server-data-dir=/var/run/rstudio-server
server-set-umask=0

EOF

# if the jupyterhub extentions
sleep 5
systemctl restart rstudio-server

# Notes: On Rstudio-server install 
# If the
# the Rstudio instalaltion should create both (when the server is run):
# /var/lib/rstudio-server
# /var/run/rstudio-server
# the permission for /var/run/rstudio-server should be set (usually done when service install first time)
# sudo mkdir -pv /var/run/rstudio-server/rstudio-rsession/
# sudo chmod 777 -Rv /var/run/rstudio-server/rstudio-rsession
# sudo chmod +t -Rv /var/run/rstudio-server/rstudio-rsession

# Verify Rstudio installation with:
# sudo rstudio-server verify-installation
# If the R studio server does not point to a valid R installation it will fail

# RSHINY Installation
wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.21.1012-amd64.deb
gdebi --non-interactive shiny-server-1.5.21.1012-amd64.deb


# . /opt/tljh/user/bin/activate
pip install jupyter-shiny-proxy
pip install jupyter-rsession-proxy

# since the servers will be managed by the jupyterhub proxy,
# we can disable them system-wide
systemctl disable rstudio-server
systemctl disable shiny-server

# ### would this  config work for RSTUDIO
# hub:
#   extraConfig:
#     jupyterlab: |
#       c.Spawner.cmd = ['jupyter-labhub']
# singleuser:
#   #defaultUrl: "/lab"
#   defaultUrl: "/rstudio"


