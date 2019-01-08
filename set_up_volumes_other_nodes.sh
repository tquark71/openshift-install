INVENTORY=../openshift-install/openshift_inventory

ansible -i $INVENTORY nodes:\!etcd -m yum -a 'name=lvm2 state=present'
ansible -i $INVENTORY nodes:\!etcd -m lvg -a 'vg=origin-vg pvs=/dev/sdc state=present'
ansible -i $INVENTORY nodes:\!etcd -m lvol -a 'lv=origin-lv vg=origin-vg state=present size=100%VG'
ansible -i $INVENTORY nodes:\!etcd -m file -a 'path=/var/lib/origin state=directory'
ansible -i $INVENTORY nodes:\!etcd -m filesystem -a 'fstype=xfs dev=/dev/mapper/origin--vg-origin--lv'
ansible -i $INVENTORY nodes:\!etcd -m mount -a 'path=/var/lib/origin src=/dev/mapper/origin--vg-origin--lv fstype=xfs opts=defaults state=mounted'
