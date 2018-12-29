INVENTORY=../openshift-inventory/openshift_inventory

ansible -i $INVENTORY etcd -m shell -a 'lsblk'
