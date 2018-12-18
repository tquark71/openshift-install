ansible -i openshift_inventory nodes:\!etcd -m shell -a 'lsblk'
