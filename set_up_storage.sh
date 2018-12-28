ansible -i openshift_inventory etcd -a 'yum -y install lvm2'
ansible -i openshift_inventory etcd -a 'wipefs -a /dev/sdc'
ansible -i openshift_inventory etcd -a 'pvcreate /dev/sdc'
ansible -i openshift_inventory etcd -a 'vgcreate etcd-vg /dev/sdc'
ansible -i openshift_inventory etcd -a 'lvcreate -n etcd-lv -l 100%VG etcd-vg'
ansible -i openshift_inventory etcd -a 'mkfs.xfs /dev/mapper/etcd--vg-etcd--lv'
ansible -i openshift_inventory etcd -m shell -a 'mkdir /var/lib/etcd'
ansible -i openshift_inventory etcd -m lineinfile -a 'path=/etc/fstab regexp=etcd line="/dev/mapper/etcd--vg-etcd--lv /var/lib/etcd xfs defaults 0 0"'
ansible -i openshift_inventory etcd -m shell -a 'mount -a'
ansible -i openshift_inventory nodes:\!etcd -a 'yum -y install lvm2'

## Check results:
ansible -i openshift_inventory etcd -m shell -a 'lsblk'

ansible -i openshift_inventory nodes:\!etcd -a 'wipefs -a /dev/sdc'
ansible -i openshift_inventory nodes:\!etcd -a 'pvcreate /dev/sdc'
ansible -i openshift_inventory nodes:\!etcd -a 'vgcreate origin-vg /dev/sdc'
ansible -i openshift_inventory nodes:\!etcd -a 'lvcreate -n origin-lv -l 100%VG origin-vg'
ansible -i openshift_inventory nodes:\!etcd -a 'mkfs.xfs /dev/mapper/origin--vg-origin--lv'
ansible -i openshift_inventory nodes:\!etcd -m shell -a 'mkdir /var/lib/origin'
ansible -i openshift_inventory nodes:\!etcd -m lineinfile -a 'path=/etc/fstab regexp=origin line="/dev/mapper/origin--vg-origin--lv /var/lib/origin xfs defaults 0 0"'
ansible -i openshift_inventory nodes:\!etcd -m shell -a 'mount -a'

## Check results:
ansible -i openshift_inventory nodes:\!etcd -m shell -a 'lsblk'
