for host in 10.0.0.6
do
  echo "Adding ${host} to known hosts ..."
  ssh-keyscan ${host} >> /root/.ssh/known_hosts
done

ansible all -i "10.0.0.6," --ask-pass -m authorized_key -a 'key={{ lookup("file", "/root/.ssh/id_rsa.pub") }} state=present user=root'

echo Starting and enabling NFS service
ansible all -i "10.0.0.6," -m systemd -a 'name=nfs state=started enabled=yes'

echo Creating mount points
ansible all -i "10.0.0.6," -m file -a 'path=/registry state=directory mode=777'

echo Exporting mount points
ansible all -i "10.0.0.6," -m lineinfile -a 'line="/registry 10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)" path=/etc/exports'
ansible all -i "10.0.0.6," -m shell -a 'exportfs -a'
