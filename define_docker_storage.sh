ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m yum \
  -a 'update_only=yes'

cat <<EOF > docker-storage-setup
DEVS=/dev/sdb
VG=docker-vg
EOF

ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m copy \
  -a 'src=docker-storage-setup dest=/etc/sysconfig/docker-storage-setup'

ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m shell \
  -a 'wipefs /dev/sdb -a'

ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m shell \
  -a 'docker-storage-setup'
