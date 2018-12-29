INVENTORY=../openshift-inventory/openshift_inventory

ansible -i $INVENTORY OSEv3 -m ping
