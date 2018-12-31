INVENTORY=../openshift-install/ibm_cloud/openshift_inventory

ansible -i $INVENTORY OSEv3 -m ping
