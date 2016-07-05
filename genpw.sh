#!/bin/bash

if [ -f ~/.genpw ]; then
  exit 0
fi

PASSWORD=${ROOT_PASS:-$(pwgen -c -n -1 12)}
echo "root:$PASSWORD" | chpasswd
touch ~/.genpw

echo "###########################################################"
echo "You can now connect to this Ubuntu container via SSH using:"
echo ""
echo "    ssh -p <port> root@<host>"
echo "and enter the root password '$PASSWORD' when prompted"
echo ""
echo "###########################################################"
