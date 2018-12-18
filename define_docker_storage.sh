cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/sdb
VG=docker-vg
EOF

wipefd /dev/sdb -a

docker-storage-setup
