#!/bin/bash
echo "create WorkDir";
##
pwd;
mkdir $WORKDIR;
mkdir $WORKDIR/templates;
cp ./deploy/main.yml $WORKDIR/main.yml;
cp ./deploy/templates/* $WORKDIR/templates/ ;
cd $WORKDIR;
###
#### 


####### 

echo "create temp inventory";
echo "[$NODE_GROUP]" > host.ini;
echo "$HOST_NAME ansible_host=$ANSIBLE_HOST ansible_connection=$ANSIBLE_CONNECTION ansible_user=$ANSIBLE_USER" >> host.ini;

echo "create ansible cfg "

echo "[defaults]                                                  " > ansible.cfg
echo "ansible_ssh_private_key_file = ~/.ssh/id_rsa                " >> ansible.cfg 
echo "become              = yes                                   " >> ansible.cfg
echo "hostfile            = $WORKDIR/host.ini "                    >> ansible.cfg
echo "timeout             = 100                                   " >> ansible.cfg
echo "host_key_checking   = False                                 " >> ansible.cfg               

echo "Del Know Host "
 ssh-keygen -f ~/.ssh/known_hosts -R "$ANSIBLE_HOST"

echo "deploy == >"
ansible-playbook -i host.ini  main.yml;


echo "Del WorkSpace == >"
rm -rf $WORKDIR

echo "Done"