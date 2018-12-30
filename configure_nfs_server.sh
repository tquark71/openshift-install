echo Starting and enabling NFS service
systemctl start nfs.service
systemctl enable nfs.service

echo Creating mount points
mkdir /registry
chmod 777 /registry

echo Exporting mount points
echo "/registry 10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports

exportfs -a
