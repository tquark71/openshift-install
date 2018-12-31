cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdc1
VG=docker-vg
EOF

#parted -s /dev/xvdc rm 1
#parted -s /dev/xvdc mkpart primary ext4 0% 100%

docker-storage-setup
