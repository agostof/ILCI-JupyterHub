#!/bin/bash

# permissions for top-level shared directory
# owner group:ilci_staff
sudo mkdir /opt/shared/
sudo chown -v :ilci_staff /opt/shared/


# set the setgid flag so the default group owner is set to ilci_staff
sudo chmod -v g+s  /opt/shared
sudo setfacl -d -m g::rwX /opt/shared
sudo setfacl -m g::r-X /opt/shared

#cd /opt/shared/
#sudo mkdir CACCIA CICIESA CIFMS CIWA commons
sudo mkdir -pv /opt/shared/{CACCIA,CICIESA,CIFMS,CIWA,commons}/{notebooks,data,src}
# chown -R :ilci_caccia /opt/shared/CACCIA
# chmod +s /opt/shared/CACCIA
#sudo chmod g-w /opt/shared
