echo Starting and enabling NFS service
systemctl start nfs.service
systemctl enable nfs.service

echo Creating mount points
mkdir /registry
chmod 777 /registry
