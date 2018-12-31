cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdc1
VG=docker-vg
EOF

docker-storage-setup
