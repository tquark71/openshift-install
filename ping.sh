INVENTORY=../openshift-install/openshift_inventory

ansible -i $INVENTORY OSEv3 -m ping
