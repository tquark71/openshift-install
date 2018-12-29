INVENTORY=../openshift-install/openshift_inventory

ansible -i $INVENTORY etcd -a 'yum -y install lvm2'
ansible -i $INVENTORY etcd -a 'wipefs /dev/sdc -a'
ansible -i $INVENTORY etcd -a 'pvcreate /dev/sdc'
ansible -i $INVENTORY etcd -a 'vgcreate etcd-vg /dev/sdc'
ansible -i $INVENTORY etcd -a 'lvcreate -n etcd-lv -l 100%VG etcd-vg'
ansible -i $INVENTORY etcd -a 'mkfs.xfs /dev/mapper/etcd--vg-etcd--lv'
ansible -i $INVENTORY etcd -m shell -a 'mkdir /var/lib/etcd'
ansible -i $INVENTORY etcd -m lineinfile -a 'path=/etc/fstab regexp=etcd line="/dev/mapper/etcd--vg-etcd--lv /var/lib/etcd xfs defaults 0 0"'
ansible -i $INVENTORY etcd -m shell -a 'mount -a'
