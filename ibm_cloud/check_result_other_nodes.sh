INVENTORY=./openshift_inventory

ansible -i $INVENTORY nodes:\!etcd -m shell -a 'lsblk'
