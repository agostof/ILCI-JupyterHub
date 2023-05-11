#!/bin/bash
# Creates users based on an input list


# GNAME=ilci_staff

UPASS="test"
for UNAME in $(<hub_user_list.txt);
do
  echo "Creating ${UNAME} with pass $UPASS"
  adduser ${UNAME} --disabled-password --gecos ""
  chpasswd <<<"$UNAME:$UPASS"
done
