INVENTORY=../openshift-install/openshift_inventory

ansible -i $INVENTORY etcd -m shell -a 'lsblk'
