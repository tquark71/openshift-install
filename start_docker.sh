INVENTORY=../openshift-install/openshift_inventory

cd ~/openshift-ansible
ansible -i $INVENTORY OSEv3 -a "systemctl start docker"
