INVENTORY=../openshift-install/openshift_inventory

ansible -i $INVENTORY etcd -m yum -a 'name=lvm2 state=present'
ansible -i $INVENTORY etcd -a 'wipefs /dev/sdc -a'
ansible -i $INVENTORY etcd -m lvg -a 'vg=etcd-vg pvs=/dev/sdc state=present'
ansible -i $INVENTORY etcd -m lvol -a 'lv=etcd-lv vg=etcd-vg state=present size=100%VG'
ansible -i $INVENTORY etcd -m filesystem -a 'fstype=xfs dev=/dev/mapper/etcd--vg-etcd--lv'
ansible -i $INVENTORY etcd -m file -a 'path=/var/lib/etcd state=directory'
ansible -i $INVENTORY etcd -m mount -a 'path=/var/lib/etcd src=/dev/mapper/etcd--vg-etcd--lv fstype=xfs opts=defaults state=mounted'
