cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdb
VG=docker-vg
EOF

wipefs /dev/xvdb -a

docker-storage-setup
