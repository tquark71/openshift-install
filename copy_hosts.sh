INVENTORY=../openshift-install/openshift_inventory

cd ~/openshift-ansible
ansible -i $INVENTORY OSEv3 -m copy -a "src=/etc/hosts dest=/etc"
