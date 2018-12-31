cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdc1
VG=docker-vg
EOF

DEVICE=/dev/xvdc1

sfdisk --delete $DEVICE
sfdisk --list $DEVICE

mkfs -t ext4 $DEVICE

docker-storage-setup
