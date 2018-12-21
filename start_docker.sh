cd ~/openshift-ansible
ansible -i openshift_inventory OSEv3 -a "systemctl start docker"
